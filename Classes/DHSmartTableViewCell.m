//
//  DHSmartTableViewCell.m
//  MeineAllergie
//
//  Created by Dominik Hauser on 10.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DHSmartTableViewCell.h"

@implementation DHSmartTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCellIdentifier: (NSString *)cellID {
    return [self initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: cellID];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)cellForTableView: (UITableView*)tableView {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier: cellID];
    }
    return cell;
}

+ (NSString*)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
