//  Created by dasdom on 10.07.19.
//  
//

#import "ConstantCell.h"
//#import "CalculatorConstant.h"
#import "Phy-Swift.h"

@interface ConstantCell ()
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *valueLabel;
@end

@implementation ConstantCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 2;
        _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//        _valueLabel.textAlignment = NSTextAlignmentRight;
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_nameLabel, _valueLabel]];
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

- (void)updateWithItem:(id)item {
    if ([item isKindOfClass:[CalculatorConstant class]]) {
        CalculatorConstant *constant = (CalculatorConstant *)item;
        self.nameLabel.text = constant.name;
        self.valueLabel.text = [NSString stringWithFormat:@"%@ %@", constant.value, constant.unit];
    }
}

@end
