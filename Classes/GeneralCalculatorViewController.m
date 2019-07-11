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
#import "GeneralCalculatorView.h"
#import "ConstantsTableViewController.h"

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

static NSString * const DDHPlus = @"+";
static NSString * const DDHMinus = @"-";
static NSString * const DDHTimes = @"*";
static NSString * const DDHDivide = @"/";

@interface GeneralCalculatorViewController ()
@property BOOL alreadyDot;
@property BOOL alreadyRechenzeichen;
@property BOOL alreadyPlus;
@property BOOL alreadyMinus;
@property BOOL alreadyNumber;
@property BOOL deg;
@property BOOL help;
//@property (nonatomic) NSMutableArray *calcElementsArray;
@end

@implementation GeneralCalculatorViewController

@synthesize deg;

- (instancetype)init {
    self = [super init];
	if (self) {
        self.calcString = [[NSMutableString alloc] initWithString: @"_"];
        self.historyCalcStrings = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)loadView {
    self.view = [[GeneralCalculatorView alloc] init];
}

- (GeneralCalculatorView *)contentView {
    return (GeneralCalculatorView *)self.view;
}

- (void)viewWillAppear: (BOOL)animated {
    [super viewWillAppear:animated];
    
    self.calcStringView.text = self.calcString;
}

- (UITextView *)calcStringView {
    return [self contentView].calculationStringTextView;
}

- (void)receivedFormula: (NSNotification *)note {
	NSDictionary *userInfo = [note userInfo];
	for (NSString *key in userInfo) {
		NSLog(@"%@ = %@", key, [userInfo objectForKey: key]);
	}
	[self.calcString setString: [userInfo objectForKey: @"Formula"]];
	[self.calcString appendFormat: @"_"];
	if (self.calcStringView != nil) {
		[self.calcStringView setText: self.calcString];
	}
}

//- (void)createConstButtons {
//    CGFloat floatX1 = kX1;
//	CGFloat floatX2 = kX2;
//	CGFloat floatX3 = kX3;
//	CGFloat floatX4 = kX4;
//	CGFloat floatX5 = kX5;
//    CGFloat floatX6 = kX6;
//    
//    //CGFloat floatY1 = kY1;
////	CGFloat floatY2 = kY2;
////	CGFloat floatY3 = kY3;
//	CGFloat floatY4 = kY4;
//	CGFloat floatY5 = kY5;
//	CGFloat floatY6 = kY6;
//	CGFloat floatY7 = kY7;
//    
//    CGFloat width1 = kWidth1;
//	CGFloat height1 = kHeight1;
//
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//		width1 = kWidth1*2;
//		height1 = kHeight1;
//		
//		floatX1 = kX1+70;
//		floatX2 = floatX1+width1;
//		floatX3 = floatX2+width1;
//		floatX4 = floatX3+width1;
//		floatX5 = floatX4+width1;
//		floatX6 = floatX5+width1;
//		
//		//CGFloat floatY1 = kY1;
////		floatY2 = kY2;
////		floatY3 = kY3;
//		floatY4 = kY4;
//		floatY5 = kY5;
//		floatY6 = kY6;
//		floatY7 = kY7;
//		
//		//CGFloat width2 = kWidth2;
//	}
//	
//    CGRect buttonFrame = CGRectMake(floatX1, floatY7, width1, height1);
//	[self constButtonWithFrame:buttonFrame title:@"g" andTag:1];
//    
//    buttonFrame = CGRectMake(floatX2, floatY7, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"p" andTag:2];
//	
//    buttonFrame = CGRectMake(floatX3, floatY7, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"γ" andTag:3];
//	
//    buttonFrame = CGRectMake(floatX4, floatY7, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"ϑ₀" andTag:4];
//	
//    buttonFrame = CGRectMake(floatX5, floatY7, width1, height1);
//	[self constButtonWithFrame:buttonFrame title:@"V₀" andTag:5];
//	
//    buttonFrame = CGRectMake(floatX6, floatY7, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"R" andTag:6];
//	
//    buttonFrame = CGRectMake(floatX1, floatY6, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"NA" andTag:7];
//	
//    buttonFrame = CGRectMake(floatX2, floatY6, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"k" andTag:8];
//	
//    buttonFrame = CGRectMake(floatX3, floatY6, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"ε₀" andTag:9];
//	
//    buttonFrame = CGRectMake(floatX4, floatY6, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"μ₀" andTag:10];
//	
//    buttonFrame = CGRectMake(floatX5, floatY6, width1, height1);
//	[self constButtonWithFrame:buttonFrame title:@"c" andTag:11];
//	
//    buttonFrame = CGRectMake(floatX6, floatY6, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"σ" andTag:12];
//	
//    buttonFrame = CGRectMake(floatX1, floatY5, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"h" andTag:13];
//	
//    buttonFrame = CGRectMake(floatX2, floatY5, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"e" andTag:14];
//	
//    buttonFrame = CGRectMake(floatX3, floatY5, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"me" andTag:15];
//	
//    buttonFrame = CGRectMake(floatX4, floatY5, width1, height1);
//	[self constButtonWithFrame:buttonFrame title:@"mp" andTag:16];
//	
//    buttonFrame = CGRectMake(floatX5, floatY5, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"mn" andTag:17];
//	
//    buttonFrame = CGRectMake(floatX6, floatY5, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"λc" andTag:18];
//	
//	buttonFrame = CGRectMake(floatX1, floatY4, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"ℏ" andTag:19];
//	
//	buttonFrame = CGRectMake(floatX2, floatY4, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"α" andTag:20];
//	
//	buttonFrame = CGRectMake(floatX3, floatY4, width1, height1);
//    [self constButtonWithFrame:buttonFrame title:@"Rʜ" andTag:21];
//	
//}

//- (void)constButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag {
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//    [button setFrame:frame];
//    [button setTitle:bTitle forState:UIControlStateNormal];
//    [button setTag:bTag];
//    [button addTarget:self action:@selector(constButtonPressed:) forControlEvents:UIControlEventTouchDown];
//    [constButtonsView addSubview:button];
//}

- (void)constButtonPressed:(UIButton *)sender {
//    if (self.help == YES) {
//        switch ([sender tag]) {
//            case 1: [self.calcStringView setText: NSLocalizedString(@"Gravitationsbeschleunigung [m s⁻²]", @"")]; break;
//            case 2: [self.calcStringView setText: NSLocalizedString(@"Normdruck [Pa]", @"")]; break;
//            case 3: [self.calcStringView setText: NSLocalizedString(@"Gravitationskonstante [m³ kg⁻¹ s⁻²]", @"")]; break;
//            case 4: [self.calcStringView setText: NSLocalizedString(@"absoluter Nullpunkt [C]", @"")]; break;
//            case 5: [self.calcStringView setText: NSLocalizedString(@"molares Volumen idealer Gase [dm³ mol⁻¹]", @"")]; break;
//            case 6: [self.calcStringView setText: NSLocalizedString(@"allgemeine Gaskonstante [J K⁻¹ mol⁻¹]", @"")]; break;
//            case 7: [self.calcStringView setText: NSLocalizedString(@"Avogadrosche Konstante [mol⁻¹]", @"")]; break;
//            case 8: [self.calcStringView setText: NSLocalizedString(@"Boltzmann-Konstante [J K⁻¹]", @"")]; break;
//            case 9: [self.calcStringView setText: NSLocalizedString(@"elektrische Feldkonstante [A s V⁻¹ m⁻¹]", @"")]; break;
//            case 10: [self.calcStringView setText: NSLocalizedString(@"magnetische Feldkonstante [V s A⁻¹ m⁻¹]", @"")]; break;
//            case 11: [self.calcStringView setText: NSLocalizedString(@"Lichtgeschwindigkeit im Vakuum [m s⁻¹]", @"")]; break;
//            case 12: [self.calcStringView setText: NSLocalizedString(@"Stefan-Boltzmann-Konstante [W m⁻² K⁻⁴]", @"")]; break;
//            case 13: [self.calcStringView setText: NSLocalizedString(@"Plancksches Wirkungsquantum [J s]", @"")]; break;
//            case 14: [self.calcStringView setText: NSLocalizedString(@"Elementarladung [C]", @"")]; break;
//            case 15: [self.calcStringView setText: NSLocalizedString(@"Ruhemasse des Elektrons [kg]", @"")]; break;
//            case 16: [self.calcStringView setText: NSLocalizedString(@"Ruhemasse des Proton [kg]", @"")]; break;
//            case 17: [self.calcStringView setText: NSLocalizedString(@"Ruhemasse des Neutron [kg]", @"")]; break;
//            case 18: [self.calcStringView setText: NSLocalizedString(@"Comptonwellenlänge [m]", @"")]; break;
//            case 19: [self.calcStringView setText: NSLocalizedString(@"reduziertes Plancksches Wirkungsquantum [Js]", @"")]; break;
//            case 20: [self.calcStringView setText: NSLocalizedString(@"Feinstrukturkonstante [1]", @"")]; break;
//            case 21: [self.calcStringView setText: NSLocalizedString(@"Rydberg-Konstante [m⁻¹]", @"")]; break;
//            default: break;
//        }
//    } else {
//		NSArray *underScore = [self.calcString componentsSeparatedByString: @"_"];
//		[self.calcString setString: [underScore objectAtIndex: 0]];
//        switch ([sender tag]) {
//            case 1: [self.calcString appendString: @"9.80665_"]; break;
//            case 2: [self.calcString appendString: @"101325_"]; break;
//            case 3: [self.calcString appendString: @"6.673e-11_"]; break;
//            case 4: [self.calcString appendString: @"-273.15_"]; break;
//            case 5: [self.calcString appendString: @"22.413996_"]; break;
//            case 6: [self.calcString appendString: @"8.314472_"]; break;
//            case 7: [self.calcString appendString: @"6.02214199e23_"]; break;
//            case 8: [self.calcString appendString: @"1.3806503e-23_"]; break;
//            case 9: [self.calcString appendString: @"8.85418782e-12_"]; break;
//            case 10: [self.calcString appendString: @"pi*4e-7_"]; break;
//            case 11: [self.calcString appendString: @"2.99792458e8_"]; break;
//            case 12: [self.calcString appendString: @"5.670400e-8_"]; break;
//            case 13: [self.calcString appendString: @"6.62606876e-34_"]; break;
//            case 14: [self.calcString appendString: @"1.602176462e-19_"]; break;
//            case 15: [self.calcString appendString: @"9.10938199e-31_"]; break;
//            case 16: [self.calcString appendString: @"1.67262158e-27_"]; break;
//            case 17: [self.calcString appendString: @"1.67492716e-27_"]; break;
//            case 18: [self.calcString appendString: @"2.426310215e-12_"]; break;
//            case 19: [self.calcString appendString: @"1.054571596e-34_"]; break;
//            case 20: [self.calcString appendString: @"7.297352533e-3_"]; break;
//            case 21: [self.calcString appendString: @"1.0973731568549e7_"]; break;
//            default: [self.calcString appendString: @"_"]; break;
//        }
//        [UIView beginAnimations:@"moveConstButtonsDown" context:nil];
//        [UIView setAnimationDuration: 0.5];
//        CGRect frame = [[self constButtonsView] frame];
//        frame.origin.y = 600;
//        [constants setTitle:@"const" forState:UIControlStateNormal];
//		[constants setBackgroundImage: nil forState: UIControlStateNormal];
//		[constants setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
//        [[self constButtonsView] setFrame: frame];
//        [UIView commitAnimations];
//		if ([underScore count] > 1) {
//			[self.calcString appendString: [underScore objectAtIndex: 1]];
//		}
//		self.calcStringView.text = self.calcString;
//		//digitsToDeleteAtPosition[inputPosition++] = 1;
//		self.digitsToDelete = 1;
//		self.alreadyRechenzeichen = NO;
//		self.alreadyPlus = NO;
//		self.alreadyMinus = NO;
//	}
    
    ConstantsTableViewController *constsViewController = [[ConstantsTableViewController alloc] init];
    constsViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:constsViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)buttonPressedDown:(UIButton *)sender {
    sender.layer.borderColor = [[UIColor blueColor] CGColor];
}

#pragma mark -
#pragma mark Number Buttons

- (void)insertDigit:(UIButton *)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if ([self help] == YES) {
        [self showHelpTextForButton:sender];
	} else {
        NSString *stringToInsert = @"";
        switch (sender.tag) {
            case DDHButtonTagZero: stringToInsert = @"0"; break;
            case DDHButtonTagOne: stringToInsert = @"1"; break;
            case DDHButtonTagTwo: stringToInsert = @"2"; break;
            case DDHButtonTagThree: stringToInsert = @"3"; break;
            case DDHButtonTagFour: stringToInsert = @"4"; break;
            case DDHButtonTagFive: stringToInsert = @"5"; break;
            case DDHButtonTagSix: stringToInsert = @"6"; break;
            case DDHButtonTagSeven: stringToInsert = @"7"; break;
            case DDHButtonTagEight: stringToInsert = @"8"; break;
            case DDHButtonTagNine: stringToInsert = @"9"; break;
            case DDHButtonTagDot:
                if ([[self activeCharacterInCalcString:self.calcString] isEqualToString:@"."]) {
                    stringToInsert = @"";
                } else {
                    stringToInsert = @".";
                }
                break;
            default:
                break;
        }
        
        self.calcString = [[self stringByInsertingString:stringToInsert inInputString:self.calcString] mutableCopy];
	
        self.calcStringView.text = self.calcString;
    }

}

