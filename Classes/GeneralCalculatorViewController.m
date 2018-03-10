//
//  GeneralCalculatorViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 16.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GeneralCalculatorViewController.h"
#import "PhysFormAppDelegate.h"
#import "Calculator.h"
#import "HistoryTableViewController.h"

#import <math.h>

#define kFastNull pow(10, -15)

#define kWidth1 53
#define kHeight1 45
#define kWidth2 106

#define kX1 2
#define kX2 kX1+kWidth1
#define kX3 kX2+kWidth1
#define kX4 kX3+kWidth1
#define kX5 kX4+kWidth1
#define kX6 kX5+kWidth1

#define kY8 0
#define kY7 kY8
#define kY6 kY7+kHeight1
#define kY5 kY6+kHeight1
#define kY4 kY5+kHeight1
#define kY3 kY4+kHeight1
#define kY2 kY3+kHeight1
#define kY1 kY2+kHeight1

@interface GeneralCalculatorViewController ()
@property BOOL alreadyDot;
@property BOOL alreadyRechenzeichen;
@property BOOL alreadyPlus;
@property BOOL alreadyMinus;
@property BOOL alreadyNumber;
@property BOOL deg;
@property BOOL help;
@end

@implementation GeneralCalculatorViewController

@synthesize sinFunc;
@synthesize cosFunc;
@synthesize tanFunc;
@synthesize second;
@synthesize constants;
@synthesize degOrRad;
@synthesize helpButton;

@synthesize calcStringView;
@synthesize ansView;
@synthesize calcString;
@synthesize alreadyDot;
@synthesize alreadyRechenzeichen;
@synthesize alreadyPlus;
@synthesize alreadyMinus;
@synthesize alreadyNumber;
@synthesize secondFunctions;
@synthesize digitsToDelete;
@synthesize historyIndex;

@synthesize historyCalcStrings;

@synthesize deg;
@synthesize help;

@synthesize answerDouble;
@synthesize buttonView;
@synthesize constButtonsView;

- (id)init {
	if ((self = [super init])) {
		// calcString holds the string which is going to be interpreted by the calculator
		calcString = [[NSMutableString alloc] initWithString: @"_"];
	}
	return self;
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewWillAppear: (BOOL)animated {
	[[self calcStringView] setText: [self calcString]];
}

/*
- (void)viewWillDisappear: (BOOL)animated {
	NSString *string = calcString;
	[[NSUserDefaults standardUserDefaults] setObject: string forKey: @"CalcString"];
}
*/
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	UIView *contentView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
	//contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	//contentView.backgroundColor = [UIColor colorWithRed:0.23f green:0.34f blue:0.23f alpha:1.0f];
	contentView.backgroundColor = [UIColor lightGrayColor];
	self.view = contentView;
	
    CGRect buttonViewFrame = [[self view] frame];
//    buttonViewFrame.size.height = self.view.frame.size.height - 95.0f;
//    buttonViewFrame.origin.y = 115.0f;
    buttonViewFrame.size.height = 365.0f;
    buttonViewFrame.origin.y = self.view.frame.size.height-buttonViewFrame.size.height+20.0f;

    NSLog(@"buttonViewFrame: %@", NSStringFromCGRect(buttonViewFrame));
    
    buttonView = [[UIView alloc] initWithFrame: buttonViewFrame];
//    [buttonView setBackgroundColor: [UIColor colorWithRed:0.23f green:0.34f blue:0.23f alpha:1.0f]];
//    [buttonView setBackgroundColor: [UIColor blackColor]];
    [buttonView setBackgroundColor: [UIColor clearColor]];
    [[self view] addSubview: buttonView];
    
    buttonViewFrame.size.height = buttonViewFrame.size.height-90;
    buttonViewFrame.origin.y = 600;
    constButtonsView = [[UIView alloc] initWithFrame: buttonViewFrame];
    [constButtonsView setBackgroundColor: [UIColor lightGrayColor]];
    [[self view] addSubview: constButtonsView];
    
    [self createConstButtons];
    
	// Coordinates for the UITextField
	CGFloat frameX0 = 0;
	CGFloat frameY0 = 20;
	CGFloat textWidth = 320;
	CGFloat textHeight = self.view.frame.size.height-buttonView.frame.size.height-20.0f-24.0f;
	UIFont *font = [UIFont fontWithName: @"ArialRoundedMTBold" size: 14.0];

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		frameX0 = 70;
		textWidth = 640;
		font = [UIFont fontWithName: @"ArialRoundedMTBold" size: 15.0];
	}
	// Make TextField
	CGRect textFrame = CGRectMake(frameX0, frameY0, textWidth, textHeight);
	calcStringView = [[UITextView alloc] initWithFrame: textFrame];
	[calcStringView setEditable: NO];
	[calcStringView setFont:font];
//    [calcStringView setBackgroundColor: [UIColor colorWithRed: 0.23f green: 0.34f blue: 0.23f alpha: 1.0f]];
    [calcStringView setBackgroundColor: [UIColor whiteColor]];
    [calcStringView setTextColor: [UIColor blackColor]];
	// Add TextField to the view
	[self.view addSubview: calcStringView];
	
	UIFont *ansFont = [UIFont fontWithName: @"ArialRoundedMTBold" size: 12.0];
	CGRect ansFrame = CGRectMake(frameX0, frameY0+textHeight+1, textWidth, 24);
	ansView = [[UILabel alloc] initWithFrame: ansFrame];
    //[ansView setBackgroundColor: [UIColor colorWithRed: 0.23f green: 0.34f blue: 0.23f alpha: 1.0f]];
	[ansView setBackgroundColor: [UIColor whiteColor]];
    [ansView setTextColor: [UIColor colorWithRed: 0.22 green: 0.33 blue: 0.53 alpha: 1.0]];
	[ansView setFont:ansFont];
	
    // Add TextField to the view
	[self.view addSubview: ansView];
	
	/*
	NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey: @"CalcString"];
	if (string != nil) {
		[calcString setString: string];
	}
	 */

	calcStringView.text = calcString;
	
	historyCalcStrings = [[NSMutableArray alloc] init];
	
//    NSDictionary *dummyDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: @"_", @"calcString", @"", @"solution", nil];
//	for (int i = 0; i < 10; i++) {
//		[historyCalcStrings addObject: dummyDictionary];
//    }
//    [dummyDictionary release];

	inputPosition = 0;
	
	self.deg = YES;
	[self createButtons];
	
}

