//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConverterViewController.h"


@implementation ConverterViewController

- (void)loadView {
	
	converterView = [[ConverterView alloc] init];
	converterModel = [[ConverterModel alloc] init];
	
	converterView.pickerArray0 = converterModel.pickerArray0;
	
	converterView.pickerView.delegate = self;
	converterView.inputValue.delegate = self;
	arrayString = [[NSMutableString alloc] initWithString: @"energieStringArray"];
	
	self.view = converterView;
}

- (ConverterView *)contentView {
    return (ConverterView *)self.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self contentView].inputValue becomeFirstResponder];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (component == 0) {
		[converterView.pickerView selectRow: 0 inComponent: 1 animated: NO];
		[converterView.pickerView selectRow: 0 inComponent: 2 animated: NO];
	}
	
	switch ([converterView.pickerView selectedRowInComponent: 0]) {
		case 0:
			[arrayString setString: @"energieStringArray"];
			break;
		case 1:
			[arrayString setString: @"laengeStringArray"];
			break;
		case 2:
			[arrayString setString: @"druckStringArray"];
			break;
		case 3:
			[arrayString setString: @"zeitStringArray"];
			break;
		case 4:
			[arrayString setString: @"leistungStringArray"];
			break;
		case 5:
			[arrayString setString: @"dichteStringArray"];
			break;
			
		default:
			break;
	}
	// report the selection to the UI labels
	[converterView setValue: [NSString stringWithFormat: @"%@", 
							  [[converterModel valueForKey: arrayString] objectAtIndex: 
							   [converterView.pickerView selectedRowInComponent: 1]]] 
				 forKeyPath: @"einheitInput.text"];
	[converterView setValue: [NSString stringWithFormat: @"%@", 
							  [[converterModel valueForKey: arrayString] objectAtIndex: 
							   [converterView.pickerView selectedRowInComponent: 2]]] 
				 forKeyPath: @"einheitOutput.text"];
    
    [self updateResult:converterView.inputValue.text];
    
	[converterView.pickerView reloadAllComponents];
	[self.view setNeedsDisplay];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *returnString;

	if (component == 0) {
		returnString = NSLocalizedString([converterModel.pickerArray0 objectAtIndex: row], @"");
	} else {
		returnString = [[converterModel valueForKey: arrayString] objectAtIndex: row];
	}
	return returnString;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger returnInt;
	if (component == 0) {
		returnInt = [converterModel.pickerArray0 count];
	} else {
		returnInt = [[converterModel valueForKey: arrayString] count];
	}
	return returnInt;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 3;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateResult:text];
    
    return YES;
}

- (void)updateResult:(NSString *)text {
    NSString *result = [converterModel convertValue: [text doubleValue]
                                            from: [converterView.pickerView selectedRowInComponent: 1]
                                              to: [converterView.pickerView selectedRowInComponent: 2]
                                 withFaktorArray: [converterView.pickerView selectedRowInComponent: 0]];
    converterView.outputValue.text = result;
}

- (void)insertE:(UIBarButtonItem *)sender {
    converterView.inputValue.text = [converterView.inputValue.text stringByAppendingString:@"e"];
    [self updateResult:converterView.inputValue.text];
}

- (void)insertMinus:(UIBarButtonItem *)sender {
    converterView.inputValue.text = [converterView.inputValue.text stringByAppendingString:@"-"];
    [self updateResult:converterView.inputValue.text];
}

@end
