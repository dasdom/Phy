//
//  HistoryTableViewCell.m
//  PhysForm
//
//  Created by Dominik Hauser on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (id)initWithCellIdentifier:(NSString *)cellID {
    if ((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID])) {
        
        _calcStringTextView = [[UILabel alloc] init];
        _calcStringTextView.numberOfLines = 2;
        _calcStringTextView.lineBreakMode = NSLineBreakByCharWrapping;

        _solutionLabel = [[UILabel alloc] init];
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_calcStringTextView, _solutionLabel]];
        stackView.translatesAutoresizingMaskIntoConstraints = NO;
        stackView.axis = UILayoutConstraintAxisVertical;
        stackView.spacing = 5;
        [self.contentView addSubview:stackView];
        
        [NSLayoutConstraint activateConstraints:
         @[
             [stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
             [stackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
             [stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8],
             [stackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8]
         ]
         ];
    }
    return self;
}

@end
