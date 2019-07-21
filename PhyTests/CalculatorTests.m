//  Created by dasdom on 19.07.19.
//  
//

#import <XCTest/XCTest.h>
#import "Calculator.h"

@interface CalculatorTests : XCTestCase {
    Calculator *calculator;
}
@end

@implementation CalculatorTests

- (void)setUp {
    [super setUp];
    
    calculator = [[Calculator alloc] initWithDeg:YES];
}

- (void)test_calcPower_1 {
    NSDecimalNumber *number = [calculator calculateString:@"2^(1+1)"];
    
    XCTAssertEqualWithAccuracy(4, [number doubleValue], 0.1);
}

- (void)test_calcPower_2 {
    NSDecimalNumber *number = [calculator calculateString:@"(1+1+2)^(1+1)"];
    
    XCTAssertEqualWithAccuracy(16, [number doubleValue], 0.1);
}

- (void)test_calcPower_3 {
    NSDecimalNumber *number = [calculator calculateString:@"1+1+2^(1+1)"];
    
    XCTAssertEqualWithAccuracy(6, [number doubleValue], 0.1);
}

- (void)test_calcPower_4 {
    NSDecimalNumber *number = [calculator calculateString:@"sin(1-1)+1+2^(1+1)"];
    
    XCTAssertEqualWithAccuracy(5, [number doubleValue], 0.1);
}

- (void)test_calcPower_5 {
    NSDecimalNumber *number = [calculator calculateString:@"2^(2^(2))"];
    
    XCTAssertEqualWithAccuracy(16, [number doubleValue], 0.1);
}

- (void)test_calcParentheses_1 {
    NSDecimalNumber *result = [calculator calculateString:@"2×(1-2)"];
    
    XCTAssertEqualWithAccuracy(-2, [result doubleValue], 0.1);
}

- (void)test_calcParentheses_2 {
    NSDecimalNumber *result = [calculator calculateString:@"2×(2×(1-2))"];
    
    XCTAssertEqualWithAccuracy(-4, [result doubleValue], 0.1);
}

@end