- (void)createButtons {
	CGFloat floatX1 = kX1;
	CGFloat floatX2 = kX2;
	CGFloat floatX3 = kX3;
	CGFloat floatX4 = kX4;
	CGFloat floatX5 = kX5;
	CGFloat floatX6 = kX6;
	
	CGFloat floatY1 = kY1;
	CGFloat floatY2 = kY2;
	CGFloat floatY3 = kY3;
	CGFloat floatY4 = kY4;
	CGFloat floatY5 = kY5;
	CGFloat floatY6 = kY6;
	CGFloat floatY7 = kY7;
	
	CGFloat width1 = kWidth1-1;
	CGFloat height1 = kHeight1-1;
	
	CGFloat width2 = kWidth2;

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		width1 = kWidth1*2.0;
		height1 = kHeight1;
		
		floatX1 = kX1+70;
		floatX2 = floatX1+width1;
		floatX3 = floatX2+width1;
		floatX4 = floatX3+width1;
		floatX5 = floatX4+width1;
		floatX6 = floatX5+width1;
		
		floatY1 = kY1;
		floatY2 = kY2;
		floatY3 = kY3;
		floatY4 = kY4;
		floatY5 = kY5;
		floatY6 = kY6;
		floatY7 = kY7;
		
		width2 = kWidth2*2;
	}
	
	CGRect frame = CGRectMake(floatX3, floatY1, width2, height1);
	[self numberButtonWithFrame:frame title:@"0" andTag:0];
	
	frame = CGRectMake(floatX3, floatY2, width1, height1);
	[self numberButtonWithFrame:frame title:@"1" andTag:1];
	
	frame = CGRectMake(floatX4, floatY2, width1, height1);
	[self numberButtonWithFrame:frame title:@"2" andTag:2];
	
	frame = CGRectMake(floatX5, floatY2, width1, height1);
	[self numberButtonWithFrame:frame title:@"3" andTag:3];
	
	frame = CGRectMake(floatX3, floatY3, width1, height1);
	[self numberButtonWithFrame:frame title:@"4" andTag:4];
	
	frame = CGRectMake(floatX4, floatY3, width1, height1);
	[self numberButtonWithFrame:frame title:@"5" andTag:5];
	
	frame = CGRectMake(floatX5, floatY3, width1, height1);
	[self numberButtonWithFrame:frame title:@"6" andTag:6];
	
	frame = CGRectMake(floatX3, floatY4, width1, height1);
	[self numberButtonWithFrame:frame title:@"7" andTag:7];
	
	frame = CGRectMake(floatX4, floatY4, width1, height1);
	[self numberButtonWithFrame:frame title:@"8" andTag:8];
	
	frame = CGRectMake(floatX5, floatY4, width1, height1);
	[self numberButtonWithFrame:frame title:@"9" andTag:9];
	
	frame = CGRectMake(floatX5, floatY1, width1, height1);
	[self numberButtonWithFrame:frame title:@"." andTag:10];
	
	frame = CGRectMake(floatX6, floatY1, width1, height1);
    
	UIButton *calculate = [UIButton buttonWithType: UIButtonTypeSystem];
    calculate.backgroundColor = [UIColor whiteColor];
	calculate.frame = frame;
	[calculate setTitle: @"=" forState: UIControlStateNormal];
	[calculate addTarget: self action: @selector(calculatePressed:) forControlEvents: UIControlEventTouchUpInside];
    [self addGraditentToButton: calculate];
	[self.buttonView addSubview: calculate];
	
	frame = CGRectMake(floatX6, floatY2, width1, height1);
	[self functionButtonWithFrame:frame title:@"+" andTag:0];
	
	frame = CGRectMake(floatX6, floatY3, width1, height1);
	[self functionButtonWithFrame:frame title:@"-" andTag:1];
	
	frame = CGRectMake(floatX6, floatY4, width1, height1);
	[self functionButtonWithFrame:frame title:@"*" andTag:2];
	
	frame = CGRectMake(floatX6, floatY5, width1, height1);
	[self functionButtonWithFrame:frame title:@"/" andTag:3];
	
	frame = CGRectMake(floatX4, floatY5, width1, height1);
	[self functionButtonWithFrame:frame title:@"(" andTag:4];
	
	frame = CGRectMake(floatX5, floatY5, width1, height1);
	[self functionButtonWithFrame:frame title:@")" andTag:5];
	
	frame = CGRectMake(floatX6, floatY6, width1, height1);
	UIButton *deleteButton = [UIButton buttonWithType: UIButtonTypeSystem];
    deleteButton.backgroundColor = [UIColor whiteColor];
	deleteButton.frame = frame;
	[deleteButton setTitle: @"del" forState: UIControlStateNormal];
    [self addGraditentToButton: deleteButton];
	[deleteButton addTarget: self action: @selector(deleteButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: deleteButton];
	
	frame = CGRectMake(floatX4, floatY7, width1, height1);
	UIButton *historyButton = [UIButton buttonWithType: UIButtonTypeSystem];
    historyButton.backgroundColor = [UIColor whiteColor];
	historyButton.frame = frame;
	[historyButton setTitle: @"hist" forState: UIControlStateNormal];
    [self addGraditentToButton: historyButton];
	[historyButton addTarget: self action: @selector(historyButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: historyButton];
	
    frame = CGRectMake(floatX5, floatY6, width1, height1);
	UIButton *answerButton = [UIButton buttonWithType: UIButtonTypeSystem];
    answerButton.backgroundColor = [UIColor whiteColor];
	answerButton.frame = frame;
	[answerButton setTitle: @"ans" forState: UIControlStateNormal];
    [self addGraditentToButton: answerButton];
	[answerButton addTarget: self action: @selector(ansButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: answerButton];
    
	frame = CGRectMake(floatX5, floatY7, width1, height1);
	UIButton *backButton = [UIButton buttonWithType: UIButtonTypeSystem];
    backButton.backgroundColor = [UIColor whiteColor];
	backButton.frame = frame;
	[backButton setTitle: @"<-" forState: UIControlStateNormal];
    [self addGraditentToButton: backButton];
	[backButton addTarget: self action: @selector(backButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: backButton];
	
	frame = CGRectMake(floatX6, floatY7, width1, height1);
	UIButton *forwardButton = [UIButton buttonWithType: UIButtonTypeSystem];
    forwardButton.backgroundColor = [UIColor whiteColor];
	forwardButton.frame = frame;
	[forwardButton setTitle: @"->" forState: UIControlStateNormal];
    [self addGraditentToButton: forwardButton];
	[forwardButton addTarget: self action: @selector(forwardButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: forwardButton];
		
	frame = CGRectMake(floatX1, floatY1, width1, height1);
	//[self functionButtonWithFrame:frame title:@"pow(,)" andTag:6];
	[self functionButtonWithFrame:frame title:@"^" andTag:6];
	
	frame = CGRectMake(floatX2, floatY1, width1, height1);
	[self functionButtonWithFrame:frame title:@"e" andTag:7];
	
	frame = CGRectMake(floatX1, floatY4, width1, height1);
	[self functionButtonWithFrame:frame title:@"π" andTag:8];
	
//	frame = CGRectMake(floatX5, floatY6, width1, height1);
//	[self functionButtonWithFrame:frame title:@"ans" andTag:9];
	
	frame = CGRectMake(floatX4, floatY6, width1, height1);
	[self functionButtonWithFrame:frame title:@"42" andTag:10];
	
	frame = CGRectMake(floatX1, floatY2, width1, height1);
	[self functionButtonWithFrame:frame title:@"lg10" andTag:11];
	
	frame = CGRectMake(floatX2, floatY2, width1, height1);
	[self functionButtonWithFrame:frame title:@"lg2" andTag:12];
	
	frame = CGRectMake(floatX1, floatY3, width1, height1);
	[self functionButtonWithFrame:frame title:@"ln" andTag:13];
	
	frame = CGRectMake(floatX2, floatY3, width1, height1);
	[self functionButtonWithFrame:frame title:@"exp" andTag:14];
	
	frame = CGRectMake(floatX2, floatY4, width1, height1);
	[self functionButtonWithFrame:frame title:@"√" andTag:15];
	
	//frame = CGRectMake(floatX3, floatY7, width1, height1);
	//[self functionButtonWithFrame:frame title:@"," andTag:16];
	
    frame = CGRectMake(floatX2, floatY7, width1, height1);
	UIButton *mailButton = [UIButton buttonWithType: UIButtonTypeSystem];
    mailButton.backgroundColor = [UIColor whiteColor];
	mailButton.frame = frame;
	[mailButton setTitle: @"mail" forState: UIControlStateNormal];
    [self addGraditentToButton: mailButton];
	[mailButton addTarget: self action: @selector(mailButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: mailButton];
    
	frame = CGRectMake(floatX2, floatY6, width1, height1);
	constants = [UIButton buttonWithType: UIButtonTypeSystem];
    constants.backgroundColor = [UIColor whiteColor];
	constants.frame = frame;
	[constants setTitle: @"c" forState: UIControlStateNormal];
	[constants addTarget: self action: @selector(constPressed:) forControlEvents: UIControlEventTouchUpInside];
	[constants setBackgroundImage: nil forState: UIControlStateNormal];
    [self addGraditentToButton: constants];
	//[constants setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
	[self.buttonView addSubview: constants];
	
    frame = CGRectMake(floatX1, floatY6, width1, height1);
	second = [UIButton buttonWithType: UIButtonTypeSystem];
    second.backgroundColor = [UIColor whiteColor];
	second.frame = frame;
	[second setTitle: @"2nd" forState: UIControlStateNormal];
	[second addTarget: self action: @selector(secondPressed:) forControlEvents: UIControlEventTouchUpInside];
    [self addGraditentToButton: second];
    
	[self.buttonView addSubview: second];
    
    frame = CGRectMake(floatX3, floatY6, width1, height1);
	degOrRad = [UIButton buttonWithType: UIButtonTypeSystem];
    degOrRad.backgroundColor = [UIColor whiteColor];
	degOrRad.frame = frame;
    [degOrRad addTarget: self action: @selector(degOrRadPressed:) forControlEvents: UIControlEventTouchUpInside];
    [self addGraditentToButton: degOrRad];
    [self.buttonView addSubview: degOrRad];
    
	[self reCreateButtons];
	
}

- (void)numberButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag {
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    button.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    [button setFrame:frame];
	[button setTitle:bTitle forState:UIControlStateNormal];
	[button setTag:bTag];
    
//    [button setTitleColor: [UIColor colorWithRed: 0.22 green: 0.33 blue: 0.53 alpha: 1.0] forState: UIControlStateNormal];
//    [[button titleLabel] setFont: [UIFont boldSystemFontOfSize: 19.0f]];
        
//    [[button layer] setMasksToBounds: YES];
//    [[button layer] setBackgroundColor: [[UIColor colorWithRed: 0.9f green: 0.9f blue: 0.9f alpha: 1.0f] CGColor]];
//    [[button layer] setCornerRadius: 10.0f];
//    [[button layer] setBorderWidth: 2.0f];
//    [[button layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    
    [button addTarget: self action: @selector(buttonPressedDown:) forControlEvents: UIControlEventTouchDown];
	[button addTarget:self action:@selector(numberButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview:button];	
}

- (void)functionButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag {
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    [button setFrame:frame];
	[button setTitle:bTitle forState:UIControlStateNormal];
//    [button setTitleColor: [UIColor colorWithRed: 0.22 green: 0.33 blue: 0.53 alpha: 1.0] forState: UIControlStateNormal];
//    [[button titleLabel] setFont: [UIFont boldSystemFontOfSize: 18.0f]];
	[button setTag:bTag];
        
//    [[button layer] setMasksToBounds: YES];
//    [[button layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
//    [[button layer] setCornerRadius: 10.0f];
//    [[button layer] setBorderWidth: 2.0f];
//    [[button layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    
    [button addTarget: self action: @selector(buttonPressedDown:) forControlEvents: UIControlEventTouchDown];
	[button addTarget:self action:@selector(functionButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview:button];
}

- (void)addGraditentToButton: (UIButton *)myButton {
//    [myButton setTitleColor: [UIColor colorWithRed: 0.22 green: 0.33 blue: 0.53 alpha: 1.0] forState: UIControlStateNormal];
//    [[myButton titleLabel] setFont: [UIFont boldSystemFontOfSize: 19.0f]];
//    
//    [[myButton layer] setMasksToBounds: YES];
//    [[myButton layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
//    [[myButton layer] setCornerRadius: 10.0f];
//    [[myButton layer] setBorderWidth: 2.0f];
//    [[myButton layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    
    [myButton addTarget: self action: @selector(buttonPressedDown:) forControlEvents: UIControlEventTouchDown];
}

- (void)reCreateButtons {
	CGFloat floatX1 = kX1;
	CGFloat floatX2 = kX2;
	CGFloat floatX3 = kX3;
	//CGFloat floatX4 = kX4;
	//CGFloat floatX5 = kX5;
	//CGFloat floatX6 = kX6;
	
	//CGFloat floatY1 = kY1;
//	CGFloat floatY2 = kY2;
//	CGFloat floatY3 = kY3;
//	CGFloat floatY4 = kY4;
	CGFloat floatY5 = kY5;
//	CGFloat floatY6 = kY6;
	CGFloat floatY7 = kY7;
	
	CGFloat width1 = kWidth1-1;
	CGFloat height1 = kHeight1-1;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		width1 = kWidth1*2;
		height1 = kHeight1;
		
		floatX1 = kX1+70;
		floatX2 = floatX1+width1;
		floatX3 = floatX2+width1;
		//CGFloat floatX4 = kX4;
		//CGFloat floatX5 = kX5;
		//CGFloat floatX6 = kX6;
		
		//CGFloat floatY1 = kY1;
//		floatY2 = kY2;
//		floatY3 = kY3;
//		floatY4 = kY4;
		floatY5 = kY5;
//		floatY6 = kY6;
		floatY7 = kY7;

		//CGFloat width2 = kWidth2;
	}
	
	CGRect frame;
	frame = CGRectMake(floatX1, floatY5, width1, height1);
	if (self.secondFunctions == NO) {
		[self functionButtonWithFrame:frame title:@"sin" andTag:17];
	} else {
		[self functionButtonWithFrame:frame title:@"asin" andTag:17];
	}
	
	frame = CGRectMake(floatX2, floatY5, width1, height1);
	if (self.secondFunctions == NO) {
		[self functionButtonWithFrame:frame title:@"cos" andTag:18];
	} else {
		[self functionButtonWithFrame:frame title:@"acos" andTag:18];
	}
	
	frame = CGRectMake(floatX3, floatY5, width1, height1);
	if (self.secondFunctions == NO) {
		[self functionButtonWithFrame:frame title:@"tan" andTag:19];
	} else {
		[self functionButtonWithFrame:frame title:@"atan" andTag:19];
	}
	
    /*
	frame = CGRectMake(floatX1, floatY6, width1, height1);
	second = [UIButton buttonWithType: UIButtonTypeRoundedRect];
	second.frame = frame;
	[second setTitle: @"2nd" forState: UIControlStateNormal];
	[second addTarget: self action: @selector(secondPressed:) forControlEvents: UIControlEventTouchUpInside];
    [self addGraditentToButton: second];
    */
    if (self.secondFunctions == YES) {
		//[second	setBackgroundImage: [[UIImage imageNamed: @"blueButton.png"] stretchableImageWithLeftCapWidth: 12.0 topCapHeight: 0.0] forState: UIControlStateNormal];
		//[second setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        //[[second layer] setBackgroundColor: [[UIColor blueColor] CGColor]];
        [[second layer] setBorderColor: [[UIColor whiteColor] CGColor]];
    } else {
		//[second setBackgroundImage: nil forState: UIControlStateNormal];
		//[second setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
        //[[second layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
        [[second layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    }
    
	//[self.buttonView addSubview: second];
	
    
    if (self.deg == YES) {
		[degOrRad setTitle: @"Deg" forState: UIControlStateNormal];
	} else {
		[degOrRad setTitle: @"Rad" forState: UIControlStateNormal];
	}
	
	
	frame = CGRectMake(floatX1, floatY7, width1, height1);
	helpButton = [UIButton buttonWithType: UIButtonTypeSystem];
    helpButton.backgroundColor = [UIColor whiteColor];
	helpButton.frame = frame;
	[helpButton setTitle: @"help" forState: UIControlStateNormal];
	if (self.help == YES) {
		[helpButton setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
	} else {
		[helpButton setTitleColor: [UIColor grayColor] forState: UIControlStateNormal];
	}
	[helpButton addTarget: self action: @selector(helpButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
	[self.buttonView addSubview: helpButton];
}	

- (void)receivedFormula: (NSNotification *)note {
	NSDictionary *userInfo = [note userInfo];
	for (NSString *key in userInfo) {
		NSLog(@"%@ = %@", key, [userInfo objectForKey: key]);
	}
	[calcString setString: [userInfo objectForKey: @"Formula"]];
	[calcString appendFormat: @"_"];
	if (calcStringView != nil) {
		[calcStringView setText: calcString];
	}
}

- (void)createConstButtons {
    CGFloat floatX1 = kX1;
	CGFloat floatX2 = kX2;
	CGFloat floatX3 = kX3;
	CGFloat floatX4 = kX4;
	CGFloat floatX5 = kX5;
    CGFloat floatX6 = kX6;
    
    //CGFloat floatY1 = kY1;
//	CGFloat floatY2 = kY2;
//	CGFloat floatY3 = kY3;
	CGFloat floatY4 = kY4;
	CGFloat floatY5 = kY5;
	CGFloat floatY6 = kY6;
	CGFloat floatY7 = kY7;
    
    CGFloat width1 = kWidth1;
	CGFloat height1 = kHeight1;

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		width1 = kWidth1*2;
		height1 = kHeight1;
		
		floatX1 = kX1+70;
		floatX2 = floatX1+width1;
		floatX3 = floatX2+width1;
		floatX4 = floatX3+width1;
		floatX5 = floatX4+width1;
		floatX6 = floatX5+width1;
		
		//CGFloat floatY1 = kY1;
//		floatY2 = kY2;
//		floatY3 = kY3;
		floatY4 = kY4;
		floatY5 = kY5;
		floatY6 = kY6;
		floatY7 = kY7;
		
		//CGFloat width2 = kWidth2;
	}
	
    CGRect buttonFrame = CGRectMake(floatX1, floatY7, width1, height1);
	[self constButtonWithFrame:buttonFrame title:@"g" andTag:1];
    
    buttonFrame = CGRectMake(floatX2, floatY7, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"p" andTag:2];
	
    buttonFrame = CGRectMake(floatX3, floatY7, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"γ" andTag:3];
	
    buttonFrame = CGRectMake(floatX4, floatY7, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"ϑ₀" andTag:4];
	
    buttonFrame = CGRectMake(floatX5, floatY7, width1, height1);
	[self constButtonWithFrame:buttonFrame title:@"V₀" andTag:5];
	
    buttonFrame = CGRectMake(floatX6, floatY7, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"R" andTag:6];
	
    buttonFrame = CGRectMake(floatX1, floatY6, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"NA" andTag:7];
	
    buttonFrame = CGRectMake(floatX2, floatY6, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"k" andTag:8];
	
    buttonFrame = CGRectMake(floatX3, floatY6, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"ε₀" andTag:9];
	
    buttonFrame = CGRectMake(floatX4, floatY6, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"μ₀" andTag:10];
	
    buttonFrame = CGRectMake(floatX5, floatY6, width1, height1);
	[self constButtonWithFrame:buttonFrame title:@"c" andTag:11];
	
    buttonFrame = CGRectMake(floatX6, floatY6, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"σ" andTag:12];
	
    buttonFrame = CGRectMake(floatX1, floatY5, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"h" andTag:13];
	
    buttonFrame = CGRectMake(floatX2, floatY5, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"e" andTag:14];
	
    buttonFrame = CGRectMake(floatX3, floatY5, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"me" andTag:15];
	
    buttonFrame = CGRectMake(floatX4, floatY5, width1, height1);
	[self constButtonWithFrame:buttonFrame title:@"mp" andTag:16];
	
    buttonFrame = CGRectMake(floatX5, floatY5, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"mn" andTag:17];
	
    buttonFrame = CGRectMake(floatX6, floatY5, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"λc" andTag:18];
	
	buttonFrame = CGRectMake(floatX1, floatY4, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"ℏ" andTag:19];
	
	buttonFrame = CGRectMake(floatX2, floatY4, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"α" andTag:20];
	
	buttonFrame = CGRectMake(floatX3, floatY4, width1, height1);
    [self constButtonWithFrame:buttonFrame title:@"Rʜ" andTag:21];
	
}

- (void)constButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [button setFrame:frame];
    [button setTitle:bTitle forState:UIControlStateNormal];
    [button setTag:bTag];
    [button addTarget:self action:@selector(constButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [constButtonsView addSubview:button];
}

- (void)constButtonPressed:(id)sender {
    if (self.help == YES) {
        switch ([sender tag]) {
            case 1: [calcStringView setText: NSLocalizedString(@"Gravitationsbeschleunigung [m s⁻²]", @"")]; break;
            case 2: [calcStringView setText: NSLocalizedString(@"Normdruck [Pa]", @"")]; break;
            case 3: [calcStringView setText: NSLocalizedString(@"Gravitationskonstante [m³ kg⁻¹ s⁻²]", @"")]; break;
            case 4: [calcStringView setText: NSLocalizedString(@"absoluter Nullpunkt [C]", @"")]; break;
            case 5: [calcStringView setText: NSLocalizedString(@"molares Volumen idealer Gase [dm³ mol⁻¹]", @"")]; break;
            case 6: [calcStringView setText: NSLocalizedString(@"allgemeine Gaskonstante [J K⁻¹ mol⁻¹]", @"")]; break;
            case 7: [calcStringView setText: NSLocalizedString(@"Avogadrosche Konstante [mol⁻¹]", @"")]; break;
            case 8: [calcStringView setText: NSLocalizedString(@"Boltzmann-Konstante [J K⁻¹]", @"")]; break;
            case 9: [calcStringView setText: NSLocalizedString(@"elektrische Feldkonstante [A s V⁻¹ m⁻¹]", @"")]; break;
            case 10: [calcStringView setText: NSLocalizedString(@"magnetische Feldkonstante [V s A⁻¹ m⁻¹]", @"")]; break;
            case 11: [calcStringView setText: NSLocalizedString(@"Lichtgeschwindigkeit im Vakuum [m s⁻¹]", @"")]; break;
            case 12: [calcStringView setText: NSLocalizedString(@"Stefan-Boltzmann-Konstante [W m⁻² K⁻⁴]", @"")]; break;
            case 13: [calcStringView setText: NSLocalizedString(@"Plancksches Wirkungsquantum [J s]", @"")]; break;
            case 14: [calcStringView setText: NSLocalizedString(@"Elementarladung [C]", @"")]; break;
            case 15: [calcStringView setText: NSLocalizedString(@"Ruhemasse des Elektrons [kg]", @"")]; break;
            case 16: [calcStringView setText: NSLocalizedString(@"Ruhemasse des Proton [kg]", @"")]; break;
            case 17: [calcStringView setText: NSLocalizedString(@"Ruhemasse des Neutron [kg]", @"")]; break;
            case 18: [calcStringView setText: NSLocalizedString(@"Comptonwellenlänge [m]", @"")]; break;
            case 19: [calcStringView setText: NSLocalizedString(@"reduziertes Plancksches Wirkungsquantum [Js]", @"")]; break;
            case 20: [calcStringView setText: NSLocalizedString(@"Feinstrukturkonstante [1]", @"")]; break;
            case 21: [calcStringView setText: NSLocalizedString(@"Rydberg-Konstante [m⁻¹]", @"")]; break;
            default: break;
        }
    } else {
		NSArray *underScore = [calcString componentsSeparatedByString: @"_"];
		[calcString setString: [underScore objectAtIndex: 0]];
        switch ([sender tag]) {
            case 1: [calcString appendString: @"9.80665_"]; break;
            case 2: [calcString appendString: @"101325_"]; break;
            case 3: [calcString appendString: @"6.673e-11_"]; break;
            case 4: [calcString appendString: @"-273.15_"]; break;
            case 5: [calcString appendString: @"22.413996_"]; break;
            case 6: [calcString appendString: @"8.314472_"]; break;
            case 7: [calcString appendString: @"6.02214199e23_"]; break;
            case 8: [calcString appendString: @"1.3806503e-23_"]; break;
            case 9: [calcString appendString: @"8.85418782e-12_"]; break;
            case 10: [calcString appendString: @"pi*4e-7_"]; break;
            case 11: [calcString appendString: @"2.99792458e8_"]; break;
            case 12: [calcString appendString: @"5.670400e-8_"]; break;
            case 13: [calcString appendString: @"6.62606876e-34_"]; break;
            case 14: [calcString appendString: @"1.602176462e-19_"]; break;
            case 15: [calcString appendString: @"9.10938199e-31_"]; break;
            case 16: [calcString appendString: @"1.67262158e-27_"]; break;
            case 17: [calcString appendString: @"1.67492716e-27_"]; break;
            case 18: [calcString appendString: @"2.426310215e-12_"]; break;
            case 19: [calcString appendString: @"1.054571596e-34_"]; break;
            case 20: [calcString appendString: @"7.297352533e-3_"]; break;
            case 21: [calcString appendString: @"1.0973731568549e7_"]; break;
            default: [calcString appendString: @"_"]; break;
        }
        [UIView beginAnimations:@"moveConstButtonsDown" context:nil];
        [UIView setAnimationDuration: 0.5];
        CGRect frame = [[self constButtonsView] frame];
        frame.origin.y = 600;
        [constants setTitle:@"const" forState:UIControlStateNormal];
		[constants setBackgroundImage: nil forState: UIControlStateNormal];
		[constants setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
        [[self constButtonsView] setFrame: frame];
        [UIView commitAnimations];
		if ([underScore count] > 1) {
			[calcString appendString: [underScore objectAtIndex: 1]];
		}
		calcStringView.text = calcString;
		//digitsToDeleteAtPosition[inputPosition++] = 1;
		self.digitsToDelete = 1;
		self.alreadyRechenzeichen = NO;
		self.alreadyPlus = NO;
		self.alreadyMinus = NO;
	}
}

- (void)buttonPressedDown: (id)sender {
    [[sender layer] setBorderColor: [[UIColor blueColor] CGColor]];
}

#pragma mark -
#pragma mark Number Buttons

- (void)numberButtonPressed: (id)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if ([self help] == YES) {
		switch ([sender tag]) {
			case 0: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 0", @"")]; break;
			case 1: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 1", @"")]; break;
			case 2: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 2", @"")]; break;
			case 3: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 3", @"")]; break;
			case 4: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 4", @"")]; break;
			case 5: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 5", @"")]; break;
			case 6: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 6", @"")]; break;
			case 7: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 7", @"")]; break;
			case 8: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 8", @"")]; break;
			case 9: [[self calcStringView] setText:NSLocalizedString(@"Eingabe der Ziffer 9", @"")]; break;
			case 10: 
				[[self calcStringView] setText:NSLocalizedString(@"Eingabe eines Dezimaltrennungszeichens", @"")];
				break;
			default:
				break;
		}
	} else {
		NSArray *underScore = [[self calcString] componentsSeparatedByString:@"_"];
		[[self calcString] setString:[underScore objectAtIndex:0]];
        [self setAlreadyNumber: YES];
		switch ([sender tag]) {
			case 0: [[self calcString] appendString:@"0_"]; break;
			case 1: [[self calcString] appendString:@"1_"]; break;
			case 2: [[self calcString] appendString:@"2_"]; break;
			case 3: [[self calcString] appendString:@"3_"]; break;
			case 4: [[self calcString] appendString:@"4_"]; break;
			case 5: [[self calcString] appendString:@"5_"]; break;
			case 6: [[self calcString] appendString:@"6_"]; break;
			case 7: [[self calcString] appendString:@"7_"]; break;
			case 8: [[self calcString] appendString:@"8_"]; break;
			case 9: [[self calcString] appendString:@"9_"]; break;
			case 10: [[self calcString] appendString:@"._"]; 
				[self setAlreadyDot:YES];
                [self setAlreadyNumber: NO];
				break;
			default:
				break;
		}
		if ([underScore count] > 1) {
			[[self calcString] appendString:[underScore objectAtIndex:1]];
		}
		[[self calcStringView] setText:[self calcString]];
		[self setDigitsToDelete:1];
		[self setAlreadyRechenzeichen:NO];
		[self setAlreadyPlus:NO];
		[self setAlreadyMinus:NO];
	}

}

#pragma mark -
#pragma mark calcSigns

- (void)functionButtonPressed: (id)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
//	[[sender layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if ([self help] == YES) {
		switch ([sender tag]) {
			case 0: [[self calcStringView] setText:NSLocalizedString(@"Addition", @"")]; break;
			case 1: [[self calcStringView] setText:NSLocalizedString(@"Subtraktion", @"")]; break;
			case 2: [[self calcStringView] setText:NSLocalizedString(@"Multiplikation", @"")]; break;
			case 3: [[self calcStringView] setText:NSLocalizedString(@"Division", @"")]; break;
			case 4: [[self calcStringView] setText:NSLocalizedString(@"Eingabe einer öffnenden Klammer", @"")];
				break;
			case 5: [[self calcStringView] setText:NSLocalizedString(@"Eingabe einer schliessenden Klammer", @"")];
				break;
			case 6: [[self calcStringView] setText:NSLocalizedString(@"Potenz; um 2³ auszurechnen gibt man pow(2,3) ein", @"")]; 
				break;
			case 7: [[self calcStringView] setText:NSLocalizedString(@"Zehnerpotenz", @"")]; break;
			case 8: [[self calcStringView] setText:NSLocalizedString(@"Zahl Pi", @"")]; break;
			case 9: [[self calcStringView] setText:NSLocalizedString(@"Eingabe des letzten Ergebnisses", @"")];break;
			case 10: [[self calcStringView] setText:NSLocalizedString(@"Die Antwort auf die Frage nach dem Universum, dem Leben und dem Rest", @"")];
				break;
			case 11: [[self calcStringView] setText:NSLocalizedString(@"Logarithmus zur Basis Zehn", @"")]; break;
			case 12: [[self calcStringView] setText:NSLocalizedString(@"Logarithmus zur Basis 2", @"")]; break;
			case 13: [[self calcStringView] setText:NSLocalizedString(@"Natürlicher Logarithmus", @"")]; break;
			case 14: [[self calcStringView] setText:NSLocalizedString(@"Exponentialfunktion", @"")]; break;
			case 15: [[self calcStringView] setText:NSLocalizedString(@"Wurzelfunktion", @"")]; break;
			case 16: [[self calcStringView] setText:NSLocalizedString(@"Komma für pow(,)-Funktion; nur akriv, wenn 'pow(' im String vorhanden.", @"")]; break;
			case 17: [[self calcStringView] setText:NSLocalizedString(@"Sinus oder Arkussinus", @"")]; break;
			case 18: [[self calcStringView] setText:NSLocalizedString(@"Cosinus oder Arkuscosinus", @"")]; break;
			case 19: [[self calcStringView] setText:NSLocalizedString(@"Tangens oder Arkustangens", @"")]; break;
			default: break;
		}
	} else {
		NSArray *underScore = [[self calcString] componentsSeparatedByString:@"_"];
		[[self calcString] setString:[underScore objectAtIndex:0]];
		[self setDigitsToDelete:1];
		[self setAlreadyDot:NO];
		[self setAlreadyPlus:NO];
		[self setAlreadyMinus:NO];
		switch ([sender tag]) {
			case 0:
				if ([self alreadyRechenzeichen] == YES) {
					NSRange range;
					range.location = [[self calcString] length] - 1;
					range.length = 1;
					[[self calcString] deleteCharactersInRange:range];
				}
                if ([[self calcString] isEqualToString: @""]) {
                    [[self calcString] appendFormat: @"%lf", answerDouble];
                }
				[[self calcString] appendString:@"+_"];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:YES];
				[self setAlreadyMinus:NO];
				break;
			case 1:
				if ([self alreadyPlus] == YES || [self alreadyMinus] == YES) {
					NSRange range;
					range.location = [[self calcString] length] - 1;
					range.length = 1;
					[[self calcString] deleteCharactersInRange: range];
				}	
				if ([[self calcString] isEqualToString: @""]) {
                    [[self calcString] appendFormat: @"%lf", answerDouble];
                }
				[[self calcString] appendString: @"-_"];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyMinus:YES];
				[self setAlreadyPlus:NO];
				break;
			case 2:
				if ([self alreadyRechenzeichen] == YES) {
					NSRange range;
					range.location = [[self calcString] length] - 1;
					range.length = 1;
					[[self calcString] deleteCharactersInRange: range];
				}
				if ([[self calcString] isEqualToString: @""]) {
                    [[self calcString] appendFormat: @"%lf", answerDouble];
                }
				[[self calcString] appendString: @"*_"];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 3:
				if ([self alreadyRechenzeichen] == YES) {
					NSRange range;
					range.location = [[self calcString] length] - 1;
					range.length = 1;
					[[self calcString] deleteCharactersInRange: range];
				}
				if ([[self calcString] isEqualToString: @""]) {
                    [[self calcString] appendFormat: @"%lf", answerDouble];
                }
				[[self calcString] appendString: @"/_"];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 4:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*(_"];
                } else {
                    [[self calcString] appendString: @"(_"];
				}
                [self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 5:
				[[self calcString] appendString: @")_"];
				[self setAlreadyRechenzeichen:NO];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 6:
				//[[self calcString] appendString: @"pow(_,)"];
				if ([[self calcString] isEqualToString: @""]) {
                    [[self calcString] appendFormat: @"%lf", answerDouble];
                }
				[[self calcString] appendString: @"^_"];
				[self setAlreadyRechenzeichen:NO];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 7:
				[[self calcString] appendString: @"e_"];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 8:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*pi_"];
                } else {
                    [[self calcString] appendString: @"pi_"];
                }
				[self setAlreadyRechenzeichen:NO];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 9:
				break;
			case 10:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*42_"];
                } else {
                    [[self calcString] appendString: @"42_"];
				}
                [self setDigitsToDelete:2];
				[self setAlreadyDot:YES];
				[self setAlreadyRechenzeichen:NO];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 11:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*log10(_"];
                } else {
                    [[self calcString] appendString: @"log10(_"];
				}
                [self setDigitsToDelete:6];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 12:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*log2(_"];
                } else {
                    [[self calcString] appendString: @"log2(_"];
				}
                [self setDigitsToDelete:5];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 13:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*ln(_"];
                } else {
                    [[self calcString] appendString: @"ln(_"];
				}
                [self setDigitsToDelete:3];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 14:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*exp(_"];
                } else {
                    [[self calcString] appendString: @"exp(_"];
				}
                [self setDigitsToDelete:4];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 15:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*sqrt(_"];
                } else {
                    [[self calcString] appendString: @"sqrt(_"];
				}
                [self setDigitsToDelete:5];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 16:
				if ([[self calcString] rangeOfString: @"pow("].location != NSNotFound) 
					[[self calcString] appendString: @",_"];
				else
					[[self calcString] appendString: @"_"];
				[self setAlreadyRechenzeichen:NO];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 17:
				if ([self secondFunctions] == YES) {
                    if ([self alreadyNumber]) {
                        [[self calcString] appendString: @"*asin(_"];
                    } else {
                        [[self calcString] appendString: @"asin(_"];
					}
                    [self setDigitsToDelete:5];
				} else {
                    if ([self alreadyNumber]) {
                        [[self calcString] appendString: @"*sin(_"];
                    } else {
                        [[self calcString] appendString: @"sin(_"];
					}
                    [self setDigitsToDelete:4];
				}
				[self setAlreadyDot:NO];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 18:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*"];
                }
				if ([self secondFunctions] == YES) {
					[[self calcString] appendString: @"acos(_"];
					[self setDigitsToDelete:5];
				} else {
					[[self calcString] appendString: @"cos(_"];
					[self setDigitsToDelete:4];
				}
				[self setAlreadyDot:NO];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
			case 19:
                if ([self alreadyNumber]) {
                    [[self calcString] appendString: @"*"];
                }
				if ([self secondFunctions] == YES) {
					[[self calcString] appendString: @"atan(_"];
					[self setDigitsToDelete:5];
				} else {
					[[self calcString] appendString: @"tan(_"];
					[self setDigitsToDelete:4];
				}
				[self setAlreadyDot:NO];
				[self setAlreadyRechenzeichen:YES];
				[self setAlreadyPlus:NO];
				[self setAlreadyMinus:NO];
				break;
				
			default:
				break;
		}
		if ([underScore count] > 1) {
			[[self calcString] appendString:[underScore objectAtIndex:1]];
		}	
		[[self calcStringView] setText:[self calcString]];
        [self setAlreadyNumber: NO];
	}

}

#pragma mark -
#pragma mark changeButtons

- (void)secondPressed: (id)sender {
    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
	if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Wechsel zwischen Winkelfunktionen und deren Umkehrfunktionen", @"");
	} else {
		if (self.secondFunctions == NO) {
			self.secondFunctions = YES;
		} else {
			self.secondFunctions = NO;
		}
		[self reCreateButtons];
	}
}

- (void)constPressed: (id)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
    if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Wechsel der Tastenbelegung", @"");
	} else {
		[UIView beginAnimations:@"moveConstButtonView" context:nil];
        [UIView setAnimationDuration: 0.5];
        CGRect frame = [[self constButtonsView] frame];
        if (frame.origin.y > 400) {
            frame.origin.y = buttonView.frame.origin.y + 90.0f;
            [constants setTitle:@"done" forState:UIControlStateNormal];
//			[constants setBackgroundImage: [[UIImage imageNamed: @"blueButton.png"] stretchableImageWithLeftCapWidth: 12.0 topCapHeight: 0.0] forState: UIControlStateNormal];
//			[constants setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        } else {
            frame.origin.y = 600;
            [constants setTitle:@"c" forState:UIControlStateNormal];
//			[constants setBackgroundImage: nil forState: UIControlStateNormal];
//			[constants setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
            [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
        }
        [[self constButtonsView] setFrame: frame];
        [UIView commitAnimations];
	}
}

- (void)degOrRadPressed: (id)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
	if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Umschalten zwischen Degrees und Radian", @"");
	} else {
		if (self.deg == NO) {
			self.deg = YES;
		} else {
			self.deg = NO;
		}
		[self reCreateButtons];
	}
}

- (void)helpButtonPressed: (id)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
	if (self.help == NO) {
		self.help = YES;
		calcStringView.text = NSLocalizedString(@"Bitte drücke die Taste, die ich Dir erklären soll. (Zum Beenden nochmal help drücken)", @"");
	} else {
		self.help = NO;
		calcStringView.text = calcString;
	}
	[self reCreateButtons];
}

