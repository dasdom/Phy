//
//  DestignatedCalculaterViewController.m
//  PhysForm
//
//  Created by Dominik Hauser on 30.04.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DestignatedCalculaterViewController.h"
#import "drawTest.h"


@implementation DestignatedCalculaterViewController

@synthesize text1;
@synthesize text2;
@synthesize text3;
@synthesize text4;
@synthesize text5;
@synthesize text6;
@synthesize stringForFieldsAbove;
@synthesize stringForFieldsBelow;
@synthesize calculate;
@synthesize resultLabel;
@synthesize labelNull;
@synthesize stringForLabelNull;
@synthesize unitLabel;
@synthesize stringForUnitLabel;
@synthesize textFile;
@synthesize moreInfo;
//@synthesize imageView;
@synthesize nameOfTheImage;
@synthesize squarePara;
@synthesize bruchstrich;
@synthesize constants;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Creates a text field to hold a parameter
- (UITextField *)createTextFieldWithFrame: (CGRect)frame andPlaceholer: (NSString *) placeholder {
	// Allocate temporary text field
	UITextField *tempTextField = [[UITextField alloc] initWithFrame: frame];
	
	tempTextField.backgroundColor = [UIColor whiteColor];
	tempTextField.placeholder = placeholder;
	
	// Get the constant if there is a one with the name of the placeholder in the dictionary
	tempTextField.text = [self.constants objectForKey: placeholder];
	 
	// Set some style parameters
	tempTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	tempTextField.returnKeyType = UIReturnKeyDone;
	tempTextField.borderStyle = UITextBorderStyleBezel;
	tempTextField.adjustsFontSizeToFitWidth = YES;
	
	return tempTextField;
}

