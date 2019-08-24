//
//  CollectionOfElementsView.m
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectionOfElementsView.h"

@interface CollectionOfElementsView ()
@property (nonatomic, strong) UIView *labelView;
@end

@implementation CollectionOfElementsView

- (id)initWithFrame: (CGRect)frame andElementsArray: (NSArray*)pElementsArray {
    if ((self = [super initWithFrame: frame])) {
        [self setBackgroundColor: [UIColor whiteColor]];
        CGFloat buttonWidth = (frame.size.height-17)/20.0;
        CGFloat x0 = buttonWidth;
        CGFloat buttonHeight = (frame.size.width-8)/12.0;
        CGFloat y0 = buttonHeight;
        CGFloat lanthanideOffset = 2.0*buttonHeight+20.0;
        _buttonArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [pElementsArray count]; i++) {
            NSDictionary *elementsDict = [pElementsArray objectAtIndex: i];
            CGFloat x = x0+(buttonWidth+1)*([[elementsDict objectForKey: @"YPos"] floatValue]-1);
            CGFloat y = y0+(buttonHeight+1)*([[elementsDict objectForKey: @"Periode"] floatValue]-1);
            if ([[elementsDict objectForKey: @"Gruppe"] isEqualToString: @"Lanthanide"] ||
                [[elementsDict objectForKey: @"Gruppe"] isEqualToString: @"Actinide"]) {
                y += lanthanideOffset;
            }
//            NSLog(@"x %f, y %f", x, y);
            UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(x, y, buttonWidth, buttonHeight)];
//            [[button layer] setBorderWidth: 1.0f];
//            [[button layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
            [button setTag: i];
            [button addTarget: _delegate action: @selector(elementButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
            CGFloat colorFloat = 0.7f-[[elementsDict objectForKey: @"Atommasse"] floatValue]/kMaxMass;
//            UIColor *backgroundColor = [UIColor colorWithHue:colorFloat saturation:1.0 brightness:1.0 alpha:1.0];
            [button setBackgroundColor: [UIColor colorWithRed: colorFloat green: colorFloat blue: colorFloat alpha: 1.0f]];
//            button.backgroundColor = backgroundColor;
            [button setTitle: [elementsDict objectForKey: @"Abk"] forState: UIControlStateNormal];
            [[button titleLabel] setFont: [UIFont systemFontOfSize: 11.0f]];
            [_buttonArray addObject: button];
            [self addSubview: button];
        }
        UILabel *sternLabel = [[UILabel alloc] initWithFrame: CGRectMake(x0+2*(buttonWidth+1), y0+5*(buttonHeight+1), buttonWidth, buttonHeight)];
        [sternLabel setText: @"*"];
        [sternLabel setTextAlignment: NSTextAlignmentCenter];
        [self addSubview: sternLabel];
        
        UILabel *doppelSternLabel = [[UILabel alloc] initWithFrame: CGRectMake(x0+2*(buttonWidth+1), y0+6*(buttonHeight+1), buttonWidth, buttonHeight)];
        [doppelSternLabel setText: @"**"];
        [doppelSternLabel setTextAlignment: NSTextAlignmentCenter];
        [self addSubview: doppelSternLabel];
        
        UILabel *sternLabel2 = [[UILabel alloc] initWithFrame: CGRectMake(x0+1*(buttonWidth+1), y0+5*(buttonHeight+1)+lanthanideOffset, buttonWidth, buttonHeight)];
        [sternLabel2 setText: @"*"];
        [sternLabel2 setTextAlignment: NSTextAlignmentCenter];
        [self addSubview: sternLabel2];
        
        UILabel *doppelSternLabel2 = [[UILabel alloc] initWithFrame: CGRectMake(x0+1*(buttonWidth+1), y0+6*(buttonHeight+1)+lanthanideOffset, buttonWidth, buttonHeight)];
        [doppelSternLabel2 setText: @"**"];
        [doppelSternLabel2 setTextAlignment: NSTextAlignmentCenter];
        [self addSubview: doppelSternLabel2];
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: @[NSLocalizedString(@"Masse", nil), NSLocalizedString(@"Phase (Normbed.)", nil), NSLocalizedString(@"Pauling-Skala", nil)]];
        [segmentedControl addTarget: _delegate action: @selector(changeColor:) forControlEvents: UIControlEventValueChanged];
        [segmentedControl setFrame: CGRectMake(10.0f, frame.size.width-30, frame.size.height-20, 20.0f)];
        [segmentedControl setSelectedSegmentIndex: 0];
        [segmentedControl setTintColor: [UIColor grayColor]];
        [self addSubview: segmentedControl];
        
        _labelView = [[UIView alloc] initWithFrame: CGRectMake(x0+2.5*buttonWidth, 0.2*buttonHeight, 9*buttonWidth+8, 3.5*buttonHeight)];
        _labelView.backgroundColor = [UIColor grayColor];
        [self addSubview:_labelView];
        _labelView.layer.cornerRadius = 5;
        
        _abkLabel = [self infoLabel];
        _abkLabel.font = [UIFont systemFontOfSize: 21.0f];
        _abkLabel.textAlignment = NSTextAlignmentCenter;

        UIStackView *abbStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_abkLabel]];
        abbStackView.alignment = UIStackViewAlignmentTop;
        
        _nameLabel = [self infoLabel];
        _massLabel = [self infoLabel];
        _elConfigLabel = [self infoLabel];
        _periodeLabel = [self infoLabel];
        _gruppeLabel = [self infoLabel];
        _paulingLabel = [self infoLabel];
        
        UIStackView *numbersStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_nameLabel, _massLabel, _elConfigLabel, _periodeLabel, _gruppeLabel, _paulingLabel]];
        numbersStackView.axis = UILayoutConstraintAxisVertical;
        numbersStackView.spacing = 0;
        
        UIStackView *infoStackView = [[UIStackView alloc] initWithArrangedSubviews:@[abbStackView, numbersStackView]];
        infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
        infoStackView.spacing = 5;
        infoStackView.distribution = UIStackViewDistributionFillProportionally;
        
        [_labelView addSubview:infoStackView];
        
        [NSLayoutConstraint activateConstraints:
         @[
           [infoStackView.leadingAnchor constraintEqualToAnchor:_labelView.leadingAnchor constant:8],
           [infoStackView.trailingAnchor constraintEqualToAnchor:_labelView.trailingAnchor constant:-8],
           [infoStackView.topAnchor constraintEqualToAnchor:_labelView.topAnchor constant:8],
           [infoStackView.bottomAnchor constraintEqualToAnchor:_labelView.bottomAnchor constant:-8],
           [abbStackView.widthAnchor constraintEqualToConstant:70],
           ]
         ];
    }
    return self;
}

- (UILabel *)infoLabel {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize: 10.0f];
    return label;
}

@end