- (void)deleteButtonPressed: (id)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Entfernung des Zeichens vor dem Unterstrich", @"");
	} else {
		if ([calcString length] > 1) {
			NSArray *underScore = [calcString componentsSeparatedByString: @"_"];
			[calcString setString: [underScore objectAtIndex: 0]];

			// delete the "_" at the end of the string
			//[calcString deleteCharactersInRange: [calcString rangeOfString: @"_"]];
			
			// find range of string to delete
			NSRange range;
			range.location = [calcString length] - 1;
			range.length = 1;
			
			// get substing which is to delete
			NSString *substring = [calcString substringWithRange: range];
			
			if ([calcString length] > 1) {
				
				// check if there are some special characters in the substring and reset some bool values if neccessary
				if ([substring rangeOfString: @"."].location != NSNotFound) 
					self.alreadyDot = NO;
				if ([substring rangeOfString: @"-"].location != NSNotFound) { 
					self.alreadyMinus = NO;
					self.alreadyRechenzeichen = NO;
				}
				if ([substring rangeOfString: @"+"].location != NSNotFound) { 
					self.alreadyPlus = NO;
					self.alreadyRechenzeichen = NO;
				}
				if ([substring rangeOfString: @"*"].location != NSNotFound) { 
					self.alreadyRechenzeichen = NO;
				}
				if ([substring rangeOfString: @"/"].location != NSNotFound) { 
					self.alreadyRechenzeichen = NO;
				}
				
				// delete substring from calcString
				[calcString deleteCharactersInRange: range];
				[calcString appendString: @"_"];
			} else {
				[calcString setString: @"_"];
			}
			
			if ([underScore count] > 1) {
				[calcString appendString: [underScore objectAtIndex: 1]];
			}
			calcStringView.text = calcString;
			self.digitsToDelete = 1;
            [self setAlreadyNumber: NO];
		}
	}
}

