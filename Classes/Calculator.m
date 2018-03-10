//
//  Calculator.m
//  PhysForm
//
//  Created by Dominik Hauser on 05.12.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Calculator.h"

#define kFastNull pow(10, -15)

@implementation Calculator

@synthesize deg;

- (id)initWithDeg:(BOOL)isDeg {
	if (self = [super init]) {
		[self setDeg:isDeg];
	}
	return self;
}

- (NSDecimalNumber *)calculateString:(NSString *)calculationString {    
	NSMutableString *mutableCalcString = [[NSMutableString alloc] initWithString: calculationString];
	
	NSArray *eMinus = [mutableCalcString componentsSeparatedByString: @"e-"];
	[mutableCalcString setString: [eMinus objectAtIndex: 0]];
	for (int i = 1; i < [eMinus count]; i++) {
		[mutableCalcString appendFormat: @"Eminus"];
		[mutableCalcString appendString: [eMinus objectAtIndex: i]];
	}
	
	NSArray *ePlus = [mutableCalcString componentsSeparatedByString: @"e+"];
	[mutableCalcString setString: [ePlus objectAtIndex: 0]];
	for (int i = 1; i < [ePlus count]; i++) {
		[mutableCalcString appendFormat: @"e"];
		[mutableCalcString appendString: [ePlus objectAtIndex: i]];
	}
	
	NSArray *squareMinus = [mutableCalcString componentsSeparatedByString: @"^-"];
	[mutableCalcString setString: [squareMinus objectAtIndex: 0]];
	for (int i = 1; i < [squareMinus count]; i++) {
		[mutableCalcString appendFormat: @"Sqminus"];
		[mutableCalcString appendString: [squareMinus objectAtIndex: i]];
	}
	
	NSArray *squarePlus = [mutableCalcString componentsSeparatedByString: @"^+"];
	[mutableCalcString setString: [squarePlus objectAtIndex: 0]];
	for (int i = 1; i < [squarePlus count]; i++) {
		[mutableCalcString appendFormat: @"^"];
		[mutableCalcString appendString: [squarePlus objectAtIndex: i]];
	}
	
	while ([mutableCalcString rangeOfString: @"pow("].location != NSNotFound) {
		NSString *addString = [self calcPow: mutableCalcString];
		[mutableCalcString setString: addString];
	}			
	while ([mutableCalcString rangeOfString: @"exp("].location != NSNotFound) {
		NSString *addString = [self calcExp: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"ln("].location != NSNotFound) {
		NSString *addString = [self calcLn: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"log2("].location != NSNotFound) {
		NSString *addString = [self calcLog2: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"log10("].location != NSNotFound) {
		NSString *addString = [self calcLog10: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"asin("].location != NSNotFound) {
		NSString *addString = [self calcAsin: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"acos("].location != NSNotFound) {
		NSString *addString = [self calcAcos: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"atan("].location != NSNotFound) {
		NSString *addString = [self calcAtan: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"sin("].location != NSNotFound) {
		NSString *addString = [self calcSin: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"cos("].location != NSNotFound) {
		NSString *addString = [self calcCos: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"tan("].location != NSNotFound) {
		NSString *addString = [self calcTan: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"pi"].location != NSNotFound) {
		NSString *addString = [self calcPi: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	while ([mutableCalcString rangeOfString: @"sqrt("].location != NSNotFound) {
		NSString *addString = [self calcSqrt: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	
	while ([mutableCalcString rangeOfString: @"("].location != NSNotFound) {
		NSString *addString = [self calcKlammers: mutableCalcString];
		[mutableCalcString setString: addString];
	}
	
	NSArray *findNDot = [mutableCalcString componentsSeparatedByString: @"*-"];
	[mutableCalcString setString: [findNDot objectAtIndex: 0]];
	for (int i = 1; i < [findNDot count]; i++) {
		[mutableCalcString appendFormat: @"ndot"];
		[mutableCalcString appendString: [findNDot objectAtIndex: i]];
	}
    
    NSArray *findNDiff = [mutableCalcString componentsSeparatedByString: @"/-"];
	[mutableCalcString setString: [findNDiff objectAtIndex: 0]];
	for (int i = 1; i < [findNDiff count]; i++) {
		[mutableCalcString appendFormat: @"ndiff"];
		[mutableCalcString appendString: [findNDiff objectAtIndex: i]];
	}
	
	NSArray *findMinusMinus = [mutableCalcString componentsSeparatedByString: @"--"];
	[mutableCalcString setString: [findMinusMinus objectAtIndex: 0]];
	for (int i = 1; i < [findMinusMinus count]; i++) {
		[mutableCalcString appendFormat: @"+"];
		[mutableCalcString appendString: [findMinusMinus objectAtIndex: i]];
	}
    
    NSArray *findPlusMinus = [mutableCalcString componentsSeparatedByString: @"+-"];
	[mutableCalcString setString: [findPlusMinus objectAtIndex: 0]];
	for (int i = 1; i < [findPlusMinus count]; i++) {
		[mutableCalcString appendFormat: @"-"];
		[mutableCalcString appendString: [findPlusMinus objectAtIndex: i]];
	}
	
    eMinus = [mutableCalcString componentsSeparatedByString: @"e-"];
	[mutableCalcString setString: [eMinus objectAtIndex: 0]];
	for (int i = 1; i < [eMinus count]; i++) {
		[mutableCalcString appendFormat: @"Eminus"];
		[mutableCalcString appendString: [eMinus objectAtIndex: i]];
	}
	
	ePlus = [mutableCalcString componentsSeparatedByString: @"e+"];
	[mutableCalcString setString: [ePlus objectAtIndex: 0]];
	for (int i = 1; i < [ePlus count]; i++) {
		[mutableCalcString appendFormat: @"e"];
		[mutableCalcString appendString: [ePlus objectAtIndex: i]];
	}
    
	return [self addFromString: mutableCalcString];
}

- (NSString *)getFunctionStringFromString:(NSString *)calculationString forFunction:(NSString *)function withRange:(NSRange)range {
	NSRange funcRange = NSMakeRange(range.location + [function length], range.length - [function length] - 1);
	NSString *funcString = [calculationString substringWithRange: funcRange];
	NSMutableString *dummyString = [[NSMutableString alloc] initWithString: funcString];
	if ([dummyString rangeOfString: @"pow("].location != NSNotFound) {
		[dummyString setString: [self calcPow: dummyString]];
	}
	if ([dummyString rangeOfString: @"exp("].location != NSNotFound) {
		[dummyString setString: [self calcExp: dummyString]];
	}
	if ([dummyString rangeOfString: @"ln("].location != NSNotFound) {
		[dummyString setString: [self calcLn: dummyString]];
	}
	if ([dummyString rangeOfString: @"log2("].location != NSNotFound) {
		[dummyString setString: [self calcLog2: dummyString]];
	}
	if ([dummyString rangeOfString: @"log10("].location != NSNotFound) {
		[dummyString setString: [self calcLog10: dummyString]];
	}
	if ([dummyString rangeOfString: @"asin("].location != NSNotFound) {
		[dummyString setString: [self calcAsin: dummyString]];
	}
	if ([dummyString rangeOfString: @"acos("].location != NSNotFound) {
		[dummyString setString: [self calcAcos: dummyString]];
	}
	if ([dummyString rangeOfString: @"atan("].location != NSNotFound) {
		[dummyString setString: [self calcAtan: dummyString]];
	}
	if ([dummyString rangeOfString: @"sin("].location != NSNotFound) {
		[dummyString setString: [self calcSin: dummyString]];
	}
	if ([dummyString rangeOfString: @"cos("].location != NSNotFound) {
		[dummyString setString: [self calcCos: dummyString]];
	}
	if ([dummyString rangeOfString: @"tan("].location != NSNotFound) {
		[dummyString setString: [self calcTan: dummyString]];
	}
	if ([dummyString rangeOfString: @"pi"].location != NSNotFound) {
		[dummyString setString: [self calcPi: dummyString]];
	}
	if ([dummyString rangeOfString: @"sqrt("].location != NSNotFound) {
		[dummyString setString: [self calcSqrt: dummyString]];
	}
	if ([dummyString rangeOfString: @"("].location != NSNotFound) {
		[dummyString setString: [self calcKlammers: dummyString]];
	}
	
	return dummyString;
}

#pragma mark -
#pragma mark calcFunktions

- (NSString *)calcExp: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"exp("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double expOfString = exp([[self addFromString: [self getFunctionStringFromString:dummyCalcString forFunction:@"exp(" withRange: range]] doubleValue]);
	NSDecimalNumber *expResult;
	if (expOfString > kFastNull || expOfString < -kFastNull) {
		expResult = [[NSDecimalNumber alloc] initWithDouble: expOfString];
	} else {
		expResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, expResult, subString2];
	return returnString;
}

- (NSString *)calcLn: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"ln("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double lnOfString = log([[self addFromString: 
							  [self getFunctionStringFromString:dummyCalcString 
													forFunction:@"ln(" withRange: range]] doubleValue]);
	NSDecimalNumber *lnResult;
	if (lnOfString > kFastNull || lnOfString < -kFastNull) {
		lnResult = [[NSDecimalNumber alloc] initWithDouble: lnOfString];
	} else {
		lnResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, lnResult, subString2];
	return returnString;
}

- (NSString *)calcLog2: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"log2("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double log2OfString = log2([[self addFromString: 
								 [self getFunctionStringFromString:dummyCalcString 
													   forFunction:@"log2(" withRange:range]] doubleValue]);
	NSDecimalNumber *log2Result;
	if (log2OfString > kFastNull || log2OfString < -kFastNull) {
		log2Result = [[NSDecimalNumber alloc] initWithDouble: log2OfString]; 
	} else {
		log2Result = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, log2Result, subString2];
	return returnString;
}

- (NSString *)calcLog10: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"log10("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double log10OfString = log10([[self addFromString: 
								   [self getFunctionStringFromString:dummyCalcString 
														 forFunction:@"log10(" withRange:range]] doubleValue]);
	NSDecimalNumber *log10Result;
	if (log10OfString > kFastNull || log10OfString < -kFastNull) {
		log10Result = [[NSDecimalNumber alloc] initWithDouble: log10OfString];
	} else {
		log10Result = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, log10Result, subString2];
	return returnString;
}

