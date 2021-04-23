//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Legacy_ConverterView.h"
#import "Legacy_ConverterModel.h"

@interface Legacy_ConverterViewController : UIViewController <UIPickerViewDelegate, UITextFieldDelegate> {
  Legacy_ConverterView *converterView;
  Legacy_ConverterModel *converterModel;
	NSMutableString *arrayString;
	NSMutableString *faktorString;
}

@end
