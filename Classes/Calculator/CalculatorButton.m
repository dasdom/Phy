//  Created by dasdom on 09.08.19.
//  
//

#import "CalculatorButton.h"

@implementation CalculatorButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
  CalculatorButton *button = [super buttonWithType:buttonType];
  button.titleLabel.adjustsFontForContentSizeCategory = YES;
//  button.titleLabel.adjustsFontSizeToFitWidth = YES;
  button.titleLabel.numberOfLines = 2;
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
