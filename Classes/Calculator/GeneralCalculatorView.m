//  Created by dasdom on 20.03.18.
//

#import "GeneralCalculatorView.h"
#import "Legacy_Calculator.h"
#import "CalculatorButton.h"

@interface GeneralCalculatorView ()
@property (nonatomic) UIButton *sinButton;
@property (nonatomic) UIButton *cosButton;
@property (nonatomic) UIButton *tanButton;
@property (nonatomic) UIButton *degButton;
@end

@implementation GeneralCalculatorView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
    _calculationStringTextView = [UITextView new];
    _calculationStringTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _calculationStringTextView.adjustsFontForContentSizeCategory = YES;
    _calculationStringTextView.inputView = [UIView new];
    _calculationStringTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    _calculationStringTextView.inputAssistantItem.leadingBarButtonGroups = @[];
    _calculationStringTextView.inputAssistantItem.trailingBarButtonGroups = @[];
    
    //        _resultLabel = [[UILabel alloc] init];
    //        _resultLabel.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    //        [_resultLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    //        _resultLabel.text = @" = ";
    
    UIButton *helpButton = [self metaButtonWithTitle:@"help" tag:DDHButtonTagsHelp];
    UIButton *mailButton = [self metaButtonWithTitle:@"share" tag:DDHButtonTagShare];
    UIButton *blankButton = [self metaButtonWithTitle:@"" tag:DDHButtonTagNone];
    UIButton *historyButton = [self metaButtonWithTitle:@"hist" tag:DDHButtonTagHistory];
    UIButton *moveLeftButton = [self metaButtonWithTitle:@"←" tag:DDHButtonTagMoveLeft];
    UIButton *moveRightButton = [self metaButtonWithTitle:@"→" tag:DDHButtonTagMoveRight];
    
    UIStackView *rowOneStackView = [[UIStackView alloc] initWithArrangedSubviews:@[helpButton, mailButton, blankButton, historyButton, moveLeftButton, moveRightButton]];
    rowOneStackView.spacing = 1;
    rowOneStackView.distribution = UIStackViewDistributionFillEqually;
    
    UIButton *toggleSecondFunctionsButton = [self metaButtonWithTitle:@"2nd" tag:DDHButtonTagSecond];
    UIButton *constantsButton = [self metaButtonWithTitle:@"const" tag:DDHButtonTagConsts];
    _degButton = [self metaButtonWithTitle:@"DEG" tag:DDHButtonTagDEG];
    UIButton *answersButton = [self metaButtonWithTitle:@"ans" tag:DDHButtonTagAns];
    UIButton *fourtyTwoButton = [self metaButtonWithTitle:@"42" tag:DDHButtonTagFourtyTwo];
    UIButton *deleteButton = [self metaButtonWithTitle:@"del" tag:DDHButtonTagDelete];
    
    UIStackView *rowTwoStackView = [[UIStackView alloc] initWithArrangedSubviews:@[toggleSecondFunctionsButton, constantsButton, _degButton, fourtyTwoButton, answersButton, deleteButton]];
    rowTwoStackView.spacing = 1;
    rowTwoStackView.distribution = UIStackViewDistributionFillEqually;
    
    _sinButton = [self functionButtonWithTitle:@"sin" tag:DDHButtonTagSin];
    _cosButton = [self functionButtonWithTitle:@"cos" tag:DDHButtonTagCos];
    _tanButton = [self functionButtonWithTitle:@"tan" tag:DDHButtonTagTan];
    UIButton *leftParanthesesButton = [self paranthesesButtonWithTitle:@"(" tag:DDHButtonTagOpenParantheses];
    UIButton *rightParanthesesButton = [self paranthesesButtonWithTitle:@")" tag:DDHButtonTagCloseParantheses];
    UIButton *devideButton = [self basicCalculationButtonWithTitle:DDHDivide tag:DDHButtonTagDevide];
    
    UIStackView *rowThreeStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_sinButton, _cosButton, _tanButton, leftParanthesesButton, rightParanthesesButton, devideButton]];
    rowThreeStackView.spacing = 1;
    rowThreeStackView.distribution = UIStackViewDistributionFillEqually;
    
    UIButton *piButton = [self functionButtonWithTitle:@"𝜋" tag:DDHButtonTagPi];
    UIButton *sqrtButton = [self functionButtonWithTitle:@"√" tag:DDHButtonTagSqrt];
    
    UIButton *sevenButton = [self numberButtonWithTitle:@"7" tag:DDHButtonTagSeven];
    UIButton *eightButton = [self numberButtonWithTitle:@"8" tag:DDHButtonTagEight];
    UIButton *nineButton = [self numberButtonWithTitle:@"9" tag:DDHButtonTagNine];
    
    UIButton *multiplyButton = [self basicCalculationButtonWithTitle:DDHTimes tag:DDHButtonTagTimes];
    
    UIStackView *rowFourStackView = [[UIStackView alloc] initWithArrangedSubviews:@[piButton, sqrtButton, sevenButton, eightButton, nineButton, multiplyButton]];
    rowFourStackView.spacing = 1;
    rowFourStackView.distribution = UIStackViewDistributionFillEqually;
    
    UIButton *lnButton = [self functionButtonWithTitle:@"ln" tag:DDHButtonTagLn];
    UIButton *expButton = [self functionButtonWithTitle:@"exp" tag:DDHButtonTagExp];
    
    UIButton *fourButton = [self numberButtonWithTitle:@"4" tag:DDHButtonTagFour];
    UIButton *fiveButton = [self numberButtonWithTitle:@"5" tag:DDHButtonTagFive];
    UIButton *sixButton = [self numberButtonWithTitle:@"6" tag:DDHButtonTagSix];
    
    UIButton *minusButton = [self basicCalculationButtonWithTitle:DDHMinus tag:DDHButtonTagMinus];
    
    UIStackView *rowFiveStackView = [[UIStackView alloc] initWithArrangedSubviews:@[lnButton, expButton, fourButton, fiveButton, sixButton, minusButton]];
    rowFiveStackView.spacing = 1;
    rowFiveStackView.distribution = UIStackViewDistributionFillEqually;
    
    UIButton *log10Button = [self functionButtonWithTitle:@"log10" tag:DDHButtonTagLog10];
    UIButton *log2Button = [self functionButtonWithTitle:@"log2" tag:DDHButtonTagLog2];
    
    UIButton *oneButton = [self numberButtonWithTitle:@"1" tag:DDHButtonTagOne];
    UIButton *twoButton = [self numberButtonWithTitle:@"2" tag:DDHButtonTagTwo];
    UIButton *threeButton = [self numberButtonWithTitle:@"3" tag:DDHButtonTagThree];
    
    UIButton *plusButton = [self basicCalculationButtonWithTitle:DDHPlus tag:DDHButtonTagPlus];
    
    UIStackView *rowSixStackView = [[UIStackView alloc] initWithArrangedSubviews:@[log10Button, log2Button, oneButton, twoButton, threeButton, plusButton]];
    rowSixStackView.spacing = 1;
    rowSixStackView.distribution = UIStackViewDistributionFillEqually;
    
    UIButton *powerButton = [self functionButtonWithTitle:@"^" tag:DDHButtonTagPower];
    UIButton *eButton = [self functionButtonWithTitle:@"e" tag:DDHButtonTagE];
    
    UIButton *zeroButton = [self numberButtonWithTitle:@"0" tag:DDHButtonTagZero];
    UIButton *dotButton = [self numberButtonWithTitle:@"." tag:DDHButtonTagDot];
    
    UIButton *equalButton = [self equalButtonWithTitle:@"=" tag:DDHButtonTagEqual];
    
    UIStackView *rowSevenStackView = [[UIStackView alloc] initWithArrangedSubviews:@[powerButton, eButton, zeroButton, dotButton, equalButton]];
    rowSevenStackView.spacing = 1;
    
    UIStackView *buttonStackView = [[UIStackView alloc] initWithArrangedSubviews:@[rowOneStackView, rowTwoStackView, rowThreeStackView, rowFourStackView, rowFiveStackView, rowSixStackView, rowSevenStackView]];
    buttonStackView.axis = UILayoutConstraintAxisVertical;
    buttonStackView.spacing = 1;
    buttonStackView.distribution = UIStackViewDistributionFillEqually;
    
    _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_calculationStringTextView, buttonStackView]];
    _stackView.translatesAutoresizingMaskIntoConstraints = false;
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.spacing = 1;
    
    self.backgroundColor = [UIColor colorNamed:@"calc_view_background_color"];
    self.tintColor = [UIColor labelColor];
    
    [self addSubview:_stackView];
    
    [NSLayoutConstraint activateConstraints:
     @[
       [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:2],
       [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-2],
       [_stackView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:2],
       [_stackView.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-2],
       [_calculationStringTextView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.2],
       [powerButton.widthAnchor constraintEqualToAnchor:eButton.widthAnchor],
       [powerButton.widthAnchor constraintEqualToAnchor:dotButton.widthAnchor],
       [powerButton.widthAnchor constraintEqualToAnchor:equalButton.widthAnchor],
       [zeroButton.leadingAnchor constraintEqualToAnchor:oneButton.leadingAnchor],
       [zeroButton.trailingAnchor constraintEqualToAnchor:twoButton.trailingAnchor],
       ]];
  }
  return self;
}

