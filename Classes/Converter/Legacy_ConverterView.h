//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Legacy_ConverterView : UIView

@property (nonatomic, strong) NSArray *pickerArray0;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel *einheitInput;
@property (nonatomic, strong) UILabel *einheitOutput;
@property (nonatomic, strong) UILabel *outputValue;
@property (nonatomic, strong) UITextField *inputValue;
@property (nonatomic, strong) UIStackView *stackView;

@end
