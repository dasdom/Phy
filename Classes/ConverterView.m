//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConverterView.h"

@implementation ConverterView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        self.backgroundColor = [UIColor whiteColor];
        
		_pickerView = [[UIPickerView alloc] initWithFrame: CGRectZero];
		[_pickerView setShowsSelectionIndicator: YES];
		
		_inputValue = [UITextField new];
		[_inputValue setPlaceholder: NSLocalizedString(@"Eingabe", @"")];
        [_inputValue setKeyboardType: UIKeyboardTypeDecimalPad];
		[_inputValue setTextAlignment: NSTextAlignmentRight];
		[_inputValue setBorderStyle: UITextBorderStyleBezel];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
        toolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard)]];
        
        _inputValue.inputAccessoryView = toolbar;
        
		_einheitInput = [UILabel new];
		[_einheitInput setText: @"J"];

		UILabel *gleichZeichen = [UILabel new];
		[gleichZeichen setText: @"="];

		_outputValue = [UILabel new];
        [_outputValue setTextAlignment: NSTextAlignmentRight];

		_einheitOutput = [UILabel new];
        [_einheitOutput setText: @"J"];
        
        UIStackView *inputStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_inputValue, _einheitInput]];
        inputStackView.spacing = 5;
        inputStackView.distribution = UIStackViewDistributionFill;
        
        UIStackView *outputStackView = [[UIStackView alloc] initWithArrangedSubviews:@[gleichZeichen, _outputValue, _einheitOutput]];
        outputStackView.spacing = 5;
        outputStackView.distribution = UIStackViewDistributionFill;
        
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[inputStackView, outputStackView, _pickerView]];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 5;
        
        [self addSubview:_stackView];
        
        [NSLayoutConstraint activateConstraints:
         @[
             [_stackView.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor constant:8],
             [_stackView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor constant:-8],
             [_stackView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor],
             [inputStackView.heightAnchor constraintEqualToConstant:40],
             [outputStackView.heightAnchor constraintEqualToAnchor:inputStackView.heightAnchor],
         ]];
        
    }
    return self;
}

- (void)hideKeyboard {
    [self.inputValue resignFirstResponder];
}

@end