#pragma mark - Button creation helpers
- (UIButton *)metaButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  CalculatorButton *button = [CalculatorButton buttonWithStyle:CalcButtonStyleMeta];
  button.tag = tag;
  [button setTitle:title forState:UIControlStateNormal];

  [button addTarget:nil action:@selector(metaButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  return button;
}

- (UIButton *)functionButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  CalculatorButton *button = [CalculatorButton buttonWithStyle:CalcButtonStyleFunction];
  button.tag = tag;
  [button setTitle:title forState:UIControlStateNormal];

  [button addTarget:nil action:@selector(insertFunction:) forControlEvents:UIControlEventTouchUpInside];
  return button;
}

- (UIButton *)basicCalculationButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  CalculatorButton *button = [CalculatorButton buttonWithStyle:CalcButtonStyleBasic];
  button.tag = tag;
  [button setTitle:title forState:UIControlStateNormal];

  [button addTarget:nil action:@selector(insertBasicCalculation:) forControlEvents:UIControlEventTouchUpInside];
  return button;
}

- (UIButton *)equalButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  CalculatorButton *button = [CalculatorButton buttonWithStyle:CalcButtonStyleEqual];
  button.tag = tag;
  [button setTitle:title forState:UIControlStateNormal];

  [button addTarget:nil action:@selector(calculatePressed:) forControlEvents:UIControlEventTouchUpInside];
  return button;
}

