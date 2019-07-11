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

@synthesize buttonArray;
@synthesize delegate;
@synthesize labelView=mLabelView;
@synthesize nameLabel=mNameLabel;
@synthesize massLabel=mMassLabel;
@synthesize elConfigLabel=mElConfigLabel;
@synthesize periodeLabel=mPeriodeLabel;
@synthesize gruppeLabel=mGruppeLabel;
@synthesize paulingLabel=mPaulingLabel;
@synthesize abkLabel=mAbkLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame: (CGRect)frame andElementsArray: (NSArray*)pElementsArray {
    if ((self = [super initWithFrame: frame])) {
        [self setBackgroundColor: [UIColor whiteColor]];
        CGFloat x0 = 20.0f;
        CGFloat y0 = 50.0f;
        CGFloat buttonWidth = 23.0f;
        CGFloat buttonHeight = 23.0f;
        CGFloat lanthanideOffset = 60.0f;
        buttonArray = [[NSMutableArray alloc] init];
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
            [button addTarget: delegate action: @selector(elementButtonPressed:) forControlEvents: UIControlEventTouchUpInside];
            CGFloat colorFloat = 0.7f-[[elementsDict objectForKey: @"Atommasse"] floatValue]/kMaxMass;
            [button setBackgroundColor: [UIColor colorWithRed: colorFloat green: colorFloat blue: colorFloat alpha: 1.0f]];
            [button setTitle: [elementsDict objectForKey: @"Abk"] forState: UIControlStateNormal];
            [[button titleLabel] setFont: [UIFont systemFontOfSize: 11.0f]];
            [buttonArray addObject: button];
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
        [self addSubview: doppelSternLabel2];
        
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: @[NSLocalizedString(@"Masse", nil), NSLocalizedString(@"Phase (Normbed.)", nil), NSLocalizedString(@"Pauling-Skala", nil)]];
        [segmentedControl addTarget: delegate action: @selector(changeColor:) forControlEvents: UIControlEventValueChanged];
        [segmentedControl setFrame: CGRectMake(10.0f, 290.0f, 460.0f, 20.0f)];
        [segmentedControl setSelectedSegmentIndex: 0];
        [segmentedControl setTintColor: [UIColor grayColor]];
        [self addSubview: segmentedControl];
        
        mLabelView = [[UIView alloc] initWithFrame: CGRectMake(75.0f, 10.0f, 225.0f, 100.0f)];
        [[self labelView] setBackgroundColor: [UIColor grayColor]];
        [self addSubview: [self labelView]];
        
        mAbkLabel = [[UILabel alloc] initWithFrame: CGRectMake(5.0f, 5.0f, 40.0f, 40.0f)];
        [[self abkLabel] setBackgroundColor: [UIColor clearColor]];
        [[self abkLabel] setTextColor: [UIColor whiteColor]];
        [[self abkLabel] setFont: [UIFont systemFontOfSize: 21.0f]];
        [[self abkLabel] setTextAlignment: NSTextAlignmentCenter];
        [[self labelView] addSubview: [self abkLabel]];
        
        mNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(50.0f, 5.0f, 165.0f, 15.0f)];
        [[self nameLabel] setBackgroundColor: [UIColor clearColor]];
        [[self nameLabel] setTextColor: [UIColor whiteColor]];
        [[self nameLabel] setFont: [UIFont systemFontOfSize: 13.0f]];
        [[self labelView] addSubview: [self nameLabel]];
        
        mMassLabel = [[UILabel alloc] initWithFrame: CGRectMake(50.0f, 20.0f, 165.0f, 15.0f)];
        [[self massLabel] setBackgroundColor: [UIColor clearColor]];
        [[self massLabel] setTextColor: [UIColor whiteColor]];
        [[self massLabel] setFont: [UIFont systemFontOfSize: 13.0f]];
        [[self labelView] addSubview: [self massLabel]];
        
        mElConfigLabel = [[UILabel alloc] initWithFrame: CGRectMake(50.0f, 35.0f, 165.0f, 15.0f)];
        [[self elConfigLabel] setBackgroundColor: [UIColor clearColor]];
        [[self elConfigLabel] setTextColor: [UIColor whiteColor]];
        [[self elConfigLabel] setFont: [UIFont systemFontOfSize: 13.0f]];
        [[self labelView] addSubview: [self elConfigLabel]];
        
        mPeriodeLabel = [[UILabel alloc] initWithFrame: CGRectMake(50.0f, 50.0f, 165.0f, 15.0f)];
        [[self periodeLabel] setBackgroundColor: [UIColor clearColor]];
        [[self periodeLabel] setTextColor: [UIColor whiteColor]];
        [[self periodeLabel] setFont: [UIFont systemFontOfSize: 13.0f]];
        [[self labelView] addSubview: [self periodeLabel]];
        
        mGruppeLabel = [[UILabel alloc] initWithFrame: CGRectMake(50.0f, 65.0f, 165.0f, 15.0f)];
        [[self gruppeLabel] setBackgroundColor: [UIColor clearColor]];
        [[self gruppeLabel] setTextColor: [UIColor whiteColor]];
        [[self gruppeLabel] setFont: [UIFont systemFontOfSize: 13.0f]];
        [[self labelView] addSubview: [self gruppeLabel]];
        
        mPaulingLabel = [[UILabel alloc] initWithFrame: CGRectMake(50.0f, 80.0f, 165.0f, 15.0f)];
        [[self paulingLabel] setBackgroundColor: [UIColor clearColor]];
        [[self paulingLabel] setTextColor: [UIColor whiteColor]];
        [[self paulingLabel] setFont: [UIFont systemFontOfSize: 13.0f]];
        [[self labelView] addSubview: [self paulingLabel]];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
