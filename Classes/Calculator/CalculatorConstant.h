//  Created by dasdom on 10.07.19.
//  
//

#import <Foundation/Foundation.h>

@interface CalculatorConstant : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *unit;
- (instancetype)initWithName:(NSString *)name value:(NSString *)value unit:(NSString *)unit;
@end