// Returns a dictionary with constants to fill into text fields 
- (NSDictionary *)makeDictionaryWithConstants {
	//NSArray *keys = [NSArray arrayWithObjects: @"minusEins", @"nullPunktFuenf", @"nullPunktSechsSieben", @"einsPunktFuenf", @"zwei", @"drei", @"g",    @"gamma",    @"R", @"epsilonNull", @"muNull", nil];
	//NSArray *objects = [NSArray arrayWithObjects: @"-1",     @"0.5",            @"0.67",                 @"1.5",            @"2.0",  @"3.0",  @"9.81", @"6.67e-11", @"8.314", @"8.85e-12", @"1.2566e-6", nil];
	
	NSArray *keys = @[@"minusEins", @"nullPunktFuenf", @"nullPunktSechsSieben", @"einsPunktFuenf", @"zwei", @"drei", @"g",    @"gamma",    @"R", @"epsilonNull", @"muNull"];
	NSArray *objects = @[@"-1",     @"0.5",            @"0.67",                 @"1.5",            @"2.0",  @"3.0",  @"9.81", @"6.67e-11", @"8.314", @"8.85e-12", @"1.2566e-6"];
	NSDictionary *dict = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];
	return dict;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	// Define the contentView for the view
	UIView *contentView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor whiteColor];
	self.view = contentView;
	
	// Get the dictionary for the constants
	constants = [[NSDictionary alloc] initWithDictionary: [self makeDictionaryWithConstants]];
	
	CGFloat bruchstrichWidth = 0;
	
	if ([stringForFieldsAbove count] > 0) {
		// The y-position depends on the existense of fields below the bruchstrich
		CGFloat frameY = 50;
		if ([stringForFieldsBelow count] == 0) 
			frameY = 65;
		bruchstrichWidth = 80;
		CGRect frame = CGRectMake(50,frameY,80,25);
		self.text1 = [self createTextFieldWithFrame: frame andPlaceholer: [stringForFieldsAbove objectAtIndex: 0]];
		text1.delegate = self;
		[self.view addSubview: text1];
	}
	
	if ([stringForFieldsAbove count] > 1) {
		// The y-position depends on the existense of fields below the bruchstrich
		CGFloat frameY = 50;
		if ([stringForFieldsBelow count] == 0) 
			frameY = 65;
		bruchstrichWidth = 165;
		CGRect frame = CGRectMake(135,frameY,80,25);
		self.text2 = [self createTextFieldWithFrame: frame andPlaceholer: [stringForFieldsAbove objectAtIndex: 1]];
		text2.delegate = self;
		[self.view addSubview: text2];
	}
	
	if ([stringForFieldsAbove count] > 2) {
		// The y-position depends on the existense of fields below the bruchstrich
		CGFloat frameY = 50;
		if ([stringForFieldsBelow count] == 0) 
			frameY = 65;
		bruchstrichWidth = 250;
		CGRect frame = CGRectMake(220,frameY,80,25);
		self.text3 = [self createTextFieldWithFrame: frame andPlaceholer: [stringForFieldsAbove objectAtIndex: 2]];
		text3.delegate = self;
		[self.view addSubview: text3];
	}
	if ([stringForFieldsBelow count] > 0) {
		// The x-position depends of the number of fields above and below
		CGFloat frameX = 50;
		if ([stringForFieldsBelow count] == 1) {
			if ([stringForFieldsAbove count] == 3) {
				frameX = 135;
			} else if ([stringForFieldsAbove count] == 2) {
				frameX = 90;
            }
        }
		CGRect frame = CGRectMake(frameX,81,80,25);
		self.text4 = [self createTextFieldWithFrame: frame andPlaceholer: [stringForFieldsBelow objectAtIndex: 0]];
		text4.delegate = self;
		[self.view addSubview: text4];
	} else {
		bruchstrichWidth = 0;
	}
	
	if ([stringForFieldsBelow count] > 1) {
		bruchstrichWidth = 165;
		CGRect frame = CGRectMake(135,81,80,25);
		self.text5 = [self createTextFieldWithFrame: frame andPlaceholer: [stringForFieldsBelow objectAtIndex: 1]];
		text5.delegate = self;
		[self.view addSubview: text5];
	}
	
	if ([stringForFieldsBelow count] > 2) {
		bruchstrichWidth = 250;
		CGRect frame = CGRectMake(220,81,80,25);
		self.text6 = [self createTextFieldWithFrame: frame andPlaceholer: [stringForFieldsBelow objectAtIndex: 2]];
		text6.delegate = self;
		[self.view addSubview: text6];
	}
	
	// If there ia a stringForLabelNull all parts for a calculator are set
	if (self.stringForLabelNull != nil) {
		// The button
		CGFloat frameX = 200.0f;
		CGFloat frameY = 5.0f;
		CGRect frame = CGRectMake(frameX, frameY, 80.0f, 40.0f);
		calculate = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		calculate.frame = frame;
		[calculate setTitle: @"Calculate" forState: UIControlStateNormal];
		[calculate addTarget: self action: @selector(doCalculation:) forControlEvents: UIControlEventTouchUpInside];
		[self.view addSubview: calculate];
	
		// The result
		frame = CGRectMake(20, 120, 190, 25);
		resultLabel = [[UILabel alloc] initWithFrame: frame];
		resultLabel.text = NSLocalizedString(@"(erlaubte Zeichen: -123456789.e)", @"");
		[resultLabel setAdjustsFontSizeToFitWidth: YES];
		[resultLabel setTextAlignment: UITextAlignmentRight];
		//[resultLabel setBackgroundColor: [UIColor grayColor]];
		[self.view addSubview: resultLabel];
	
		// The left side
		frame = CGRectMake(10, 65, 30, 30);
		labelNull = [[UILabel alloc] initWithFrame: frame];
		labelNull.text = stringForLabelNull;
		//labelNull.backgroundColor = [UIColor grayColor];
		[self.view addSubview: labelNull];
	
		// The unit of the result
		frame = CGRectMake(220, 120, 50, 25);
		unitLabel = [[UILabel alloc] initWithFrame: frame];
		[self.view addSubview: unitLabel];
	}
	
	if (self.textFile != nil) {
		// There is more info to print
		CGFloat frameX;
		CGFloat frameY;
		CGFloat frameWidth;
		CGFloat frameHeight;
		CGRect textFrame;
		if ([self interfaceOrientation] == UIInterfaceOrientationPortrait) {
			if (self.stringForLabelNull != nil) {
				frameX = 10;
				frameY = 180;
				frameWidth = 300;
				frameHeight = 220;
			} else {
				frameX = 10;
				frameY = 60;
				frameWidth = 300;
				frameHeight = 340;
			}
		} else
//            if ([self interfaceOrientation] == UIInterfaceOrientationLandscapeLeft ||
//				   [self interfaceOrientation] == UIInterfaceOrientationLandscapeRight) {
			if (self.stringForLabelNull != nil) {
				frameX = 10;
				frameY = 160;
				frameWidth = 460;
				frameHeight = 200;
			} else {
				frameX = 10;
				frameY = 50;
				frameWidth = 460;
				frameHeight = 240;
//			}
		}
		textFrame = CGRectMake(frameX, frameY, frameWidth, frameHeight);
		moreInfo = [[UITextView alloc] initWithFrame: textFrame];
		moreInfo.text = self.textFile;
		moreInfo.editable = NO;
		UIFont *font = [UIFont fontWithName: @"ArialRoundedMTBold" size: 14.0];
		moreInfo.font = font;
		[self.view addSubview: moreInfo];
		 
	}
	
	if (self.nameOfTheImage != nil) {
		// There is an image to draw
		UIImage *tempImage = [UIImage imageNamed: self.nameOfTheImage];
		// Calculate the size of the image to set the right imageFrame
		CGSize tempSize = [tempImage size];
		CGRect imageFrame = CGRectMake(10, 10, tempSize.width, tempSize.height);
		UIImageView *imageView = [[UIImageView alloc] initWithFrame: imageFrame];
		imageView.image = tempImage;
		[self.view addSubview: imageView];
	}
	
	// Set the superscript if there is a square in the formula
	if (self.squarePara > 0 && self.squarePara < 7) {
		CGFloat frameX = 0;
		CGFloat frameY = 0;
		if (self.squarePara < 4) {
			frameX = 50 + squarePara*82 - 5;
			frameY = 45;
			if ([stringForFieldsBelow count] == 0)
				frameY = 60;
		} else { 
			if ([stringForFieldsBelow count] == 1 && [stringForFieldsAbove count] == 3)
				frameX = 50 + (squarePara-2)*82 -5;
			else 
				frameX = 50 + (squarePara-3)*82 - 5;
			frameY = 75;
		}
		CGRect superFrame = CGRectMake(frameX, frameY, 10, 15);
		UILabel *superScript = [[UILabel alloc] initWithFrame: superFrame];
		superScript.text = @"2";
		[self.view addSubview: superScript];
	}
	
	if (bruchstrichWidth > 0) {
		CGRect frame = CGRectMake(50, 77, bruchstrichWidth, 2);
		drawTest *testView = [[drawTest alloc] initWithFrame: frame];
		[self.view addSubview: testView];
	}
}