- (NSString *)calcSin: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"sin("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double sinOfString;
	if (self.deg == YES) {
		sinOfString = sin(M_PI/180.0*[[self addFromString:
									   [self getFunctionStringFromString:dummyCalcString 
															 forFunction:@"sin(" withRange:range]] doubleValue]);
	} else {
		sinOfString = sin([[self addFromString:
							[self getFunctionStringFromString:dummyCalcString 
												  forFunction:@"sin(" withRange:range]] doubleValue]);
	}
	NSDecimalNumber *sinResult; 
	if (sinOfString > kFastNull || sinOfString < -kFastNull) {
		sinResult = [[NSDecimalNumber alloc] initWithDouble: sinOfString];
	} else {
		sinResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, sinResult, subString2];
	return returnString;
}

- (NSString *)calcCos: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"cos("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	NSDecimalNumber *cosResult;
	double cosOfString;
	if (self.deg == YES) {
		cosOfString = cos(M_PI/180.0*[[self addFromString: 
									   [self getFunctionStringFromString:dummyCalcString 
															 forFunction:@"cos(" withRange:range]] doubleValue]);
	} else {
		cosOfString = cos([[self addFromString: 
							[self getFunctionStringFromString:dummyCalcString 
												  forFunction:@"cos(" withRange:range]] doubleValue]);
	}
	if (cosOfString > kFastNull || cosOfString < -kFastNull) {
		cosResult = [[NSDecimalNumber alloc] initWithDouble: cosOfString];
	} else {
		cosResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, cosResult, subString2];
	return returnString;
}