- (UIButton *)paranthesesButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  CalculatorButton *button = [CalculatorButton buttonWithStyle:CalcButtonStyleParentheses];
  button.tag = tag;
  [button setTitle:title forState:UIControlStateNormal];

  [button addTarget:nil action:@selector(insertFunction:) forControlEvents:UIControlEventTouchUpInside];
  return button;
}

- (UIButton *)numberButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  CalculatorButton *button = [CalculatorButton buttonWithStyle:CalcButtonStyleNumbers];
  button.tag = tag;
  [button setTitle:title forState:UIControlStateNormal];

  [button addTarget:nil action:@selector(insertDigit:) forControlEvents: UIControlEventTouchUpInside];
  return button;
}

#pragma mark - Change buttons
- (void)updateButtonTitlesForSecond:(BOOL)second {
  if (second) {
    [self.sinButton setTitle:@"asin" forState:UIControlStateNormal];
    [self.cosButton setTitle:@"acos" forState:UIControlStateNormal];
    [self.tanButton setTitle:@"atan" forState:UIControlStateNormal];
  } else {
    [self.sinButton setTitle:@"sin" forState:UIControlStateNormal];
    [self.cosButton setTitle:@"cos" forState:UIControlStateNormal];
    [self.tanButton setTitle:@"tan" forState:UIControlStateNormal];
  }
}

- (void)updateDEGButtonForDEGState:(BOOL)deg {
  if (deg) {
    [self.degButton setTitle:@"DEG" forState:UIControlStateNormal];
  } else {
    [self.degButton setTitle:@"RAD" forState:UIControlStateNormal];
  }
}

@end
