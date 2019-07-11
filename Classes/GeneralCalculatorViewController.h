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
//	UIButton *sinFunc;
//	UIButton *cosFunc;
//	UIButton *tanFunc;

//	UIButton *second;
//	UIButton *constants;
//	UIButton *degOrRad;
//	UIButton *helpButton;

//	NSInteger digitsToDelete;
//	NSInteger historyIndex;

//	UITextView *calcStringView;
//	UILabel *ansView;
//	NSMutableString *calcString;
//	double answerDouble;

//	NSMutableArray *historyCalcStrings;

//	UIAlertView *klammerAlert;
//	UIAlertView *kommaAlert;

//	NSInteger digitsToDeleteAtPosition[100];
//	NSInteger inputPosition;
//
//    UIView *buttonView;
//    UIView *constButtonsView;
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

- (void)insertString:(NSString *)stringToInsert;

@end
