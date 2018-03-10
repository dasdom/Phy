//
//  ConverterView.h
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConverterView : UIView /*<UIPickerViewDelegate>*/ {
	UIPickerView *pickerView;
	NSArray *pickerArray0;
	NSArray *pickerArray1;
	NSArray *pickerArray2;
	UILabel *einheitInput;
	UILabel *einheitOutput;
	UILabel *outputValue;
	UITextField *inputValue;
	UILabel *erlaubteZeichen;
	UILabel *gleichZeichen;
}

@property (nonatomic, strong) NSArray *pickerArray0;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel *einheitInput;
@property (nonatomic, strong) UILabel *einheitOutput;
@property (nonatomic, strong) UILabel *outputValue;
@property (nonatomic, strong) UITextField *inputValue;

- (CGRect)pickerFrameWithSize: (CGSize)size;

@end