- (void)backButtonPressed: (id)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Ein Zeichen nach links im Eingabestring", @"");
	} else {
		NSArray *underScore = [calcString componentsSeparatedByString: @"_"];
		[calcString setString: [underScore objectAtIndex: 0]];

		if (![calcString isEqualToString: @""]) {
			NSRange range;
			range.location = [calcString length] - 1;
			range.length = 1;
			//digitsToDeleteAtPosition[inputPosition--];
		
			NSString *substring = [calcString substringWithRange: range];
		
			[calcString deleteCharactersInRange: range];
			[calcString appendString: @"_"];
			[calcString appendString: substring];	
		} else {
			[calcString appendString: @"_"];
		}
		
		if ([underScore count] > 1) {
			[calcString appendString: [underScore objectAtIndex: 1]];
		}
		calcStringView.text = calcString;
		self.digitsToDelete = 1;
		self.alreadyDot = NO;
		self.alreadyRechenzeichen = NO;
        [self setAlreadyNumber: NO];
	}
}

- (void)forwardButtonPressed: (id)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Ein Zeichen nach rechts im Eingabestring", @"");
	} else {
		NSArray *underScore = [calcString componentsSeparatedByString: @"_"];
		[calcString setString: [underScore objectAtIndex: 0]];
		
		if ([underScore count] > 1) {
			//NSMutableString *dummyString = [underScore objectAtIndex: 1];
			NSMutableString *dummyString = [[NSMutableString alloc] initWithString: [underScore objectAtIndex: 1]];
			NSRange range;
			range.location = 0;
			range.length = 1;
			NSString *substring;
			
			if (![dummyString isEqualToString: @""]) {
				substring = [dummyString substringWithRange: range];
				[dummyString deleteCharactersInRange: range];
				[calcString appendString: substring];
			}
		
			[calcString appendString: @"_"];
			[calcString appendString: dummyString];
		}
		self.digitsToDelete = 1;
		self.alreadyDot = NO;
		self.alreadyRechenzeichen = NO;
        [self setAlreadyNumber: NO];
		calcStringView.text = calcString;
	}
}