- (NSString *)calcTan: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"tan("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double tanOfString;
	if (self.deg == YES) {
		tanOfString = tan(M_PI/180.0*[[self addFromString: 
									   [self getFunctionStringFromString:dummyCalcString 
															 forFunction:@"tan(" withRange:range]] doubleValue]);
	} else {
		tanOfString = tan([[self addFromString: 
							[self getFunctionStringFromString:dummyCalcString 
												  forFunction:@"tan(" withRange:range]] doubleValue]);
	}
	NSDecimalNumber *tanResult;
	if (tanOfString > kFastNull || tanOfString < -kFastNull) {
		tanResult = [[NSDecimalNumber alloc] initWithDouble: tanOfString];
	} else {
		tanResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, tanResult, subString2];
	return returnString;
}

- (NSString *)calcAsin: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"asin("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double asinOfString = asin([[self addFromString: 
								 [self getFunctionStringFromString:dummyCalcString 
													   forFunction:@"asin(" withRange:range]] doubleValue]);
	if (self.deg == YES) {
		asinOfString *= 180.0/M_PI;
	}
	NSDecimalNumber *asinResult;
	if (asinOfString > kFastNull || asinOfString < -kFastNull) {
		asinResult = [[NSDecimalNumber alloc] initWithDouble: asinOfString];
	} else {
		asinResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, asinResult, subString2];
	return returnString;
}

