//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReferenzView.h"

@interface ReferenzView ()
@property (nonatomic, strong) UILabel *outputValue;
@property (nonatomic, strong) UILabel *bedingung;
@property (nonatomic, strong) UILabel *material;
@property (nonatomic, strong) UILabel *eigenschaft;
@property (nonatomic, strong) UILabel *quelle;
@end

@implementation ReferenzView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor systemBackgroundColor];
        
        _pickerView = [UIPickerView new];
        
        _material = [UILabel new];
        _material.textAlignment = NSTextAlignmentCenter;
        _material.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        
        _eigenschaft = [UILabel new];
        _eigenschaft.textAlignment = NSTextAlignmentCenter;
        _eigenschaft.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

        _outputValue = [UILabel new];
        _outputValue.textAlignment = NSTextAlignmentCenter;
        _outputValue.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];

        _bedingung = [UILabel new];
        _bedingung.textAlignment = NSTextAlignmentCenter;
        _bedingung.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        _bedingung.text = @"";
        
        _quelle = [UILabel new];
        _quelle.textAlignment = NSTextAlignmentCenter;
        _quelle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        _quelle.text = NSLocalizedString(@"Quelle: Wikipedia, 03.2010",@"");
        
        NSArray *segmentArray = @[NSLocalizedString(@"gasförmig",@""),
                                  NSLocalizedString(@"flüssig",@""), NSLocalizedString(@"fest",@"")];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentArray];
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        
        UIView *segmentedControlHostView = [UIView new];
        [segmentedControlHostView addSubview:_segmentedControl];
        
        UIStackView *infoStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_material, _eigenschaft, _outputValue]];
        infoStackView.axis = UILayoutConstraintAxisVertical;
        infoStackView.spacing = 5;
        
        UIStackView *metaStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_bedingung, _quelle]];
        metaStackView.axis = UILayoutConstraintAxisVertical;
        metaStackView.spacing = 5;
        
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[infoStackView, metaStackView, segmentedControlHostView, _pickerView]];
        _stackView.translatesAutoresizingMaskIntoConstraints = false;
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 20;
        
        [self addSubview:_stackView];
        
        [NSLayoutConstraint activateConstraints:
         @[
             [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
             [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
             [_stackView.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor],
             [_segmentedControl.leadingAnchor constraintEqualToAnchor:segmentedControlHostView.leadingAnchor constant:10],
             [_segmentedControl.trailingAnchor constraintEqualToAnchor:segmentedControlHostView.trailingAnchor constant:-10],
             [_segmentedControl.topAnchor constraintEqualToAnchor:segmentedControlHostView.topAnchor],
             [_segmentedControl.bottomAnchor constraintEqualToAnchor:segmentedControlHostView.bottomAnchor],
         ]];
        
    }
    return self;
}

- (void)updateWithMaterialDict:(NSDictionary *)materialDict propertyDict:(NSDictionary *)propertyDict {
    self.outputValue.text = [NSString stringWithFormat: @"%@ %@", NSLocalizedString(propertyDict[@"Wert"],nil), propertyDict[@"Einheit"]];
    self.material.text = NSLocalizedString(materialDict[@"Name"], nil);
    self.eigenschaft.text = NSLocalizedString(propertyDict[@"Name"], nil);
    self.bedingung.text = propertyDict[@"Bedingung"];
    
    [self.pickerView reloadAllComponents];
}

@end