/*
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	//[self loadView];
	[self.view setNeedsDisplay];
}
*/

 
- (BOOL)textFieldShouldReturn: (UITextField *)theTextField {
	// Hide the keyboard when done
	[theTextField resignFirstResponder];
	return YES;
}

- (void)doCalculation: (id)sender {
	
	NSDecimalNumber *para[6];
	
	// Get the numbers from the text fields.
	if ([stringForFieldsAbove count] > 0) 
		para[0] = [self decimalNumberFromDouble: text1.text];
	else
		para[0] = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1];
	
	if ([stringForFieldsAbove count] > 1) 
		para[1] = [self decimalNumberFromDouble: text2.text];
	else
		para[1] = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1];
	
	if ([stringForFieldsAbove count] > 2) 
		para[2] = [self decimalNumberFromDouble: text3.text];
	else
		para[2] = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1];
	
	if ([stringForFieldsBelow count] > 0) 
		para[3] = [self decimalNumberFromDouble: text4.text];
	else
		para[3] = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1];
	
	if ([stringForFieldsBelow count] > 1) 
		para[4] = [self decimalNumberFromDouble: text5.text];
	else
		para[4] = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1];
	
	if ([stringForFieldsBelow count] > 2) 
		para[5] = [self decimalNumberFromDouble: text6.text];
	else
		para[5] = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1];
	
	NSString *result;
	NSDecimalNumber *NaN = [NSDecimalNumber notANumber];
	// square a parameter if neccessary
	if (squarePara > 0 && squarePara < 7)
		para[squarePara-1] = [para[squarePara-1] decimalNumberByMultiplyingBy: para[squarePara-1]];
	BOOL validInput = YES;
	NSComparisonResult compResult;
	for (int i = 0; i < 6; i++) {
		compResult = [para[i] compare: NaN];
		if (compResult == 0)
			validInput = NO;
	}
	if (validInput == NO) {
		result = @"falsches Format";
	} else {
		NSDecimalNumber *productAbove = [para[0] decimalNumberByMultiplyingBy: [para[1] decimalNumberByMultiplyingBy: para[2]]];
		NSDecimalNumber *productBelow = [para[3] decimalNumberByMultiplyingBy: [para[4] decimalNumberByMultiplyingBy: para[5]]];
		
		// Get the result with format
		result = [[NSString alloc] initWithFormat: @"= %.5e", [[productAbove decimalNumberByDividingBy: productBelow] doubleValue]];
	}
	
	resultLabel.text = result;
	unitLabel.text = stringForUnitLabel;

	
}


- (NSDecimalNumber *)decimalNumberFromDouble: (NSString *)string {
	if (string == nil || [string isEqualToString: @""])
		return (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 1]; 
		
	NSArray *numberOne = [string componentsSeparatedByString: @"e"];
	if ([numberOne count] > 1) {
		NSDecimalNumber *dummyNumber = [numberOne objectAtIndex: 0];
		double mantisse = [dummyNumber doubleValue];
		BOOL isNegative = NO;
		if (mantisse < 0) {
			isNegative = YES;
			mantisse *= -1;
		}
		dummyNumber = [numberOne objectAtIndex: 1];
		int e = [dummyNumber intValue];
		NSArray *numberTwo = [[numberOne objectAtIndex: 0] componentsSeparatedByString: @"."];
		if ([numberTwo count] > 1) {
			dummyNumber = [numberTwo objectAtIndex: 1];
			int afterDot = [dummyNumber integerValue];
			if (afterDot > 0 && afterDot < 10) {
				mantisse *= 10;
				e -= 1;
			} else if (afterDot < 100) {
				mantisse *= 100;
				e -= 2;
			} else if (afterDot < 1000) {
				mantisse *= 1000;
				e -= 3;
			} else {
				mantisse *= 10000;
				e -= 4;
			}
		}
		unsigned long long m = (unsigned long long) mantisse;
		
		return (NSDecimalNumber *)[NSDecimalNumber decimalNumberWithMantissa: m exponent: e isNegative: isNegative];
	} else 
		return (NSDecimalNumber *)[NSDecimalNumber decimalNumberWithString: string];
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




@end