- (NSString *)calcAcos: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"acos("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double acosOfString = acos([[self addFromString: 
								 [self getFunctionStringFromString:dummyCalcString 
													   forFunction:@"acos(" withRange:range]] doubleValue]);
	if (self.deg == YES) {
		acosOfString *= 180.0/M_PI;
	}
	NSDecimalNumber *acosResult;
	if (acosOfString > kFastNull || acosOfString < -kFastNull) {
		acosResult = [[NSDecimalNumber alloc] initWithDouble: acosOfString];
	} else {
		acosResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, acosResult, subString2];
	return returnString;
}

- (NSString *)calcAtan: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"atan("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	double atanOfString = atan([[self addFromString: 
								 [self getFunctionStringFromString:dummyCalcString 
													   forFunction:@"atan(" withRange:range]] doubleValue]);
	if (self.deg == YES) {
		atanOfString *= 180.0/M_PI;
	}
	NSDecimalNumber *atanResult;
	if (atanOfString > kFastNull || atanOfString < -kFastNull) {
		atanResult = [[NSDecimalNumber alloc] initWithDouble: atanOfString];
	} else {
		atanResult = [[NSDecimalNumber alloc] initWithDouble: 0.0];
	}
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, atanResult, subString2];
	return returnString;
}

- (NSString *)calcSqrt: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"sqrt("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
    NSLog(@"subString1: %@", subString1);
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
    NSLog(@"subString2: %@", subString2);
    NSDecimalNumber *sqrtResult = [[NSDecimalNumber alloc] initWithDouble:
								   sqrt([[self addFromString: 
										  [self getFunctionStringFromString:dummyCalcString 
																forFunction:@"sqrt(" withRange:range]] doubleValue])];
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, sqrtResult, subString2];
	return returnString;
}

- (NSString *)calcPow: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"pow("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	//NSDecimalNumber *powResult = [[NSDecimalNumber alloc] initWithDouble: 
	//							   sqrt([self addFromString: [self getFunctionStringFromString: dummyCalcString forFunction: @"pow(" withRange: range]])];
	
	NSArray *kommaArray = [dummyCalcString componentsSeparatedByString: @","];
	NSRange range1 = NSMakeRange(range.location, [[kommaArray objectAtIndex: 0] length] + 1 - range.location);
	NSRange range2 = NSMakeRange([[kommaArray objectAtIndex: 0] length], range.length - range1.length + 1);
	NSDecimalNumber *powResult = [[NSDecimalNumber alloc] initWithDouble: 
								  pow([[self addFromString: 
										[self getFunctionStringFromString:dummyCalcString 
															  forFunction:@"pow(" withRange:range1]] doubleValue],
									  [[self addFromString: 
										[self getFunctionStringFromString:dummyCalcString 
															  forFunction:@"," withRange:range2]] doubleValue])];					  
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, powResult, subString2];
	return returnString;
}

