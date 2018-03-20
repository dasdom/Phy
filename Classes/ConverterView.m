//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConverterView.h"

@implementation ConverterView

@synthesize pickerArray0;
@synthesize pickerView;
@synthesize einheitInput, einheitOutput, outputValue;
@synthesize inputValue;

//- (CGRect)pickerFrameWithSize:(CGSize)size
//{
//    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        screenRect.size.height = screenRect.size.height/2-20;
//    }
//    CGRect pickerRect = CGRectMake(0.0,
//                                   screenRect.size.height - 44.0 - size.height,
//                                   screenRect.size.width,
//                                   size.height);
//    return pickerRect;
//}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		//pickerArray0 = [[NSArray alloc] initWithObjects: @"Energie", @"Länge", nil];
        
        self.backgroundColor = [UIColor whiteColor];
        
		pickerView = [[UIPickerView alloc] initWithFrame: CGRectZero];
//        CGSize pickerSize = [pickerView sizeThatFits: CGSizeZero];
//        pickerView.frame = [self pickerFrameWithSize: pickerSize];
		//[pickerView setDelegate: self];
		[pickerView setShowsSelectionIndicator: YES];
//        [self addSubview: pickerView];
		
        erlaubteZeichen = [UILabel new];
        [erlaubteZeichen setText: NSLocalizedString(@"(erlaubte Zeichen: -123456789.e)", @"")];
        [erlaubteZeichen setTextColor: [UIColor grayColor]];
//        [erlaubteZeichen setBackgroundColor: [UIColor blackColor]];
        [erlaubteZeichen setAdjustsFontSizeToFitWidth: YES];
        [self addSubview: erlaubteZeichen];
		
		inputValue = [UITextField new];
		[inputValue setPlaceholder: NSLocalizedString(@"Eingabe", @"")];
//        [inputValue setTextColor: [UIColor whiteColor]];
//        [inputValue setBackgroundColor: [UIColor blackColor]];
        [inputValue setKeyboardType: UIKeyboardTypeNumbersAndPunctuation];
		[inputValue setTextAlignment: NSTextAlignmentRight];
		[inputValue setBorderStyle: UITextBorderStyleBezel];
//        [self addSubview: inputValue];
		
		einheitInput = [UILabel new];
//        [einheitInput setTextColor: [UIColor whiteColor]];
//        [einheitInput setBackgroundColor: [UIColor blackColor]];
		[einheitInput setText: @"J"];
//        [self addSubview: einheitInput];
		
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            dummyFrame = CGRectMake(320, 50, 15, 30);
//        } else {
//            dummyFrame = CGRectMake(70, 100, 15, 30);
//        }
		gleichZeichen = [UILabel new];
		[gleichZeichen setText: @"="];
//        [gleichZeichen setTextColor: [UIColor whiteColor]];
//        [gleichZeichen setBackgroundColor: [UIColor blackColor]];
//        [self addSubview: gleichZeichen];
		
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            dummyFrame = CGRectMake(360, 50, 140, 30);
//        } else {
//            dummyFrame = CGRectMake(90, 100, 140, 30);
//        }
		outputValue = [UILabel new];
//        [outputValue setTextColor: [UIColor whiteColor]];
//        [outputValue setBackgroundColor: [UIColor blackColor]];
		[outputValue setTextAlignment: NSTextAlignmentRight];
//        [self addSubview: outputValue];
		
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            dummyFrame = CGRectMake(520, 50, 60, 30);
//        } else {
//            dummyFrame = CGRectMake(240, 100, 60, 30);
//        }

		einheitOutput = [UILabel new];
//        [einheitOutput setTextColor: [UIColor whiteColor]];
//        [einheitOutput setBackgroundColor: [UIColor blackColor]];
		[einheitOutput setText: @"J"];
//        [self addSubview: einheitOutput];
        
        UIStackView *inputStackView = [[UIStackView alloc] initWithArrangedSubviews:@[inputValue, einheitInput]];
        inputStackView.distribution = UIStackViewDistributionFill;
        
        UIStackView *outputStackView = [[UIStackView alloc] initWithArrangedSubviews:@[gleichZeichen, outputValue, einheitOutput]];
        outputStackView.distribution = UIStackViewDistributionFill;

        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[inputStackView, outputStackView, erlaubteZeichen, pickerView]];
        _stackView.translatesAutoresizingMaskIntoConstraints = false;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.spacing = 10;
        
        [self addSubview:_stackView];
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                                  [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                                  [inputStackView.heightAnchor constraintEqualToConstant:40],
                                                  [outputStackView.heightAnchor constraintEqualToAnchor:inputStackView.heightAnchor],
                                                  ]];
        
    }
    return self;
}

@end
