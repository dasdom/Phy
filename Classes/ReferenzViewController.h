//
//  ReferenzViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferenzView.h"

@interface ReferenzViewController : UIViewController <UIPickerViewDelegate,UITextFieldDelegate> {
	ReferenzView *referenzView;
	NSMutableString *faktorString;
	NSArray *gasArray;
	NSArray *fluessigArray;
	NSArray *festArray;
	NSDictionary *dict;
	NSArray *eigenschaften;
	NSDictionary *dict2;
	NSDictionary *mainDict;
	NSInteger segmentIndex;
}

@property (nonatomic, strong) NSArray *gasArray;
@property (nonatomic, strong) NSArray *fluessigArray;
@property (nonatomic, strong) NSArray *festArray;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *eigenschaften;
@property (nonatomic, strong) NSDictionary *dict2;
@property (nonatomic, strong) NSDictionary *mainDict;

- (void)segmentAction: (id)sender;

@end
