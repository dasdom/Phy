//  Created by dasdom on 09.08.19.
//  
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CalcButtonStyle) {
  CalcButtonStyleMeta,
  CalcButtonStyleFunction,
  CalcButtonStyleBasic,
  CalcButtonStyleEqual,
  CalcButtonStyleParentheses,
  CalcButtonStyleNumbers
};

@interface CalculatorButton : UIButton
@property (nonatomic) CalcButtonStyle buttonStyle;
+ (instancetype)buttonWithStyle:(CalcButtonStyle)buttonStyle;
@end