#pragma mark - calcSigns
- (void)insertBasicCalculation:(UIButton *)sender {
    sender.layer.borderColor = [UIColor.lightGrayColor CGColor];
    if (self.help) {
        [self showHelpTextForButton:sender];
    } else {
        if ([[self calcString] isEqualToString: @""]) {
            [[self calcString] appendFormat: @"%lf", self.answerDouble];
        }
        
        NSString *stringToInsert = @"";
        switch (sender.tag) {
            case DDHButtonTagPlus:
                stringToInsert = DDHPlus;
                break;
            case DDHButtonTagMinus:
                stringToInsert = DDHMinus;
                break;
            case DDHButtonTagTimes:
                stringToInsert = DDHTimes;
                break;
            case DDHButtonTagDevide:
                stringToInsert = DDHDivide;
                break;
            default:
                break;
        }
        
        if ([self activeCharacterIsBasicCalcSign:self.calcString]) {
            self.calcString = [[self stringByReplacingActiveCharacterWith:stringToInsert inInputString:self.calcString] mutableCopy];
        } else {
            self.calcString = [[self stringByInsertingString:stringToInsert inInputString:self.calcString] mutableCopy];
        }
        
        self.calcStringView.text = self.calcString;
    }
}

- (void)insertFunction:(UIButton *)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
//	[[sender layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help) {
        [self showHelpTextForButton:sender];
	} else {
//        NSArray *underScore = [[self calcString] componentsSeparatedByString:@"_"];
//        [[self calcString] setString:[underScore objectAtIndex:0]];
//        [self setDigitsToDelete:1];
//        [self setAlreadyDot:NO];
//        [self setAlreadyPlus:NO];
//        [self setAlreadyMinus:NO];
//        switch (sender.tag) {
//            case 0:
//                if ([self alreadyRechenzeichen] == YES) {
//                    NSRange range;
//                    range.location = [[self calcString] length] - 1;
//                    range.length = 1;
//                    [[self calcString] deleteCharactersInRange:range];
//                }
//                if ([[self calcString] isEqualToString: @""]) {
//                    [[self calcString] appendFormat: @"%lf", answerDouble];
//                }
//                [[self calcString] appendString:@"+_"];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:YES];
//                [self setAlreadyMinus:NO];
//                break;
//            case 1:
//                if ([self alreadyPlus] == YES || [self alreadyMinus] == YES) {
//                    NSRange range;
//                    range.location = [[self calcString] length] - 1;
//                    range.length = 1;
//                    [[self calcString] deleteCharactersInRange: range];
//                }
//                if ([[self calcString] isEqualToString: @""]) {
//                    [[self calcString] appendFormat: @"%lf", answerDouble];
//                }
//                [[self calcString] appendString: @"-_"];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyMinus:YES];
//                [self setAlreadyPlus:NO];
//                break;
//            case 2:
//                if ([self alreadyRechenzeichen] == YES) {
//                    NSRange range;
//                    range.location = [[self calcString] length] - 1;
//                    range.length = 1;
//                    [[self calcString] deleteCharactersInRange: range];
//                }
//                if ([[self calcString] isEqualToString: @""]) {
//                    [[self calcString] appendFormat: @"%lf", answerDouble];
//                }
//                [[self calcString] appendString: @"*_"];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 3:
//                if ([self alreadyRechenzeichen] == YES) {
//                    NSRange range;
//                    range.location = [[self calcString] length] - 1;
//                    range.length = 1;
//                    [[self calcString] deleteCharactersInRange: range];
//                }
//                if ([[self calcString] isEqualToString: @""]) {
//                    [[self calcString] appendFormat: @"%lf", answerDouble];
//                }
//                [[self calcString] appendString: @"/_"];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 4:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*(_"];
//                } else {
//                    [[self calcString] appendString: @"(_"];
//                }
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 5:
//                [[self calcString] appendString: @")_"];
//                [self setAlreadyRechenzeichen:NO];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 6:
//                //[[self calcString] appendString: @"pow(_,)"];
//                if ([[self calcString] isEqualToString: @""]) {
//                    [[self calcString] appendFormat: @"%lf", answerDouble];
//                }
//                [[self calcString] appendString: @"^_"];
//                [self setAlreadyRechenzeichen:NO];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 7:
//                [[self calcString] appendString: @"e_"];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 8:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*pi_"];
//                } else {
//                    [[self calcString] appendString: @"pi_"];
//                }
//                [self setAlreadyRechenzeichen:NO];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 9:
//                break;
//            case 10:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*42_"];
//                } else {
//                    [[self calcString] appendString: @"42_"];
//                }
//                [self setDigitsToDelete:2];
//                [self setAlreadyDot:YES];
//                [self setAlreadyRechenzeichen:NO];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 11:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*log10(_"];
//                } else {
//                    [[self calcString] appendString: @"log10(_"];
//                }
//                [self setDigitsToDelete:6];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 12:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*log2(_"];
//                } else {
//                    [[self calcString] appendString: @"log2(_"];
//                }
//                [self setDigitsToDelete:5];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 13:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*ln(_"];
//                } else {
//                    [[self calcString] appendString: @"ln(_"];
//                }
//                [self setDigitsToDelete:3];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 14:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*exp(_"];
//                } else {
//                    [[self calcString] appendString: @"exp(_"];
//                }
//                [self setDigitsToDelete:4];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 15:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*sqrt(_"];
//                } else {
//                    [[self calcString] appendString: @"sqrt(_"];
//                }
//                [self setDigitsToDelete:5];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 16:
//                if ([[self calcString] rangeOfString: @"pow("].location != NSNotFound)
//                    [[self calcString] appendString: @",_"];
//                else
//                    [[self calcString] appendString: @"_"];
//                [self setAlreadyRechenzeichen:NO];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 17:
//                if ([self secondFunctions] == YES) {
//                    if ([self alreadyNumber]) {
//                        [[self calcString] appendString: @"*asin(_"];
//                    } else {
//                        [[self calcString] appendString: @"asin(_"];
//                    }
//                    [self setDigitsToDelete:5];
//                } else {
//                    if ([self alreadyNumber]) {
//                        [[self calcString] appendString: @"*sin(_"];
//                    } else {
//                        [[self calcString] appendString: @"sin(_"];
//                    }
//                    [self setDigitsToDelete:4];
//                }
//                [self setAlreadyDot:NO];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 18:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*"];
//                }
//                if ([self secondFunctions] == YES) {
//                    [[self calcString] appendString: @"acos(_"];
//                    [self setDigitsToDelete:5];
//                } else {
//                    [[self calcString] appendString: @"cos(_"];
//                    [self setDigitsToDelete:4];
//                }
//                [self setAlreadyDot:NO];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//            case 19:
//                if ([self alreadyNumber]) {
//                    [[self calcString] appendString: @"*"];
//                }
//                if ([self secondFunctions] == YES) {
//                    [[self calcString] appendString: @"atan(_"];
//                    [self setDigitsToDelete:5];
//                } else {
//                    [[self calcString] appendString: @"tan(_"];
//                    [self setDigitsToDelete:4];
//                }
//                [self setAlreadyDot:NO];
//                [self setAlreadyRechenzeichen:YES];
//                [self setAlreadyPlus:NO];
//                [self setAlreadyMinus:NO];
//                break;
//
//            default:
//                break;
//        }
//        if ([underScore count] > 1) {
//            [[self calcString] appendString:[underScore objectAtIndex:1]];
//        }
//        [[self calcStringView] setText:[self calcString]];
//        [self setAlreadyNumber: NO];
        
        NSString *stringToInsert = @"";
        switch (sender.tag) {
            case DDHButtonTagOpenParantheses:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*(";
                } else {
                    stringToInsert = @"(";
                }
                break;
            case DDHButtonTagCloseParantheses:
                stringToInsert = @")";
                break;
            case DDHButtonTagSin:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*";
                }
                if (self.secondFunctions) {
                    stringToInsert = [stringToInsert stringByAppendingString:@"a"];
                }
                stringToInsert = [stringToInsert stringByAppendingString:@"sin("];
                break;
            case DDHButtonTagCos:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*";
                }
                if (self.secondFunctions) {
                    stringToInsert = [stringToInsert stringByAppendingString:@"a"];
                }
                stringToInsert = [stringToInsert stringByAppendingString:@"cos("];
                break;
            case DDHButtonTagTan:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*";
                }
                if (self.secondFunctions) {
                    stringToInsert = [stringToInsert stringByAppendingString:@"a"];
                }
                stringToInsert = [stringToInsert stringByAppendingString:@"tan("];
                break;
            case DDHButtonTagPi:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*𝜋";
                } else {
                    stringToInsert = @"𝜋";
                }
                break;
            case DDHButtonTagSqrt:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*sqrt(";
                } else {
                    stringToInsert = @"sqrt(";
                }
                break;
            case DDHButtonTagLn:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*ln(";
                } else {
                    stringToInsert = @"ln(";
                }
                break;
            case DDHButtonTagExp:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*exp(";
                } else {
                    stringToInsert = @"exp(";
                }
                break;
            case DDHButtonTagLog10:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*log10(";
                } else {
                    stringToInsert = @"log10(";
                }
                break;
            case DDHButtonTagLog2:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*log2(";
                } else {
                    stringToInsert = @"log2(";
                }
                break;
