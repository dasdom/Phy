//  Created by Dominik Hauser on 22.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

#import "ElementButton.h"

@interface ElementButton ()
@property (nonatomic, strong) UILabel *abbrLabel;
@property (nonatomic, strong) UILabel *ordinalLabel;
@end

@implementation ElementButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _abbrLabel = [[UILabel alloc] init];
        _abbrLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _abbrLabel.font = [UIFont boldSystemFontOfSize: 13];
        _abbrLabel.textColor = [UIColor whiteColor];
        
        _ordinalLabel = [[UILabel alloc] init];
        _ordinalLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _ordinalLabel.font = [UIFont systemFontOfSize: 11];
        _ordinalLabel.textColor = [UIColor whiteColor];
        
        [self addSubview: _abbrLabel];
        [self addSubview: _ordinalLabel];
        
        [NSLayoutConstraint activateConstraints: @[
            [_abbrLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant: -4],
            [_abbrLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -2],

            [_ordinalLabel.topAnchor constraintEqualToAnchor: self.topAnchor constant: 2],
            [_ordinalLabel.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 2],
        ]];
    }
    return self;
}

- (void)updateWithAbbr: (NSString *)abbr andOrdinal: (NSInteger)ordinal {
    [self.abbrLabel setText: abbr];
    [self.ordinalLabel setText: [NSString stringWithFormat: @"%ld", ordinal]];
}

@end
