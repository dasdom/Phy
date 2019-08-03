//
//  Calculator.h
//  PhysForm
//
//  Created by Dominik Hauser on 05.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const DDHPlus = @"+";
static NSString * const DDHMinus = @"-";
static NSString * const DDHTimes = @"×";
static NSString * const DDHDivide = @"÷";

@interface Calculator : NSObject {
	BOOL deg;
}

@property BOOL deg;

- (id)initWithDeg:(BOOL)isDeg;
- (NSDecimalNumber *)calculateString:(NSString *)calculationString;
- (NSString *)getFunctionStringFromString:(NSString *)calculationString forFunction:(NSString *)function withRange:(NSRange)range;
- (NSString *)calcExp: (NSString *)dummyCalcString;
- (NSString *)calcLn: (NSString *)dummyCalcString;
- (NSString *)calcLog2: (NSString *)dummyCalcString;
- (NSString *)calcLog10: (NSString *)dummyCalcString;
- (NSString *)calcSin: (NSString *)dummyCalcString;
- (NSString *)calcCos: (NSString *)dummyCalcString;
- (NSString *)calcTan: (NSString *)dummyCalcString;
- (NSString *)calcAsin: (NSString *)dummyCalcString;
- (NSString *)calcAcos: (NSString *)dummyCalcString;
- (NSString *)calcAtan: (NSString *)dummyCalcString;
- (NSString *)calcSqrt: (NSString *)dummyCalcString;
- (NSString *)calcPow: (NSString *)dummyCalcString;
- (NSString *)calcPi: (NSString *)dummyCalcString;
- (NSString *)calcKlammers: (NSString *)dummyCalcString;
- (NSRange)getRangeOfSubstringFromString: (NSString *)orgString bySearchingFor: (NSString *)funcString;
- (NSDecimalNumber *)addFromString: (NSString *)addString;
- (NSDecimalNumber *)subtractFromString: (NSString *)subtractString;
- (NSDecimalNumber *)nDotFromString: (NSString *)nDotString;
- (NSDecimalNumber *)multiplyFromString: (NSString *)multString;
- (NSDecimalNumber *)diffFromString: (NSString *)diffString;
- (NSDecimalNumber *)nDiffFromString: (NSString *)diffString;
- (NSDecimalNumber *)squareFromString: (NSString *)squareString;
- (NSDecimalNumber *)sqminusFromString: (NSString *)squareString;
- (NSDecimalNumber *)eminusFromString: (NSString *)eminusString;
- (NSDecimalNumber *)exponentFromString: (NSString *)exponentString;
+ (NSString *)stringFromResult:(NSDecimalNumber *)decimalNumber;
@end
