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

//static NSString * const DDHPlus = @"+";
//static NSString * const DDHMinus = @"-";
//static NSString * const DDHTimes = @"*";
//static NSString * const DDHDivide = @"/";

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

- (void)setCalcString:(NSMutableString *)calcString {
    _calcString = calcString;
    self.calcStringView.text = _calcString;
}

- (void)receivedFormula: (NSNotification *)note {
	NSDictionary *userInfo = [note userInfo];
	for (NSString *key in userInfo) {
		NSLog(@"%@ = %@", key, [userInfo objectForKey: key]);
	}
	[self.calcString setString: [userInfo objectForKey: @"Formula"]];
	[self.calcString appendFormat: @"_"];
//	if (self.calcStringView != nil) {
//		[self.calcStringView setText: self.calcString];
//	}
}

- (void)constButtonPressed:(UIButton *)sender {
    
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
        
        self.calcString = [self stringByInsertingString:stringToInsert inInputString:self.calcString];
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
            self.calcString = [self stringByInsertingString:stringToInsert inInputString:self.calcString];
        }
    }
}

- (void)insertFunction:(UIButton *)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help) {
        [self showHelpTextForButton:sender];
	} else {
        
        NSString *stringToInsert = @"";
        switch (sender.tag) {
            case DDHButtonTagOpenParantheses:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@(", DDHTimes];
                } else {
                    stringToInsert = @"(";
                }
                break;
            case DDHButtonTagCloseParantheses:
                stringToInsert = @")";
                break;
            case DDHButtonTagSin:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = DDHTimes;
                }
                if (self.secondFunctions) {
                    stringToInsert = [stringToInsert stringByAppendingString:@"a"];
                }
                stringToInsert = [stringToInsert stringByAppendingString:@"sin("];
                break;
            case DDHButtonTagCos:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = DDHTimes;
                }
                if (self.secondFunctions) {
                    stringToInsert = [stringToInsert stringByAppendingString:@"a"];
                }
                stringToInsert = [stringToInsert stringByAppendingString:@"cos("];
                break;
            case DDHButtonTagTan:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = DDHTimes;
                }
                if (self.secondFunctions) {
                    stringToInsert = [stringToInsert stringByAppendingString:@"a"];
                }
                stringToInsert = [stringToInsert stringByAppendingString:@"tan("];
                break;
            case DDHButtonTagPi:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@𝜋", DDHTimes];
                } else {
                    stringToInsert = @"𝜋";
                }
                break;
            case DDHButtonTagSqrt:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@sqrt(", DDHTimes];
                } else {
                    stringToInsert = @"sqrt(";
                }
                break;
            case DDHButtonTagLn:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@ln(", DDHTimes];
                } else {
                    stringToInsert = @"ln(";
                }
                break;
            case DDHButtonTagExp:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@exp(", DDHTimes];
                } else {
                    stringToInsert = @"exp(";
                }
                break;
            case DDHButtonTagLog10:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@log10(", DDHTimes];
                } else {
                    stringToInsert = @"log10(";
                }
                break;
            case DDHButtonTagLog2:
                if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
                    stringToInsert = [NSString stringWithFormat:@"%@log2(", DDHTimes];
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
                    stringToInsert = [NSString stringWithFormat:@"%@pow(_,", DDHTimes];
                } else {
                    stringToInsert = @"pow(_,";
                }
                [self.calcString replaceOccurrencesOfString:@"_" withString:stringToInsert options:0 range:NSMakeRange(0, self.calcString.length)];
            }
        } else {
            self.calcString = [self stringByInsertingString:stringToInsert inInputString:self.calcString];
        }
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
        case DDHButtonTagShare:
            [self shareButtonPressed:sender];
            break;
        case DDHButtonTagMoveLeft:
            [self backButtonPressed:sender];
            break;
        case DDHButtonTagMoveRight:
            [self forwardButtonPressed:sender];
            break;
        case DDHButtonTagFourtyTwo:
            self.calcString = [self stringByInsertingString:@"42" inInputString:self.calcString];
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
//			NSString *substring = [self.calcString substringWithRange: range];
			
			if ([self.calcString length] > 1) {
				
//				// check if there are some special characters in the substring and reset some bool values if neccessary
//				if ([substring rangeOfString: @"."].location != NSNotFound)
//					self.alreadyDot = NO;
//				if ([substring rangeOfString: @"-"].location != NSNotFound) {
//					self.alreadyMinus = NO;
//					self.alreadyRechenzeichen = NO;
//				}
//				if ([substring rangeOfString: @"+"].location != NSNotFound) {
//					self.alreadyPlus = NO;
//					self.alreadyRechenzeichen = NO;
//				}
//				if ([substring rangeOfString: @"*"].location != NSNotFound) {
//					self.alreadyRechenzeichen = NO;
//				}
//				if ([substring rangeOfString: @"/"].location != NSNotFound) {
//					self.alreadyRechenzeichen = NO;
//				}
				
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
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Ein Zeichen nach links im Eingabestring", @"");
	} else {
		NSArray *components = [self.calcString componentsSeparatedByString: @"_"];
		[self.calcString setString: [components objectAtIndex: 0]];

		if (![self.calcString isEqualToString: @""]) {
			NSRange range;
			range.location = [self.calcString length] - 1;
			range.length = 1;
		
			NSString *substring = [self.calcString substringWithRange: range];
		
			[self.calcString deleteCharactersInRange: range];
			[self.calcString appendString: @"_"];
			[self.calcString appendString: substring];
		} else {
			[self.calcString appendString: @"_"];
		}
		
		if ([components count] > 1) {
			[self.calcString appendString: [components objectAtIndex: 1]];
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
	[[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];

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

- (void)shareButtonPressed:(UIButton *)sender {
    
    NSDictionary *lastCalculationDict = [[self historyCalcStrings] objectAtIndex: 0];
    NSString *lastCalculation = [NSString stringWithFormat: @"%@\n=%@", lastCalculationDict[@"calcString"], lastCalculationDict[@"solution"]];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[lastCalculation] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)calculatePressed: (id)sender {
    [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
    if (self.help == YES) {
		self.calcStringView.text = NSLocalizedString(@"Durchführung der Berechnung", @"");
	} else {
        [self.calcString deleteCharactersInRange: [self.calcString rangeOfString: @"_"]];
		NSInteger indexForSubstring = 0;
        NSString *lastCharString;
        if (![self.calcString isEqualToString:@""]) {
            lastCharString = [self.calcString substringFromIndex: self.calcString.length-1];
        }
        NSSet *calcSignsSet = [NSSet setWithObjects: DDHTimes, DDHMinus, DDHPlus, DDHDivide, nil];
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
			[self calculateString: self.calcString];
            NSString *tempString = [[NSString alloc] initWithFormat: @"%@", self.calcString];
            NSDictionary *historyDict = @{@"calcString": tempString, @"solution": @(self.answerDouble)};
            [self.historyCalcStrings insertObject: historyDict atIndex: 0];
            if ([[self historyCalcStrings] count] > 50) {
                [[self historyCalcStrings] removeLastObject];
            }
            self.historyIndex = 9;
            
            [self.calcString setString:@"_"];
		}
        [self setAlreadyNumber:NO];
	}
} 

- (void)calculateString:(NSString *)cString {
	
	Calculator *calculator = [[Calculator alloc] initWithDeg:deg];
	NSDecimalNumber *sum = [calculator calculateString: cString];
    
    [self presentResult:[sum doubleValue] forCalcString:cString];
}

- (void)presentResult:(double)answer forCalcString:(NSString *)calcString {
    self.answerDouble = answer;
    
    UILabel *resultLabel = [self contentView].resultLabel;
    
    if ((self.answerDouble < 100000 && self.answerDouble > 0.001) ||
        (self.answerDouble > -100000 && self.answerDouble < -0.001)) {
        self.calcStringView.text = [NSString stringWithFormat: @"%@\nans = %.10lf", calcString, self.answerDouble];
        [resultLabel setText:[NSString stringWithFormat: @" ans = %.10lf", self.answerDouble]];
    } else {
        self.calcStringView.text = [NSString stringWithFormat: @"%@\nans = %.10e", calcString, self.answerDouble];
        [resultLabel setText:[NSString stringWithFormat: @" ans = %.10e", self.answerDouble]];
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
        if ([@[DDHPlus, DDHMinus, DDHTimes, DDHDivide] containsObject:substring]) {
            [returnString appendString:[first substringToIndex:length-1]];
        }
    }
    [returnString appendString:@"_"];
    if ([components[1] length] > 0) {
        [returnString appendString:components[1]];
    }
    return returnString;
}

- (NSMutableString *)stringByInsertingString:(NSString *)string inInputString:(NSString *)inputString {
    NSArray *components = [inputString componentsSeparatedByString:@"_"];
    NSMutableString *first = [components[0] mutableCopy];
    [first appendString:string];
    [first appendString:@"_"];
    if ([components count] > 1 && [components[1] length] > 0) {
        [first appendString:components[1]];
    }
    return [first mutableCopy];
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