//            case DDHButtonTagPower:
//                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
//                    stringToInsert = @"*pow(";
//                } else {
//                    stringToInsert = @"pow(";
//                }
//                break;
            case DDHButtonTagE:
                stringToInsert = @"e";
                break;
            default:
                break;
        }
        
        if (sender.tag == DDHButtonTagPower) {
            NSRange range = [self rangeOfActiveNumberInCalcString:self.calcString];
            if (range.location != NSNotFound) {
                NSString *subString = [self.calcString substringWithRange:NSMakeRange(range.location, range.length-1)];
                NSString *replacementString = [NSString stringWithFormat:@"pow(%@,_",subString];
                [self.calcString replaceCharactersInRange:range withString:replacementString];
            } else {
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = @"*pow(_,";
                } else {
                    stringToInsert = @"pow(_,";
                }
                [self.calcString replaceOccurrencesOfString:@"_" withString:stringToInsert options:0 range:NSMakeRange(0, self.calcString.length)];
            }
        } else {
            self.calcString = [[self stringByInsertingString:stringToInsert inInputString:self.calcString] mutableCopy];
        }
        
        self.calcStringView.text = self.calcString;
    
    }

}

#pragma mark - Meta
- (void)metaButtonPressed:(UIButton *)sender {
    switch (sender.tag) {
        case DDHButtonTagSecond:
            [self secondPressed:sender];
            break;
        case DDHButtonTagHistory:
            [self historyButtonPressed:sender];
            break;
        case DDHButtonTagAns:
            [self ansButtonPressed:sender];
            break;
        case DDHButtonTagDelete:
            [self deleteButtonPressed:sender];
            break;
        case DDHButtonTagConsts:
            [self constButtonPressed:sender];
            break;
        default:
            break;
    }
}

