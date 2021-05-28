//  Created by Dominik Hauser on 16.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property BOOL secondFunctions;

@property (nonatomic, strong) UITextView *calcStringView;
@property (nonatomic, strong) UILabel *ansView;
@property (nonatomic, strong) NSMutableString *calcString;
@property (nonatomic, strong) NSMutableArray *historyCalcStrings;

- (void)insertString:(NSString *)stringToInsert;

@end