- (void)historyButtonPressed: (id)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
//    if (self.help == YES) {
//		calcStringView.text = NSLocalizedString(@"Zugriff auf die letzten fünf Berechnungen", @"");
//	} else {
//		if (historyIndex < 0) {
//			self.historyIndex = 9;
//		}
//		[calcString setString: [[historyCalcStrings objectAtIndex: historyIndex] objectForKey: @"calcString"]];
//		calcStringView.text = calcString;
//		historyIndex--;
//	}
    HistoryTableViewController *historyTableViewController = [[HistoryTableViewController alloc] initWithStyle: UITableViewStylePlain];
    [historyTableViewController setCalcDictArray: [self historyCalcStrings]];
    [historyTableViewController setDelegate: self];
    [historyTableViewController setIsCalcHistory: YES];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: historyTableViewController];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [navigationController setModalPresentationStyle: UIModalPresentationPageSheet];
    }
    [self presentModalViewController: navigationController animated: YES];
}

- (void)ansButtonPressed: (id)sender {
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
       HistoryTableViewController *historyTableViewController = [[HistoryTableViewController alloc] initWithStyle: UITableViewStylePlain];
    [historyTableViewController setCalcDictArray: [self historyCalcStrings]];
    [historyTableViewController setDelegate: self];
    [historyTableViewController setIsCalcHistory: NO];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: historyTableViewController];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [navigationController setModalPresentationStyle: UIModalPresentationPageSheet];
    }
    [self presentModalViewController: navigationController animated: YES];
}