#pragma mark - changeButtons

- (void)secondPressed:(UIButton *)sender {
    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
	if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Wechsel zwischen Winkelfunktionen und deren Umkehrfunktionen", @"");
	} else {
		if (self.secondFunctions == NO) {
			self.secondFunctions = YES;
		} else {
			self.secondFunctions = NO;
		}
		[[self contentView] updateButtonTitlesForSecond:self.secondFunctions];
	}
}

- (void)constPressed:(UIButton *)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
//    if (self.help == YES) {
//		self.calcStringView.text = NSLocalizedString(@"Wechsel der Tastenbelegung", @"");
//	} else {
//		[UIView beginAnimations:@"moveConstButtonView" context:nil];
//        [UIView setAnimationDuration: 0.5];
//        CGRect frame = [[self constButtonsView] frame];
//        if (frame.origin.y > 400) {
//            frame.origin.y = buttonView.frame.origin.y + 90.0f;
//            [constants setTitle:@"done" forState:UIControlStateNormal];
//        } else {
//            frame.origin.y = 600;
//            [constants setTitle:@"c" forState:UIControlStateNormal];
//            [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
//        }
//        [[self constButtonsView] setFrame: frame];
//        [UIView commitAnimations];
//	}
}

- (void)degOrRadPressed:(UIButton *)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
	if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Umschalten zwischen Degrees und Radian", @"");
	} else {
		if (self.deg == NO) {
			self.deg = YES;
		} else {
			self.deg = NO;
		}
//		[self reCreateButtons];
	}
}

