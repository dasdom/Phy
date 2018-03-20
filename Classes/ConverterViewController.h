//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConverterView.h"
#import "ConverterModel.h"

@interface ConverterViewController : UIViewController <UIPickerViewDelegate,UITextFieldDelegate> {
	ConverterView *converterView;
	ConverterModel *converterModel;
	NSMutableString *arrayString;
	NSMutableString *faktorString;
}

@end
