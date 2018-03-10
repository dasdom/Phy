//
//  ReferenzView.m
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReferenzView.h"

#define kToolbarHeight			40.0

@implementation ReferenzView

@synthesize pickerView;
@synthesize outputValue;
@synthesize bedingung;
@synthesize material;
@synthesize eigenschaft;
@synthesize quelle;
@synthesize segmentedControl;

- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		screenRect.size.height = screenRect.size.height/2-20;
	}
	CGRect pickerRect = CGRectMake(	0.0,
								   screenRect.size.height - 44.0 - size.height,
								   screenRect.size.width,
								   size.height);
	return pickerRect;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		//pickerArray0 = [[NSArray alloc] initWithObjects: @"Energie", @"Länge", nil];
		pickerView = [[UIPickerView alloc] initWithFrame: CGRectZero];
		CGSize pickerSize = [pickerView sizeThatFits: CGSizeZero];
		pickerView.frame = [self pickerFrameWithSize: pickerSize];
		//[pickerView setDelegate: self];
		[pickerView setShowsSelectionIndicator: YES];
		[self addSubview: pickerView];
		
		/*
		frame = CGRectMake(70, 100, 15, 30);
		gleichZeichen = [[UILabel alloc] initWithFrame: frame];
		[gleichZeichen setText: @"="];
		[gleichZeichen setTextColor: [UIColor whiteColor]];
		[gleichZeichen setBackgroundColor: [UIColor blackColor]];
		[self addSubview: gleichZeichen];
		*/
		CGRect dummyFrame = CGRectMake(10, 70, frame.size.width-20, 30);
		outputValue = [[UILabel alloc] initWithFrame: dummyFrame];
		[outputValue setTextColor: [UIColor whiteColor]];
		[outputValue setBackgroundColor: [UIColor blackColor]];
		[outputValue setTextAlignment: UITextAlignmentCenter];
		[self addSubview: outputValue];
				 
		dummyFrame = CGRectMake(10, 110, frame.size.width-20, 20);
		bedingung = [[UILabel alloc] initWithFrame: dummyFrame];
		[bedingung setTextColor: [UIColor whiteColor]];
		[bedingung setBackgroundColor: [UIColor blackColor]];
		[bedingung setTextAlignment: UITextAlignmentCenter];
		[bedingung setFont: [[bedingung font] fontWithSize: 12]];
		[bedingung setText: @""];
		[self addSubview: bedingung];
		
		dummyFrame = CGRectMake(10, 140, frame.size.width-20, 20);
		quelle = [[UILabel alloc] initWithFrame: dummyFrame];
		[quelle setTextColor: [UIColor whiteColor]];
		[quelle setBackgroundColor: [UIColor blackColor]];
		[quelle setTextAlignment: UITextAlignmentCenter];
		[quelle setFont: [[quelle font] fontWithSize: 9]];
		[quelle setText: NSLocalizedString(@"Quelle: Wikipedia, 03.2010",@"")];
		[self addSubview: quelle];
		
		dummyFrame = CGRectMake(10, 10, frame.size.width-20, 30);
		material = [[UILabel alloc] initWithFrame: dummyFrame];
		[material setTextColor: [UIColor whiteColor]];
		[material setBackgroundColor: [UIColor blackColor]];
		[material setTextAlignment: UITextAlignmentCenter];
		[material setFont: [[material font] fontWithSize: 20]];
		[material setText: @"Test"];
		[self addSubview: material];
		
		dummyFrame = CGRectMake(10, 40, frame.size.width-20, 30);
		eigenschaft = [[UILabel alloc] initWithFrame: dummyFrame];
		[eigenschaft setTextColor: [UIColor whiteColor]];
		[eigenschaft setBackgroundColor: [UIColor blackColor]];
		[eigenschaft setTextAlignment: UITextAlignmentCenter];
		[eigenschaft setFont: [[eigenschaft font] fontWithSize: 18]];
		[eigenschaft setText: @"Test"];
		[self addSubview: eigenschaft];
		
		dummyFrame = CGRectMake(10, 165, frame.size.width-20, 30);
		NSArray *segmentArray = @[NSLocalizedString(@"gasförmig",@""), 
								 NSLocalizedString(@"flüssig",@""), NSLocalizedString(@"fest",@"")];
		segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentArray];
		segmentedControl.frame = dummyFrame;
		segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
		[self addSubview: segmentedControl];
		
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}




@end