- (void)helpButtonPressed:(UIButton *)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
	if (self.help == NO) {
		self.help = YES;
		self.calcStringView.text = NSLocalizedString(@"Bitte drücke die Taste, die ich Dir erklären soll. (Zum Beenden nochmal help drücken)", @"");
	} else {
		self.help = NO;
		self.calcStringView.text = self.calcString;
	}
//	[self reCreateButtons];
}

- (void)deleteButtonPressed:(UIButton *)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Entfernung des Zeichens vor dem Unterstrich", @"");
	} else {
		if ([self.calcString length] > 1) {
			NSArray *underScore = [self.calcString componentsSeparatedByString: @"_"];
			[self.calcString setString: [underScore objectAtIndex: 0]];

			// delete the "_" at the end of the string
			//[calcString deleteCharactersInRange: [calcString rangeOfString: @"_"]];
			
			// find range of string to delete
			NSRange range;
			range.location = [self.calcString length] - 1;
			range.length = 1;
			
			// get substing which is to delete
			NSString *substring = [self.calcString substringWithRange: range];
			
			if ([self.calcString length] > 1) {
				
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
				[self.calcString deleteCharactersInRange: range];
				[self.calcString appendString: @"_"];
			} else {
				[self.calcString setString: @"_"];
			}
			
			if ([underScore count] > 1) {
				[self.calcString appendString: [underScore objectAtIndex: 1]];
			}
			self.calcStringView.text = self.calcString;
			self.digitsToDelete = 1;
            [self setAlreadyNumber: NO];
		}
	}
}

