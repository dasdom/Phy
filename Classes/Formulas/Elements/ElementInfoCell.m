//  Created by Dominik Hauser on 21.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

#import "ElementInfoCell.h"

@interface ElementInfoCell ()
@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation ElementInfoCell

+ (NSString *)identifier {
  return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _infoLabel = [[UILabel alloc] init];
    _infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _infoLabel.font = [UIFont preferredFontForTextStyle: UIFontTextStyleFootnote];
    _infoLabel.numberOfLines = 0;

    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:_infoLabel];

    [NSLayoutConstraint activateConstraints:@[
      [_infoLabel.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 1],
      [_infoLabel.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant: 10],
      [_infoLabel.bottomAnchor constraintEqualToAnchor: self.contentView.bottomAnchor constant: -1],
      [_infoLabel.trailingAnchor constraintEqualToAnchor: self.contentView.trailingAnchor constant: -10],
    ]];
  }
  return self;
}

- (void)updateWithText: (NSString *)text {
  [self.infoLabel setText: text];
}

@end
