//  Created by dasdom on 09.08.19.
//  
//

#import "CalculatorButton.h"

@implementation CalculatorButton

+ (instancetype)buttonWithStyle:(CalcButtonStyle)buttonStyle {
  CalculatorButton *button = [super buttonWithType:UIButtonTypeSystem];
  button.titleLabel.adjustsFontForContentSizeCategory = YES;
//  button.titleLabel.adjustsFontSizeToFitWidth = YES;
  button.titleLabel.numberOfLines = 2;
  button.buttonStyle = buttonStyle;
  
  switch (buttonStyle) {
    case CalcButtonStyleMeta:
    case CalcButtonStyleParentheses:
      button.backgroundColor = [UIColor colorNamed:@"meta_button_color"];
      break;
    case CalcButtonStyleFunction:
      button.backgroundColor = [UIColor colorNamed:@"func_button_color"];
      break;
    case CalcButtonStyleBasic:
    case CalcButtonStyleEqual:
      button.backgroundColor = [UIColor colorNamed:@"basic_button_color"];
      button.tintColor = [UIColor whiteColor];
      break;
    case CalcButtonStyleNumbers:
      button.backgroundColor = [UIColor colorNamed:@"num_button_color"];
      break;
    default:
      break;
  }
  
  return button;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  
  UIFontMetrics *fontMetric = [[UIFontMetrics alloc] initForTextStyle:UIFontTextStyleBody];

  NSString *text = self.currentTitle;

  CGFloat maxPointSize = 28 - text.length;
  
  UIFont *font = [fontMetric scaledFontForFont:[UIFont systemFontOfSize:20] maximumPointSize:maxPointSize];
  self.titleLabel.font = font;
  
  [self setTitle:nil forState:UIControlStateNormal];
  [self setTitle:text forState:UIControlStateNormal];
}

@end
