//
//  GeneralCalculatorViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 16.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface GeneralCalculatorViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	UIButton *sinFunc;
	UIButton *cosFunc;
	UIButton *tanFunc;
	
	UIButton *second;
	UIButton *constants;
	UIButton *degOrRad;
	UIButton *helpButton;
	
	NSInteger digitsToDelete;
	NSInteger historyIndex;

	UITextView *calcStringView;
	UILabel *ansView;
	NSMutableString *calcString;
	double answerDouble;
	
	NSMutableArray *historyCalcStrings;
	
	UIAlertView *klammerAlert;
	UIAlertView *kommaAlert;
	
	NSInteger digitsToDeleteAtPosition[100];
	NSInteger inputPosition;
	
    UIView *buttonView;
    UIView *constButtonsView;
}

@property (nonatomic, strong) UIButton *sinFunc;
@property (nonatomic, strong) UIButton *cosFunc;
@property (nonatomic, strong) UIButton *tanFunc;
@property (nonatomic, strong) UIButton *second;
@property BOOL secondFunctions;
@property (nonatomic, strong) UIButton *constants;

@property (nonatomic, strong) UIButton *degOrRad;
@property double answerDouble;
@property (nonatomic, strong) UIButton *helpButton;

@property (nonatomic, strong) UITextView *calcStringView;
@property (nonatomic, strong) UILabel *ansView;
@property (nonatomic, strong) NSMutableString *calcString;
@property (nonatomic, strong) NSMutableArray *historyCalcStrings;

@property NSInteger digitsToDelete;
@property NSInteger historyIndex;

@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIView *constButtonsView;

- (void)createButtons;
- (void)reCreateButtons;
- (void)receivedFormula: (NSNotification *)note;
- (void)createConstButtons;
- (void)constButtonPressed:(id)sender;

- (void)calculatePressed: (id)sender;

- (void)secondPressed: (id)sender;
- (void)constPressed: (id)sender;
- (void)degOrRadPressed: (id)sender;

- (void)deleteButtonPressed: (id)sender;
- (void)backButtonPressed: (id)sender;
- (void)helpButtonPressed: (id)sender;

- (void)numberButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag;
- (void)functionButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag;
- (void)addGraditentToButton: (UIButton *)myButton;
- (void)constButtonWithFrame:(CGRect)frame title:(NSString *)bTitle andTag:(NSInteger)bTag;
/*
- (NSDecimalNumber *)addFromString: (NSString *)string;
- (NSDecimalNumber *)subtractFromString: (NSString *)subtractString;
- (NSDecimalNumber *)nDotFromString: (NSString *)nDotString;
- (NSDecimalNumber *)multiplyFromString: (NSString *)multString;
- (NSDecimalNumber *)diffFromString: (NSString *)diffString;
- (NSDecimalNumber *)squareFromString: (NSString *)squareString;
- (NSDecimalNumber *)exponentFromString: (NSString *)exponentString;
- (NSDecimalNumber *)eminusFromString: (NSString *)eminusString;

- (NSString *)calcExp: (NSString *)dummyCalcString;
- (NSString *)calcLn: (NSString *)dummyCalcString;
- (NSString *)calcLog2: (NSString *)dummyCalcString;
- (NSString *)calcLog10: (NSString *)dummyCalcString;
- (NSString *)calcSin: (NSString *)dummyCalcString;
- (NSString *)calcCos: (NSString *)dummyCalcString;
- (NSString *)calcTan: (NSString *)dummyCalcString;
- (NSString *)calcAsin: (NSString *)dummyCalcString;
- (NSString *)calcAcos: (NSString *)dummyCalcString;
- (NSString *)calcAtan: (NSString *)dummyCalcString;
- (NSString *)calcPi: (NSString *)dummyCalcString;
- (NSString *)calcSqrt: (NSString *)dummyCalcString;
- (NSString *)calcPow: (NSString *)dummyCalcString;

- (NSString *)calcKlammers: (NSString *)dummyCalcString;
*/
- (void)calculateString:(NSString *)cString;
//- (NSRange)getRangeOfSubstringFromString: (NSString *)orgString bySearchingFor: (NSString *)funcString;
//- (NSString *)getFunctionStringFromString: (NSString *)calculationString forFunction: (NSString *)function withRange: (NSRange)range;

- (void)nichtGenugKlammern;
- (void)kommaFehlt;
- (void)calcSignAtTheEnd;

@end