- (void)mailButtonPressed: (id)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if ([MFMailComposeViewController canSendMail]) {
	} else {
        return;
	}
	MFMailComposeViewController *mailComposerViewController = [[MFMailComposeViewController alloc] init];
	[mailComposerViewController setMailComposeDelegate: self];
//	[mailComposerViewController setToRecipients: 
//     [NSArray arrayWithObjects: @"dominik.hauser@dasdom.de", nil]];
	[mailComposerViewController setSubject: NSLocalizedString(@"Meine letzte Berechnung", nil)];
    NSString *body;
    if ([[self historyCalcStrings] count] > 0) {
        NSDictionary *lastCalculation = [[self historyCalcStrings] objectAtIndex: 0];
        body = [NSString stringWithFormat: @"%@\n=%@", [lastCalculation objectForKey: @"calcString"], [lastCalculation objectForKey: @"solution"]];
    } else {
        body = NSLocalizedString(@"Keine Berechnungen bisher durchgeführt.", nil);
    }
	[mailComposerViewController setMessageBody: body isHTML: NO];
	[self presentModalViewController: mailComposerViewController animated: YES];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated: YES];
}

- (void)calculatePressed: (id)sender {
    // [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
//	[[sender layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
    
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		calcStringView.text = NSLocalizedString(@"Durchführung der Berechnung", @"");
	} else {
        [calcString deleteCharactersInRange: [calcString rangeOfString: @"_"]];
		NSInteger indexForSubstring = 0;
        NSString *lastCharString;
        if (![calcString isEqualToString:@""]) {
            lastCharString = [calcString substringFromIndex: [calcString length]-1];
        }
        NSSet *calcSignsSet = [NSSet setWithObjects: @"*", @"-", @"+", @"/", nil];
        if ([calcSignsSet containsObject: lastCharString]) {
            [self calcSignAtTheEnd];
            return;
        }
		if ([calcString rangeOfString: @"("].location != NSNotFound) {
			Calculator *calculator = [[Calculator alloc] initWithDeg:YES];
			NSRange range = [calculator getRangeOfSubstringFromString: calcString bySearchingFor: @"("];
			indexForSubstring = range.location + range.length;
		}
		if (indexForSubstring > [calcString length]) {
			[self nichtGenugKlammern];
			[calcString appendFormat: @"_"];
		} else if ([calcString rangeOfString: @"pow("].location != NSNotFound && 
				   [calcString rangeOfString: @","].location == NSNotFound) {
			[self kommaFehlt];
			[calcString appendFormat: @"_"];
		} else {
			[self calculateString: [self calcString]];
//            for (int i = 9; i > 0; i--) {
//                [historyCalcStrings replaceObjectAtIndex: i withObject: [historyCalcStrings objectAtIndex: i-1]];
//            }
            NSString *tempString = [[NSString alloc] initWithFormat: @"%@", calcString];
            NSDictionary *historyDict = @{@"calcString": tempString, @"solution": @(answerDouble)};
//            [historyCalcStrings replaceObjectAtIndex: 0 withObject: historyDict];
            [historyCalcStrings insertObject: historyDict atIndex: 0];
            if ([[self historyCalcStrings] count] > 50) {
                [[self historyCalcStrings] removeLastObject];
            }
            self.historyIndex = 9;
            
            [[self calcString] setString: @"_"];
		}
        [self setAlreadyNumber: NO];
	}
} 

