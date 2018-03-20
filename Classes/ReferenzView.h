//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferenzView : UIView
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

- (void)updateWithMaterialDict:(NSDictionary *)materialDict propertyDict:(NSDictionary *)propertyDict;
@end
