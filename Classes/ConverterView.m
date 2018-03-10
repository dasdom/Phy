//
//  ConverterView.m
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConverterView.h"

#define kToolbarHeight 40.0

@implementation ConverterView

@synthesize pickerArray0;
@synthesize pickerView;
@synthesize einheitInput, einheitOutput, outputValue;
@synthesize inputValue;

- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		screenRect.size.height = screenRect.size.height/2-20;
	}
	CGRect pickerRect = CGRectMake(0.0,
								   screenRect.size.height - 44.0 - size.height,
								   screenRect.size.width,
								   size.height);
	return pickerRect;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		//pickerArray0 = [[NSArray alloc] initWithObjects: @"Energie", @"Länge", nil];
        
        self.backgroundColor = [UIColor whiteColor];
        
		pickerView = [[UIPickerView alloc] initWithFrame: CGRectZero];
		CGSize pickerSize = [pickerView sizeThatFits: CGSizeZero];
		pickerView.frame = [self pickerFrameWithSize: pickerSize];
		//[pickerView setDelegate: self];
		[pickerView setShowsSelectionIndicator: YES];
		[self addSubview: pickerView];
		
		CGRect dummyFrame = CGRectMake(65, 150, 240, 30);
		erlaubteZeichen = [[UILabel alloc] initWithFrame: dummyFrame];
		[erlaubteZeichen setText: NSLocalizedString(@"(erlaubte Zeichen: -123456789.e)", @"")];
		[erlaubteZeichen setTextColor: [UIColor grayColor]];
//        [erlaubteZeichen setBackgroundColor: [UIColor blackColor]];
		[erlaubteZeichen setAdjustsFontSizeToFitWidth: YES];
		[self addSubview: erlaubteZeichen];
		
		dummyFrame = CGRectMake(90, 50, 140, 30);
		inputValue = [[UITextField alloc] initWithFrame: dummyFrame];
		[inputValue setPlaceholder: NSLocalizedString(@"Eingabe", @"")];
		[inputValue setTextColor: [UIColor whiteColor]];
//        [inputValue setBackgroundColor: [UIColor blackColor]];
		[inputValue setKeyboardType: UIKeyboardTypeNumbersAndPunctuation];
		[inputValue setTextAlignment: NSTextAlignmentRight];
		[inputValue setBorderStyle: UITextBorderStyleBezel];
		[self addSubview: inputValue];
		
		dummyFrame = CGRectMake(240, 50, 60, 30);
		einheitInput = [[UILabel alloc] initWithFrame: dummyFrame];
		[einheitInput setTextColor: [UIColor whiteColor]];
		[einheitInput setBackgroundColor: [UIColor blackColor]];
		[einheitInput setText: @"J"];
		[self addSubview: einheitInput];
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			dummyFrame = CGRectMake(320, 50, 15, 30);
		} else {
			dummyFrame = CGRectMake(70, 100, 15, 30);
		}
		gleichZeichen = [[UILabel alloc] initWithFrame: dummyFrame];
		[gleichZeichen setText: @"="];
		[gleichZeichen setTextColor: [UIColor whiteColor]];
		[gleichZeichen setBackgroundColor: [UIColor blackColor]];
		[self addSubview: gleichZeichen];
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			dummyFrame = CGRectMake(360, 50, 140, 30);
		} else {
			dummyFrame = CGRectMake(90, 100, 140, 30);
		}
		outputValue = [[UILabel alloc] initWithFrame: dummyFrame];
		[outputValue setTextColor: [UIColor whiteColor]];
		[outputValue setBackgroundColor: [UIColor blackColor]];
		[outputValue setTextAlignment: UITextAlignmentRight];
		[self addSubview: outputValue];
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			dummyFrame = CGRectMake(520, 50, 60, 30);
		} else {
			dummyFrame = CGRectMake(240, 100, 60, 30);
		}

		einheitOutput = [[UILabel alloc] initWithFrame: dummyFrame];
		[einheitOutput setTextColor: [UIColor whiteColor]];
		[einheitOutput setBackgroundColor: [UIColor blackColor]];
		[einheitOutput setText: @"J"];
		[self addSubview: einheitOutput];
    }
    return self;
}
/*
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *returnString;
	switch (component) {
		case 0:
			returnString = [pickerArray0 objectAtIndex: row];
			break;
		default:
			break;
	}
	return returnString;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerArray0 count];
}
*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
}




@end