- (NSString *)calcPi: (NSString *)dummyCalcString {
	NSRange range = [dummyCalcString rangeOfString: @"pi"];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	//long double piResult = M_PI;
	//NSString *longPi = [[NSString alloc] initWithFormat: @"%LF", pi];
	NSDecimalNumber *piResult = [[NSDecimalNumber alloc] initWithDouble: M_PI];
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, piResult, subString2];
	return returnString;
}


- (NSString *)calcKlammers: (NSString *)dummyCalcString {
	NSRange range = [self getRangeOfSubstringFromString: dummyCalcString bySearchingFor: @"("];
	NSInteger indexForSubstring = range.location;
	NSString *subString1 = [dummyCalcString substringToIndex: indexForSubstring];
	indexForSubstring = range.location + range.length;
	NSString *subString2 = [dummyCalcString substringFromIndex: indexForSubstring];
	NSDecimalNumber *klammerResult = [[NSDecimalNumber alloc] initWithDouble: 
									  [[self addFromString: 
										[self getFunctionStringFromString:dummyCalcString 
															  forFunction:@"(" withRange:range]] doubleValue]]; 
	NSString *returnString = [[NSString alloc] initWithFormat: @"%@%@%@", subString1, klammerResult, subString2];
	return returnString;
}


- (NSRange)getRangeOfSubstringFromString: (NSString *)orgString bySearchingFor: (NSString *)funcString {
	NSRange range = [orgString rangeOfString: funcString];
	NSInteger indexForSubstring = range.location + range.length;
	NSString *subString = [orgString substringFromIndex: indexForSubstring];		
	NSArray *array1 = [subString componentsSeparatedByString: @"("];
	NSArray *array2 = [subString componentsSeparatedByString: @")"];
	NSInteger length1 = [[array1 objectAtIndex: 0] length];
	NSInteger length2 = [[array2 objectAtIndex: 0] length];
	NSInteger intNumber=1;
	//NSMutableString *dummyString = [[[NSMutableString alloc] initWithString: [array2 objectAtIndex: 0]] autorelease];
	while (length1 < length2) {
		//[dummyString appendString: @")"];
		length1 += 1; //fuer die Klammer
		length1 += [[array1 objectAtIndex: intNumber] length];
		if ([array2 count] > intNumber) {
			length2 += [[array2 objectAtIndex: intNumber] length];
			length2 += 1; //fuer die Klammer
		}
		//[dummyString appendString: [array2 objectAtIndex: intNumber]];
		intNumber++;
	}
	NSRange rangeOfFunction;
	rangeOfFunction.location = range.location;
	rangeOfFunction.length = range.length + length2 + 1; 
	return rangeOfFunction;
	
}

- (NSDecimalNumber *)addFromString: (NSString *)addString {
	//double sum = 0.0;
	NSArray *plusStrings = [addString componentsSeparatedByString: @"+"];
	/*
	 for (int i = 0; i < [plusStrings count]; i++) {
	 sum += [self subtractFromString: [plusStrings objectAtIndex: i]];
	 }
	 return sum;
	 */
	
	NSDecimalNumber *decimalNumber1 = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 0.0];
	//NSDecimalNumber *decimalNumber1 = [self subtractFromString:[plusStrings objectAtIndex:0]];
	for (int i = 0; i < [plusStrings count]; i++) {
		//decimalNumber1 = [decimalNumber1 decimalNumberByAdding:[self subtractFromString:[plusStrings objectAtIndex: i]] 
		//										  withBehavior:decimalNumberHandler];
		decimalNumber1 = [decimalNumber1 decimalNumberByAdding:[self subtractFromString:[plusStrings objectAtIndex: i]]];
	}
	return decimalNumber1;
}

