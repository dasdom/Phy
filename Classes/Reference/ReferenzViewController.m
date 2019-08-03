//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ReferenzViewController.h"

#import "ReferenzView.h"

@interface ReferenzViewController () <UIPickerViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSArray *gasArray;
@property (nonatomic, strong) NSArray *fluessigArray;
@property (nonatomic, strong) NSArray *festArray;
@property (nonatomic, strong) NSDictionary *materialDict;
@property (nonatomic, strong) NSArray *eigenschaften;
@property (nonatomic, strong) NSDictionary *propertyDict;
@property (nonatomic) NSInteger selectedSegmentIndex;
@end

@implementation ReferenzViewController

- (void)loadView {
    
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Referenz" ofType:@"plist"];
    NSDictionary *mainDict = [[NSDictionary alloc] initWithContentsOfFile: dataPath];
    self.gasArray = mainDict[@"gasfoermig"];
    self.fluessigArray = mainDict[@"fluessig"];
    self.festArray = mainDict[@"fest"];
    
    self.materialDict = self.gasArray.firstObject;
    self.eigenschaften = self.materialDict[@"Eigenschaften"];
    self.propertyDict = self.eigenschaften.firstObject;
    
//    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        screenRect.size.height = screenRect.size.height/2-20;
//    }
    ReferenzView *referenzView = [ReferenzView new];
    
    referenzView.pickerView.delegate = self;
    
    [referenzView updateWithMaterialDict:self.materialDict propertyDict:self.propertyDict];
    
    [referenzView.segmentedControl addTarget:self  action: @selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
    referenzView.segmentedControl.selectedSegmentIndex = 0;
    
    self.view = referenzView;
}

- (ReferenzView *)contentView {
    return (ReferenzView *)self.view;
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    
//    [[self contentView].stackView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = true;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.materialDict = [self materialDictForSegmentIndex:self.selectedSegmentIndex andRow:row];
            
            self.eigenschaften = [self.materialDict objectForKey: @"Eigenschaften"];
            if ([[self contentView].pickerView selectedRowInComponent: 1] > [self.eigenschaften count] - 1) {
                [[self contentView].pickerView selectRow:0 inComponent:1 animated: NO];
                self.propertyDict = self.eigenschaften[0];
            } else {
                self.propertyDict = self.eigenschaften[[[self contentView].pickerView selectedRowInComponent: 1]];
            }
            break;
        case 1:
            self.propertyDict = self.eigenschaften[row];
            break;
    }

    [[self contentView] updateWithMaterialDict:self.materialDict propertyDict:self.propertyDict];
    
    [self.view setNeedsDisplay];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *returnString;
    if (component == 0) {
        NSDictionary *tempDict = [self materialDictForSegmentIndex:self.selectedSegmentIndex andRow:row];
        returnString = NSLocalizedString(tempDict[@"Name"],@"");
    } else {
        self.propertyDict = self.eigenschaften[row];
        returnString = NSLocalizedString(self.propertyDict[@"Name"],@"");
    }
    return returnString;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRows = 0;
    if (component == 0) {
        NSArray *conditionArray = [self conditionArrayForSegmentIndex:self.selectedSegmentIndex];
        numberOfRows = [conditionArray count];
    } else {
        numberOfRows = [self.eigenschaften count];
    }
    return numberOfRows;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (void)segmentAction:(id)sender {
    self.selectedSegmentIndex = [sender selectedSegmentIndex];
    [[self contentView].pickerView selectRow: 0 inComponent: 0 animated: NO];
    [[self contentView].pickerView selectRow: 0 inComponent: 1 animated: NO];
    
    self.materialDict = [self materialDictForSegmentIndex:self.selectedSegmentIndex andRow:0];
    
    self.eigenschaften = self.materialDict[@"Eigenschaften"];
    
    self.propertyDict = self.eigenschaften.firstObject;
    
    [[self contentView] updateWithMaterialDict:self.materialDict propertyDict:self.propertyDict];
}

- (NSDictionary *)materialDictForSegmentIndex:(NSInteger)segmentIndex andRow:(NSInteger)row {
    NSArray *conditionArray = [self conditionArrayForSegmentIndex:segmentIndex];
    return conditionArray[row];
}

- (NSArray *)conditionArrayForSegmentIndex:(NSInteger)segmentIndex {
    NSCParameterAssert(segmentIndex < 3);
    if (segmentIndex == 0) {
        return self.gasArray;
    } else if (segmentIndex == 1) {
        return self.fluessigArray;
    } else if (segmentIndex == 2) {
        return self.festArray;
    }
    return nil;
}

@end
