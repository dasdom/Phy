//
//  DestignatedCalculaterViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 30.04.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DestignatedCalculaterViewController : UIViewController <UITextFieldDelegate> {
	UITextField *text1;
	UITextField *text2;
	UITextField *text3;
	UITextField *text4;
	UITextField *text5;
	UITextField *text6;
	NSArray *stringForFieldsAbove;
	NSArray *stringForFieldsBelow;
	UIButton *calculate;
	UILabel *resultLabel;
	UILabel *labelNull;
	NSString *stringForLabelNull;
	UILabel *unitLabel;
	NSString *stringForUnitLabel;
	NSString *textFile;
	UITextView *moreInfo;
	NSString *nameOfTheImage;
	NSInteger squarePara; 
	CGRect bruchstrich;
	NSDictionary *constants;
}
@property (nonatomic, strong) UITextField *text1;
@property (nonatomic, strong) UITextField *text2;
@property (nonatomic, strong) UITextField *text3;
@property (nonatomic, strong) UITextField *text4;
@property (nonatomic, strong) UITextField *text5;
@property (nonatomic, strong) UITextField *text6;
@property (nonatomic, strong) NSArray *stringForFieldsAbove;
@property (nonatomic, strong) NSArray *stringForFieldsBelow;
@property (nonatomic, strong) UIButton *calculate;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UILabel *labelNull;
@property (nonatomic, strong) NSString *stringForLabelNull;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) NSString *stringForUnitLabel;
@property (nonatomic, strong) NSString *textFile;
@property (nonatomic, strong) UITextView *moreInfo;
@property (nonatomic, strong) NSString *nameOfTheImage;
@property NSInteger squarePara;
@property (nonatomic, strong) NSDictionary *constants;
@property CGRect bruchstrich;

- (UITextField *)createTextFieldWithFrame: (CGRect)frame andPlaceholer: (NSString *) placeholder;
- (NSDictionary *)makeDictionaryWithConstants;
- (void)doCalculation: (id)sender;
- (NSDecimalNumber *)decimalNumberFromDouble: (NSString *)string;

@end