- (NSDecimalNumber *)subtractFromString: (NSString *)subtractString {
	NSArray *subtractionStrings = [subtractString componentsSeparatedByString: @"-"];
	/*double subtractionResult;
	 if ([[subtractionStrings objectAtIndex: 0] isEqualToString: @""])
	 subtractionResult = 0;
	 else 
	 subtractionResult = [self nDotFromString: [subtractionStrings objectAtIndex: 0]];
	 for (int i = 1; i < [subtractionStrings count]; i++) {
	 subtractionResult -= [self nDotFromString: [subtractionStrings objectAtIndex: i]];
	 }
	 return subtractionResult;
	 */
	NSDecimalNumber *decimalNumber1;
	if ([[subtractionStrings objectAtIndex: 0] isEqualToString: @""])
		decimalNumber1 = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:0];
	else 
		decimalNumber1 = [self nDotFromString: [subtractionStrings objectAtIndex: 0]];
	for (int i = 1; i < [subtractionStrings count]; i++) {
		decimalNumber1 = [decimalNumber1 decimalNumberBySubtracting:
						  [self nDotFromString: [subtractionStrings objectAtIndex: i]]];
	}
	return decimalNumber1;
}

- (NSDecimalNumber *)nDotFromString: (NSString *)nDotString {
	NSArray *nDotStrings = [nDotString componentsSeparatedByString: @"ndot"];
	/*
	 double nDotResult = 1;
	 nDotResult = [self multiplyFromString: [nDotStrings objectAtIndex: 0]];
	 for (int i = 1; i < [nDotStrings count]; i++) {
	 nDotResult *= [self multiplyFromString: [nDotStrings objectAtIndex: i]];
	 nDotResult *= -1;
	 }
	 return nDotResult;
	 */
	NSDecimalNumber *decimalNumber1 = [self multiplyFromString:[nDotStrings objectAtIndex:0]];
	for (int i = 1; i < [nDotStrings count]; i++) {
		decimalNumber1 = [decimalNumber1 decimalNumberByMultiplyingBy: 
						  [self	multiplyFromString:[nDotStrings objectAtIndex:i]]];
		decimalNumber1 = [decimalNumber1 decimalNumberByMultiplyingBy: 
						  (NSDecimalNumber *)[NSDecimalNumber numberWithInt: -1]];
	}
	return decimalNumber1;
}

- (NSDecimalNumber *)multiplyFromString: (NSString *)multString {
	NSArray *multStrings = [multString componentsSeparatedByString: @"*"];
    /*
	 double multResult;
	 for (int i = 0; i < [multStrings count]; i++) {
	 multResult *= [self diffFromString: [multStrings objectAtIndex: i]];
	 }
	 return multResult;
	 */
	NSDecimalNumber *decimalNumber1 = [self diffFromString: [multStrings objectAtIndex: 0]];
	for (int i = 1; i < [multStrings count]; i++) {
		decimalNumber1 = [decimalNumber1 decimalNumberByMultiplyingBy: 
						  [self diffFromString: [multStrings objectAtIndex: i]]];
	}
	return decimalNumber1;
}
/*
 - (double)diffFromString: (NSString *)diffString {
 double diffResult;
 NSArray *diffStrings = [diffString componentsSeparatedByString: @"/"];
 diffResult = [[NSDecimalNumber decimalNumberWithString: [diffStrings objectAtIndex: 0]] doubleValue];
 for (int i = 1; i < [diffStrings count]; i++) {
 //sum += [[NSDecimalNumber decimalNumberWithString: [plusStrings objectAtIndex: i]] doubleValue];
 diffResult /= [[NSDecimalNumber decimalNumberWithString: [diffStrings objectAtIndex: i]] doubleValue];
 }
 return diffResult;
 }
 */
- (NSDecimalNumber *)diffFromString: (NSString *)diffString {
	NSArray *diffStrings = [diffString componentsSeparatedByString: @"/"];
	NSDecimalNumber *decimalNumber1 = [self nDiffFromString:[diffStrings objectAtIndex:0]];
	for (int i = 1; i < [diffStrings count]; i++) {
		decimalNumber1 = [decimalNumber1 decimalNumberByDividingBy:
						  [self nDiffFromString:[diffStrings objectAtIndex:1]]]; 
	}
	return decimalNumber1;
}

