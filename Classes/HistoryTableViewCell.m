//
//  HistoryTableViewCell.m
//  PhysForm
//
//  Created by Dominik Hauser on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

@synthesize calcStringTextView=mCalcStringTextView;
@synthesize solutionLabel=mSolutionLabel;

- (id)initWithCellIdentifier:(NSString *)cellID {
    if ((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID])) {
        CGRect contentFrame = [[self contentView] frame];
        mCalcStringTextView = [[UILabel alloc] initWithFrame: CGRectMake(10.0f, 5.0f, contentFrame.size.width-20.0f, 50.0f)];
//        [[self calcStringTextView] setFont: [UIFont boldSystemFontOfSize: 14.0f]];
        [[self calcStringTextView] setNumberOfLines: 2];
        [[self calcStringTextView] setLineBreakMode: UILineBreakModeCharacterWrap];
        [[self contentView] addSubview: [self calcStringTextView]];
        
        mSolutionLabel = [[UILabel alloc] initWithFrame: CGRectMake(10.0f, 55.0f, contentFrame.size.width-20.0f, 20.0f)];
//        [[self solutionLabel] setFont: [UIFont systemFontOfSize: 14.0f]];
        [[self contentView] addSubview: [self solutionLabel]];
    }
    return self;
}

@end
