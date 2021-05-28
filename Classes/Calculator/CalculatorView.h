//  Created by dasdom on 20.03.18.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDHButtonTags) {
    DDHButtonTagNone = -1,
    
    // Digits
    DDHButtonTagZero = 0,
    DDHButtonTagOne,
    DDHButtonTagTwo,
    DDHButtonTagThree,
    DDHButtonTagFour,
    DDHButtonTagFive,
    DDHButtonTagSix,
    DDHButtonTagSeven,
    DDHButtonTagEight,
    DDHButtonTagNine,
    DDHButtonTagDot,
    
    // Meta
    DDHButtonTagsHelp = 100,
    DDHButtonTagShare,
    DDHButtonTagHistory,
    DDHButtonTagMoveLeft,
    DDHButtonTagMoveRight,
    DDHButtonTagSecond,
    DDHButtonTagConsts,
    DDHButtonTagDEG,
    DDHButtonTagAns,
    DDHButtonTagFourtyTwo,
    DDHButtonTagDelete,
    
    // Functions
    DDHButtonTagSin = 1000,
    DDHButtonTagCos,
    DDHButtonTagTan,
    DDHButtonTagOpenParantheses,
    DDHButtonTagCloseParantheses,
    DDHButtonTagPi,
    DDHButtonTagSqrt,
    DDHButtonTagLn,
    DDHButtonTagExp,
    DDHButtonTagLog10,
    DDHButtonTagLog2,
    DDHButtonTagPower,
    DDHButtonTagE,
    
    // Basic calculations
    DDHButtonTagDevide = 1100,
    DDHButtonTagTimes,
    DDHButtonTagMinus,
    DDHButtonTagPlus,
    DDHButtonTagEqual,
};

@interface CalculatorView : UIView

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UITextView *calculationStringTextView;
//@property (nonatomic, strong) UILabel *resultLabel;

- (void)updateButtonTitlesForSecond:(BOOL)second;
- (void)updateDEGButtonForDEGState:(BOOL)deg;
@end