- (void)calculateString:(NSString *)cString {
	NSString *calcStringOrg = [[NSString alloc] initWithString: cString];
	
	Calculator *calculator = [[Calculator alloc] initWithDeg:deg];
	NSDecimalNumber *sum = [calculator calculateString: cString];
	
	answerDouble = [sum doubleValue];
	if ((answerDouble < 100000 && answerDouble > 0.001) || 
		(answerDouble > -100000 && answerDouble < -0.001)) {
		calcStringView.text = [NSString stringWithFormat: @"%@\nans = %.10lf", calcStringOrg, [sum doubleValue]];
		[ansView setText:[NSString stringWithFormat: @" ans = %.10lf", [sum doubleValue]]]; 
	} else {
		calcStringView.text = [NSString stringWithFormat: @"%@\nans = %.10e", calcStringOrg, [sum doubleValue]];
		[ansView setText:[NSString stringWithFormat: @" ans = %.10e", [sum doubleValue]]];
	}
	self.alreadyDot = NO;
}

#pragma mark -
#pragma mark alerts

- (void)nichtGenugKlammern {
	klammerAlert = [[UIAlertView alloc] 
					 initWithTitle: @"Klammer" 
					 message: @"Warnung: Da sind mehr oeffnende Klammern als schliessende Klammern" 
					 delegate: self 
					 cancelButtonTitle: nil 
					 otherButtonTitles: @"OK", nil];
	klammerAlert.delegate = self;
	[klammerAlert show];
}

- (void)kommaFehlt {
	kommaAlert = [[UIAlertView alloc] 
					initWithTitle: @"Komma" 
					message: @"Warnung: pow-Funktion ohne Komma. Die pow-Funktion braucht zwei Argumente." 
					delegate: self 
					cancelButtonTitle: nil 
					otherButtonTitles: @"OK", nil];
	kommaAlert.delegate = self;
	[kommaAlert show];
}

- (void)calcSignAtTheEnd {
	UIAlertView *calcSignAlert = [[UIAlertView alloc] 
                  initWithTitle: @"Rechenzeichen" 
                  message: @"Rechnung endet mit einen Rechenzeichen." 
                  delegate: self 
                  cancelButtonTitle: nil 
                  otherButtonTitles: @"OK", nil];
	calcSignAlert.delegate = self;
	[calcSignAlert show];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}


@end
