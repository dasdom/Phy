//  Created by dasdom on 19.07.19.
//  
//

#import <XCTest/XCTest.h>
#import "Legacy_Calculator.h"

@interface Legacy_CalculatorTests : XCTestCase {
    Legacy_Calculator *calculator;
}
@end

@implementation Legacy_CalculatorTests

- (void)setUp {
    [super setUp];
    
    calculator = [[Legacy_Calculator alloc] initWithDeg:YES];
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

- (void)test_calcPower_6 {
    NSDecimalNumber *result = [calculator calculateString:@"(0-1)^(2)"];
    
    XCTAssertEqualWithAccuracy(1, [result doubleValue], 0.1);
}

- (void)test_calcPower_7 {
    NSDecimalNumber *result = [calculator calculateString:@"(-1)^(2)"];
    
    XCTAssertEqualWithAccuracy(1, [result doubleValue], 0.1);
}

- (void)test_calcPower_8 {
    NSDecimalNumber *result = [calculator calculateString:@"(1-2)^(2)"];
    
    XCTAssertEqualWithAccuracy(1, [result doubleValue], 0.1);
}

- (void)test_calcPower_9 {
    NSDecimalNumber *result = [calculator calculateString:@"(-1-1)^(2)"];
    
    XCTAssertEqualWithAccuracy(4, [result doubleValue], 0.1);
}

- (void)test_calcPower_10 {
    NSDecimalNumber *result = [calculator calculateString:@"2^2"];
    
    XCTAssertEqualWithAccuracy(4, [result doubleValue], 0.1);
}

- (void)test_calcPower_11 {
    NSDecimalNumber *result = [calculator calculateString:@"2^2.2"];
    
    XCTAssertEqualWithAccuracy(4.59479341998814, [result doubleValue], 0.0000000001);
}

- (void)test_calcPower_12 {
    NSDecimalNumber *result = [calculator calculateString:@"2.2^2.2"];
    
    XCTAssertEqualWithAccuracy(5.666695778750081, [result doubleValue], 0.0000000001);
}

- (void)test_calcPower_13 {
    NSDecimalNumber *result = [calculator calculateString:@"2^2e2"];
    
    XCTAssertEqualWithAccuracy(1.6069380442589903e+60, [result doubleValue], 1e50);
}

#pragma mark - Parentheses

- (void)test_calcParentheses_1 {
    NSDecimalNumber *result = [calculator calculateString:@"2×(1-2)"];
    
    XCTAssertEqualWithAccuracy(-2, [result doubleValue], 0.1);
}

- (void)test_calcParentheses_2 {
    NSDecimalNumber *result = [calculator calculateString:@"2×(2×(1-2))"];
    
    XCTAssertEqualWithAccuracy(-4, [result doubleValue], 0.1);
}

#pragma mark - Sqrt

- (void)test_calcSqrt_1 {
    NSDecimalNumber *result = [calculator calculateString:@"sqrt(1)"];
    
    XCTAssertEqualWithAccuracy(1, [result doubleValue], 0.0000000001);
}

- (void)test_calcSqrt_2 {
    NSDecimalNumber *result = [calculator calculateString:@"sqrt(2)"];
    
    XCTAssertEqualWithAccuracy(1.4142135623730951, [result doubleValue], 0.0000000001);
}

- (void)test_calcSeveralParentheses {
  NSDecimalNumber *result = [calculator calculateString:@"sqrt((2×2.99792458e8^2)^2+(2×2.99792458e8)^2)"];

  XCTAssertEqualWithAccuracy(1.797510357e17, [result doubleValue], 0.000000001e17);
}

@end
