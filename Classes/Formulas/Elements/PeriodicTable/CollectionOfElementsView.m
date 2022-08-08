//
//  CollectionOfElementsView.m
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CollectionOfElementsView.h"
#import "ElementButton.h"
#import "Phy-Swift.h"

@interface CollectionOfElementsView ()
@end

@implementation CollectionOfElementsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithFrame: (CGRect)frame andElementsArray: (NSArray<ChemElement *> *)pElementsArray {
    if ((self = [super initWithFrame: frame])) {

        [self setBackgroundColor: [UIColor systemBackgroundColor]];

        CGFloat buttonWidth = (frame.size.width-17)/20.0;
        CGFloat x0 = buttonWidth;
        CGFloat buttonHeight = (frame.size.height-20)/12.0;
        CGFloat y0 = buttonHeight * 2;
        CGFloat lanthanideOffset = 2.0*buttonHeight+10.0;
        _buttonArray = [[NSMutableArray alloc] init];

        [pElementsArray enumerateObjectsUsingBlock:^(ChemElement * _Nonnull element, NSUInteger idx, BOOL * _Nonnull stop) {

            CGFloat x = x0 + (buttonWidth + 1) * (element.yPos - 1);
            CGFloat y = y0 + (buttonHeight + 1) * (element.period - 1);
            if ([element.group isEqualToString: @"Lanthanide"] ||
                [element.group isEqualToString: @"Actinide"]) {
                y += lanthanideOffset;
            }

            ElementButton *button = [[ElementButton alloc] initWithFrame: CGRectMake(x, y, buttonWidth, buttonHeight)];
            [button setTag: idx];
            [button addTarget: _delegate action: @selector(elementButtonPressed:) forControlEvents: UIControlEventTouchUpInside];

            CGFloat colorFloat = element.atomMass/kMaxMass;
            UIColor *cellColor = [UIColor colorWithHue:colorFloat saturation:0.8 brightness:0.7 alpha:1];
            [button setBackgroundColor: cellColor];
//            [button setTitle: element.abbreviation forState: UIControlStateNormal];
//            [[button titleLabel] setFont: [UIFont systemFontOfSize: 11.0f]];
            [button updateWithAbbr: element.abbreviation andOrdinal: element.ordinal];
            [_buttonArray addObject: button];
            [self addSubview: button];
        }];

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
        [segmentedControl setFrame: CGRectMake(40.0f, 16.0, frame.size.width-80, 30)];
        [segmentedControl setSelectedSegmentIndex: 0];
        [segmentedControl setTintColor: [UIColor grayColor]];
        [self addSubview: segmentedControl];

        _labelView = [[UIView alloc] initWithFrame: CGRectMake(x0 + 2.5 * buttonWidth, 1.8 * buttonHeight, 9 * buttonWidth + 8, 3 * buttonHeight)];
        _labelView.backgroundColor = [UIColor systemBackgroundColor];
        _labelView.layer.borderColor = [[UIColor labelColor] CGColor];
        _labelView.layer.borderWidth = 1;
        _labelView.layer.cornerRadius = 5;
        [self addSubview:_labelView];

        _abkLabel = [self infoLabel];
        _abkLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleHeadline];
        _abkLabel.textAlignment = NSTextAlignmentRight;

        _ordinalLabel = [self infoLabel];
        _ordinalLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleSubheadline];
        _ordinalLabel.textAlignment = NSTextAlignmentRight;

        UIStackView *abbrOrdinalStackView = [[UIStackView alloc] initWithArrangedSubviews: @[_abkLabel, _ordinalLabel]];
        abbrOrdinalStackView.translatesAutoresizingMaskIntoConstraints = NO;
        abbrOrdinalStackView.axis = UILayoutConstraintAxisVertical;

        [_labelView addSubview: abbrOrdinalStackView];

        [NSLayoutConstraint activateConstraints: @[
            [abbrOrdinalStackView.topAnchor constraintEqualToAnchor: _labelView.topAnchor constant: 5],
            [abbrOrdinalStackView.trailingAnchor constraintEqualToAnchor: _labelView.trailingAnchor constant: -10],
        ]
        ];
    }
    return self;
}

- (UILabel *)infoLabel {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor labelColor];
    return label;
}

@end
