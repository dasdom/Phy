//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Legacy_ConverterModel.h"
#import "Calculator.h"

@implementation Legacy_ConverterModel

//@synthesize pickerArray0; 
//@synthesize energieStringArray, energieFaktorArray;
//@synthesize laengeStringArray, laengeFaktorArray;
//@synthesize druckStringArray, druckFaktorArray;
//@synthesize zeitStringArray, zeitFaktorArray;
//@synthesize leistungStringArray, leistungFaktorArray;
//@synthesize dichteStringArray, dichteFaktorArray;

- (id)init {
	if ((self = [super init])) {
		_pickerArray0 = @[@"Energie", @"Länge", @"Druck", @"Zeit", @"Leistung", @"Dichte"];
		_energieStringArray = @[@"J",   @"MeV",       @"kWh",   @"kpm",     @"kcal",   @"erg"];
		_energieFaktorArray = @[@"1.0", @"1.602e-13", @"3.6e6", @"9.80665", @"4186.8", @"1.0e-7"];
		
		_laengeStringArray = @[@"m",   @"Ly",          @"pc",           @"in",     @"ft",     @"yd",     @"mile", @"Å"];
		_laengeFaktorArray = @[@"1.0", @"9.460730e15", @"30.856776e15", @"0.0254", @"0.3048", @"0.9144", @"1609", @"1.0e-10"];
	
		_druckStringArray = @[@"Pa",  @"MPa", @"bar", @"mbar",  @"at",      @"atm",      @"Torr"];
		_druckFaktorArray = @[@"1.0", @"1e6", @"1e5", @"100.0", @"98066.5", @"101325.0", @"133.0"];
	
		_zeitStringArray = @[@"s",   @"min",  @"h",      @"d",       @"a"];
		_zeitFaktorArray = @[@"1.0", @"60.0", @"3600.0", @"86400.0", @"3.1536e7"];
	
		_leistungStringArray = @[@"W",   @"kW",     @"kpm/s",   @"PS",    @"kcal/h"];
		_leistungFaktorArray = @[@"1.0", @"1000.0", @"9.80665", @"736.0", @"1.16"];
	
		_dichteStringArray = @[@"kg/m³",   @"g/cm³"];
		_dichteFaktorArray = @[@"1.0", @"1e3"];
	}
	return self;
}

- (NSString *)convertValue: (double)value from: (NSInteger)initial to: (NSInteger)final withFaktorArray: (NSInteger)array {
	NSString *selectedArrayName = @"energieFaktorArray";
	switch (array) {
		case 0: 
			selectedArrayName = @"energieFaktorArray";
			break;
		case 1:
			selectedArrayName = @"laengeFaktorArray";
			break;
		case 2:
			selectedArrayName = @"druckFaktorArray";
			break;
		case 3:
			selectedArrayName = @"zeitFaktorArray";
			break;
		case 4:
			selectedArrayName = @"leistungFaktorArray";
			break;
		case 5:
			selectedArrayName = @"dichteFaktorArray";
			break;
		default:
			break;
	}
//  value *= [[[self valueForKey: selectedArray] objectAtIndex: initial] doubleValue];
//  value /= [[[self valueForKey: selectedArray] objectAtIndex: final] doubleValue];
  
  NSArray *selectedArray = [self valueForKey:selectedArrayName];
  
  NSString *calcString = [NSString stringWithFormat:@"%lf%@%@%@%@", value, DDHTimes, selectedArray[initial], DDHDivide, selectedArray[final]];
  
  Calculator *calculator = [[Calculator alloc] initWithDeg:YES];
  NSDecimalNumber *result = [calculator calculateString:calcString];
  
	return [Calculator stringFromResult:result];
}

@end
