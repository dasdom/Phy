//
//  drawTest.m
//  PhysForm
//
//  Created by Dominik Hauser on 13.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "drawTest.h"


@implementation drawTest


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
	//[self setBackgroundColor: [UIColor whiteColor]]; 
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGRect bruchstrich = CGRectMake(0, 0, 300, 2);
	[[UIColor blackColor] set];
	UIRectFill(bruchstrich);
}




@end
