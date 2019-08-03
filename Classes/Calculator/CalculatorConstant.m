//  Created by dasdom on 10.07.19.
//  
//

#import "CalculatorConstant.h"

@implementation CalculatorConstant

- (instancetype)initWithName:(NSString *)name value:(NSString *)value unit:(NSString *)unit {
    
    self = [super init];
    if (self) {
        _name = name;
        _value = value;
        _unit = unit;
    }
    return self;
}

@end