- (void)backButtonPressed:(UIButton *)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Ein Zeichen nach links im Eingabestring", @"");
	} else {
		NSArray *underScore = [self.calcString componentsSeparatedByString: @"_"];
		[self.calcString setString: [underScore objectAtIndex: 0]];

		if (![self.calcString isEqualToString: @""]) {
			NSRange range;
			range.location = [self.calcString length] - 1;
			range.length = 1;
			//digitsToDeleteAtPosition[inputPosition--];
		
			NSString *substring = [self.calcString substringWithRange: range];
		
			[self.calcString deleteCharactersInRange: range];
			[self.calcString appendString: @"_"];
			[self.calcString appendString: substring];
		} else {
			[self.calcString appendString: @"_"];
		}
		
		if ([underScore count] > 1) {
			[self.calcString appendString: [underScore objectAtIndex: 1]];
		}
		self.calcStringView.text = self.calcString;
		self.digitsToDelete = 1;
		self.alreadyDot = NO;
		self.alreadyRechenzeichen = NO;
        [self setAlreadyNumber: NO];
	}
}

- (void)forwardButtonPressed:(UIButton *)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Ein Zeichen nach rechts im Eingabestring", @"");
	} else {
		NSArray *underScore = [self.calcString componentsSeparatedByString: @"_"];
		[self.calcString setString: [underScore objectAtIndex: 0]];
		
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
				[self.calcString appendString: substring];
			}
		
			[self.calcString appendString: @"_"];
			[self.calcString appendString: dummyString];
		}
		self.digitsToDelete = 1;
		self.alreadyDot = NO;
		self.alreadyRechenzeichen = NO;
        [self setAlreadyNumber: NO];
		self.calcStringView.text = self.calcString;
	}
}