- (NSDecimalNumber *)nDiffFromString: (NSString *)diffString {
	NSArray *diffStrings = [diffString componentsSeparatedByString: @"ndiff"];
	NSDecimalNumber *decimalNumber1 = [self squareFromString:[diffStrings objectAtIndex:0]];
	for (int i = 1; i < [diffStrings count]; i++) {
		decimalNumber1 = [decimalNumber1 decimalNumberByDividingBy:
						  [self squareFromString:[diffStrings objectAtIndex:1]]];
        decimalNumber1 = [decimalNumber1 decimalNumberByMultiplyingBy:
						  (NSDecimalNumber *)[NSDecimalNumber numberWithInt: -1]];
	}
	return decimalNumber1;
}


- (NSDecimalNumber *)squareFromString: (NSString *)squareString {
	NSArray *squareStrings = [squareString componentsSeparatedByString: @"^"];
	NSDecimalNumber *decimalNumber1 = [self sqminusFromString:[squareStrings objectAtIndex:0]];
	NSDecimalNumber *decimalNumber3 = decimalNumber1;
	if ([squareStrings count] > 1) {
		NSDecimalNumber *decimalNumber2 = [NSDecimalNumber decimalNumberWithString:[squareStrings objectAtIndex:1]];
		decimalNumber3 = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 
											 pow([decimalNumber1 doubleValue], [decimalNumber2 doubleValue])];
	}
	return decimalNumber3;
	
}

- (NSDecimalNumber *)sqminusFromString: (NSString *)squareString {
	NSArray *squareStrings = [squareString componentsSeparatedByString: @"Sqminus"];
	NSDecimalNumber *decimalNumber1 = [self eminusFromString:[squareStrings objectAtIndex:0]];
	NSDecimalNumber *decimalNumber3 = decimalNumber1;
	if ([squareStrings count] > 1) {
		NSDecimalNumber *decimalNumber2 = [NSDecimalNumber decimalNumberWithString:[squareStrings objectAtIndex:1]];
		decimalNumber3 = (NSDecimalNumber *)[NSDecimalNumber numberWithDouble: 
											 pow([decimalNumber1 doubleValue], -[decimalNumber2 doubleValue])];
	}
	return decimalNumber3;
	
}

- (NSDecimalNumber *)eminusFromString: (NSString *)eminusString {
	NSArray *eminusStrings = [eminusString componentsSeparatedByString: @"Eminus"];
	NSDecimalNumber *decimalNumber1 = [self exponentFromString:[eminusStrings objectAtIndex:0]];
	BOOL negative = NO;
	unsigned long long ma = [[decimalNumber1 decimalNumberByMultiplyingByPowerOf10:15] unsignedLongLongValue];
	NSDecimalNumber *decimalNumber2 = decimalNumber1; 
	if ([eminusStrings count] > 1) {
		short ex = [[NSDecimalNumber decimalNumberWithString:[eminusStrings objectAtIndex:1]] shortValue]+15;
		decimalNumber2 = [NSDecimalNumber decimalNumberWithMantissa:ma exponent:-ex isNegative:negative];
	}
	return decimalNumber2;
}

- (NSDecimalNumber *)exponentFromString: (NSString *)exponentString {
	NSArray *exponentStrings = [exponentString componentsSeparatedByString: @"e"];
	NSDecimalNumber *decimalNumber1 = [NSDecimalNumber decimalNumberWithString:[exponentStrings objectAtIndex:0]];
	BOOL negative = NO;
	unsigned long long ma = [[decimalNumber1 decimalNumberByMultiplyingByPowerOf10:15] unsignedLongLongValue];
	NSDecimalNumber *decimalNumber2 = [NSDecimalNumber decimalNumberWithString:[exponentStrings objectAtIndex:0]]; 
	if ([exponentStrings count] > 1) {
		short ex = [[NSDecimalNumber decimalNumberWithString:[exponentStrings objectAtIndex:1]] shortValue]-15;
		decimalNumber2 = [NSDecimalNumber decimalNumberWithMantissa:ma exponent:ex isNegative:negative];
	}
	return decimalNumber2;	
}

@end
