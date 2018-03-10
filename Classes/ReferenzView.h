//
//  ReferenzView.h
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ReferenzView : UIView /*<UIPickerViewDelegate>*/ {
	UIPickerView *pickerView;
	UILabel *outputValue;
	UILabel *bedingung;
	UILabel *material;
	UILabel *eigenschaft;
	UILabel *quelle;
	UISegmentedControl *segmentedControl;
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UILabel *outputValue;
@property (nonatomic, strong) UILabel *bedingung;
@property (nonatomic, strong) UILabel *material;
@property (nonatomic, strong) UILabel *eigenschaft;
@property (nonatomic, strong) UILabel *quelle;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

- (CGRect)pickerFrameWithSize: (CGSize)size;

@end