- (void)historyButtonPressed:(UIButton *)sender {
//    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
//    if (self.help == YES) {
//		self.calcStringView.text = NSLocalizedString(@"Zugriff auf die letzten fünf Berechnungen", @"");
//	} else {
//		if (historyIndex < 0) {
//			self.historyIndex = 9;
//		}
//		[calcString setString: [[historyCalcStrings objectAtIndex: historyIndex] objectForKey: @"calcString"]];
//		self.calcStringView.text = calcString;
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
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)ansButtonPressed:(UIButton *)sender {
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
       HistoryTableViewController *historyTableViewController = [[HistoryTableViewController alloc] initWithStyle: UITableViewStylePlain];
    [historyTableViewController setCalcDictArray: [self historyCalcStrings]];
    [historyTableViewController setDelegate: self];
    [historyTableViewController setIsCalcHistory: NO];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: historyTableViewController];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [navigationController setModalPresentationStyle: UIModalPresentationPageSheet];
    }
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)mailButtonPressed:(UIButton *)sender {
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
    [self presentViewController:mailComposerViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)calculatePressed: (id)sender {
    // [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
//	[[sender layer] setBackgroundColor: [[UIColor whiteColor] CGColor]];
    
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Durchführung der Berechnung", @"");
	} else {
        [self.calcString deleteCharactersInRange: [self.calcString rangeOfString: @"_"]];
		NSInteger indexForSubstring = 0;
        NSString *lastCharString;
        if (![self.calcString isEqualToString:@""]) {
            lastCharString = [self.calcString substringFromIndex: [self.calcString length]-1];
        }
        NSSet *calcSignsSet = [NSSet setWithObjects: @"*", @"-", @"+", @"/", nil];
        if ([calcSignsSet containsObject: lastCharString]) {
            [self calcSignAtTheEnd];
            return;
        }
		if ([self.calcString rangeOfString: @"("].location != NSNotFound) {
			Calculator *calculator = [[Calculator alloc] initWithDeg:YES];
			NSRange range = [calculator getRangeOfSubstringFromString: self.calcString bySearchingFor: @"("];
			indexForSubstring = range.location + range.length;
		}
		if (indexForSubstring > [self.calcString length]) {
			[self nichtGenugKlammern];
			[self.calcString appendFormat: @"_"];
		} else if ([self.calcString rangeOfString: @"pow("].location != NSNotFound &&
				   [self.calcString rangeOfString: @","].location == NSNotFound) {
			[self kommaFehlt];
			[self.calcString appendFormat: @"_"];
		} else {
			[self calculateString: [self calcString]];
//            for (int i = 9; i > 0; i--) {
//                [historyCalcStrings replaceObjectAtIndex: i withObject: [historyCalcStrings objectAtIndex: i-1]];
//            }
            NSString *tempString = [[NSString alloc] initWithFormat: @"%@", self.calcString];
            NSDictionary *historyDict = @{@"calcString": tempString, @"solution": @(self.answerDouble)};
//            [historyCalcStrings replaceObjectAtIndex: 0 withObject: historyDict];
            [self.historyCalcStrings insertObject: historyDict atIndex: 0];
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
	
	self.answerDouble = [sum doubleValue];
    
    UILabel *resultLabel = [self contentView].resultLabel;
    
	if ((self.answerDouble < 100000 && self.answerDouble > 0.001) ||
		(self.answerDouble > -100000 && self.answerDouble < -0.001)) {
		self.calcStringView.text = [NSString stringWithFormat: @"%@\nans = %.10lf", calcStringOrg, [sum doubleValue]];
		[resultLabel setText:[NSString stringWithFormat: @" ans = %.10lf", [sum doubleValue]]];
	} else {
		self.calcStringView.text = [NSString stringWithFormat: @"%@\nans = %.10e", calcStringOrg, [sum doubleValue]];
		[resultLabel setText:[NSString stringWithFormat: @" ans = %.10e", [sum doubleValue]]];
	}
	self.alreadyDot = NO;
}

#pragma mark - Helper methods
- (NSString *)stringByRemoveLastCalcSignIfNeeded:(NSString *)inputString {
    NSArray *components = [inputString componentsSeparatedByString:@"_"];
    NSMutableString *returnString = [NSMutableString new];
    NSUInteger length = [components[0] length];
    if (length > 0) {
        NSString *first = components[0];
        NSString *substring = [first substringFromIndex:length-1];
        if ([@[@"+", @"-", @"*", @"/"] containsObject:substring]) {
            [returnString appendString:[first substringToIndex:length-1]];
        }
    }
    [returnString appendString:@"_"];
    if ([components[1] length] > 0) {
        [returnString appendString:components[1]];
    }
    return returnString;
}

- (NSString *)stringByInsertingString:(NSString *)string inInputString:(NSString *)inputString {
    NSArray *components = [inputString componentsSeparatedByString:@"_"];
    NSMutableString *first = [components[0] mutableCopy];
    [first appendString:string];
    [first appendString:@"_"];
    if ([components count] > 1 && [components[1] length] > 0) {
        [first appendString:components[1]];
    }
    return [first copy];
}

- (NSString *)stringByReplacingActiveCharacterWith:(NSString *)string inInputString:(NSString *)inputString {
    NSArray *components = [inputString componentsSeparatedByString:@"_"];
    NSMutableString *first = [components[0] mutableCopy];
    if (first.length > 0) {
        first = [[first substringToIndex:first.length-1] mutableCopy];
    }
    [first appendString:string];
    [first appendString:@"_"];
    if ([components count] > 1 && [components[1] length] > 0) {
        [first appendString:components[1]];
    }
    return [first copy];
}

- (NSString *)activeCharacterInCalcString:(NSString *)inputString {
    NSArray *components = [inputString componentsSeparatedByString:@"_"];
    NSUInteger length = [components[0] length];
    if (length > 0) {
        return [components[0] substringFromIndex:length-1];
    }
    return nil;
}

- (BOOL)activeCharacterIsDigitInCalcString:(NSString *)inputString {
    NSString *activeCharacter = [self activeCharacterInCalcString:inputString];
    return [@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"] containsObject:activeCharacter];
}

- (BOOL)stringIsDigit:(NSString *)string {
    return [@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"] containsObject:string];
}

- (BOOL)activeCharacterIsBasicCalcSign:(NSString *)inputString {
    NSString *activeCharacter = [self activeCharacterInCalcString:inputString];
    return [@[DDHPlus, DDHMinus, DDHTimes, DDHDivide] containsObject:activeCharacter];
}

- (NSRange)rangeOfActiveNumberInCalcString:(NSString *)inputString {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+[.]?\\d+_" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange range = [regex rangeOfFirstMatchInString:inputString options:0 range:NSMakeRange(0, inputString.length)];
    if (range.location == NSNotFound) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+_" options:NSRegularExpressionCaseInsensitive error:&error];
        range = [regex rangeOfFirstMatchInString:inputString options:0 range:NSMakeRange(0, inputString.length)];
    }
    return range;
}

#pragma mark - Help
- (void)showHelpTextForButton:(UIButton *)button {
    NSString *helpText = @"";
    switch (button.tag) {
        case DDHButtonTagZero: helpText = NSLocalizedString(@"Eingabe der Ziffer 0", @""); break;
        case DDHButtonTagOne: helpText = NSLocalizedString(@"Eingabe der Ziffer 1", @""); break;
        case DDHButtonTagTwo: helpText = NSLocalizedString(@"Eingabe der Ziffer 2", @""); break;
        case DDHButtonTagThree: helpText = NSLocalizedString(@"Eingabe der Ziffer 3", @""); break;
        case DDHButtonTagFour: helpText = NSLocalizedString(@"Eingabe der Ziffer 4", @""); break;
        case DDHButtonTagFive: helpText = NSLocalizedString(@"Eingabe der Ziffer 5", @""); break;
        case DDHButtonTagSix: helpText = NSLocalizedString(@"Eingabe der Ziffer 6", @""); break;
        case DDHButtonTagSeven: helpText = NSLocalizedString(@"Eingabe der Ziffer 7", @""); break;
        case DDHButtonTagEight: helpText = NSLocalizedString(@"Eingabe der Ziffer 8", @""); break;
        case DDHButtonTagNine: helpText = NSLocalizedString(@"Eingabe der Ziffer 9", @""); break;
        case DDHButtonTagDot: helpText = NSLocalizedString(@"Eingabe eines Dezimaltrennungszeichens", @""); break;

        case DDHButtonTagPlus: helpText = NSLocalizedString(@"Addition", @""); break;
        case DDHButtonTagMinus: helpText = NSLocalizedString(@"Subtraktion", @""); break;
        case DDHButtonTagTimes: helpText = NSLocalizedString(@"Multiplikation", @""); break;
        case DDHButtonTagDevide: helpText = NSLocalizedString(@"Division", @""); break;
        case DDHButtonTagOpenParantheses: helpText = NSLocalizedString(@"Eingabe einer öffnenden Klammer", @"");
            break;
        case DDHButtonTagCloseParantheses: helpText = NSLocalizedString(@"Eingabe einer schliessenden Klammer", @"");
            break;
        case DDHButtonTagPower: helpText = NSLocalizedString(@"Potenz; um 2³ auszurechnen gibt man pow(2,3) ein", @"");
            break;
        case DDHButtonTagE: helpText = NSLocalizedString(@"Zehnerpotenz", @""); break;
        case DDHButtonTagPi: helpText = NSLocalizedString(@"Zahl Pi", @""); break;
        case DDHButtonTagAns: helpText = NSLocalizedString(@"Eingabe des letzten Ergebnisses", @"");break;
        case DDHButtonTagFourtyTwo: helpText = NSLocalizedString(@"Die Antwort auf die Frage nach dem Universum, dem Leben und dem Rest", @"");
            break;
        case DDHButtonTagLog10: helpText = NSLocalizedString(@"Logarithmus zur Basis Zehn", @""); break;
        case DDHButtonTagLog2: helpText = NSLocalizedString(@"Logarithmus zur Basis 2", @""); break;
        case DDHButtonTagLn: helpText = NSLocalizedString(@"Natürlicher Logarithmus", @""); break;
        case DDHButtonTagExp: helpText = NSLocalizedString(@"Exponentialfunktion", @""); break;
        case DDHButtonTagSqrt: helpText = NSLocalizedString(@"Wurzelfunktion", @""); break;
//        case 16: helpText = NSLocalizedString(@"Komma für pow(,)-Funktion; nur akriv, wenn 'pow(' im String vorhanden.", @""); break;
        case DDHButtonTagSin: helpText = NSLocalizedString(@"Sinus oder Arkussinus", @""); break;
        case DDHButtonTagCos: helpText = NSLocalizedString(@"Cosinus oder Arkuscosinus", @""); break;
        case DDHButtonTagTan: helpText = NSLocalizedString(@"Tangens oder Arkustangens", @""); break;
        default: break;
    }
    self.calcStringView.text = helpText;
}

#pragma mark -
#pragma mark alerts

- (void)nichtGenugKlammern {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Klammer" message:@"Warnung: Da sind mehr oeffnende Klammern als schliessende Klammern" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)kommaFehlt {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Komma" message:@"Warnung: pow-Funktion ohne Komma. Die pow-Funktion braucht zwei Argumente." preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)calcSignAtTheEnd {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Rechenzeichen" message:@"Rechnung endet mit einen Rechenzeichen." preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)insertString:(NSString *)stringToInsert {
    NSArray *components = [self.calcString componentsSeparatedByString:@"_"];
    NSMutableString *mutableString = [[NSMutableString alloc] initWithFormat:@"%@%@_", components.firstObject, stringToInsert];
    [mutableString appendString:components.lastObject];
    self.calcString = mutableString;
    self.calcStringView.text = self.calcString;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}


@end
