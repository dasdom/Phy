//
//  ConverterModel.m
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConverterModel.h"


@implementation ConverterModel

@synthesize pickerArray0; 
@synthesize energieStringArray, energieFaktorArray;
@synthesize laengeStringArray, laengeFaktorArray;
@synthesize druckStringArray, druckFaktorArray;
@synthesize zeitStringArray, zeitFaktorArray;
@synthesize leistungStringArray, leistungFaktorArray;
@synthesize dichteStringArray, dichteFaktorArray;

- (id)init {
	if ((self = [super init])) {
		pickerArray0 = @[@"Energie", @"Länge", @"Druck", @"Zeit", @"Leistung", @"Dichte"];
		energieStringArray = @[@"J",   @"MeV",       @"kWh",   @"kpm",     @"kcal",   @"erg"];
		energieFaktorArray = @[@"1.0", @"1.602e-13", @"3.6e6", @"9.80665", @"4186.8", @"1.0e-7"];
		
		laengeStringArray = @[@"m",   @"Ly",          @"pc",           @"in",     @"ft",     @"yd",     @"mile", @"Å"];
		laengeFaktorArray = @[@"1.0", @"9.460730e15", @"30.856776e15", @"0.0254", @"0.3048", @"0.9144", @"1609", @"1.0e-10"];
	
		druckStringArray = @[@"Pa",  @"MPa", @"bar", @"mbar",  @"at",      @"atm",      @"Torr"];
		druckFaktorArray = @[@"1.0", @"1e6", @"1e5", @"100.0", @"98066.5", @"101325.0", @"133.0"];
	
		zeitStringArray = @[@"s",   @"min",  @"h",      @"d",       @"a"];
		zeitFaktorArray = @[@"1.0", @"60.0", @"3600.0", @"86400.0", @"3.1536e7"];
	
		leistungStringArray = @[@"W",   @"kW",     @"kpm/s",   @"PS",    @"kcal/h"];
		leistungFaktorArray = @[@"1.0", @"1000.0", @"9.80665", @"736.0", @"1.16"];
	
		dichteStringArray = @[@"kg/m³",   @"g/cm³"];
		dichteFaktorArray = @[@"1.0", @"1e3"];
	}
	return self;
}

- (double)convertValue: (double)value from: (NSInteger)initial to: (NSInteger)final withFaktorArray: (NSInteger)array {
	NSString *selectedArray = @"energieFaktorArray";
	switch (array) {
		case 0: 
			selectedArray = @"energieFaktorArray";
			break;
		case 1:
			selectedArray = @"laengeFaktorArray";
			break;
		case 2:
			selectedArray = @"druckFaktorArray";
			break;
		case 3:
			selectedArray = @"zeitFaktorArray";
			break;
		case 4:
			selectedArray = @"leistungFaktorArray";
			break;
		case 5:
			selectedArray = @"dichteFaktorArray";
			break;
		default:
			break;
	}
	value *= [[[self valueForKey: selectedArray] objectAtIndex: initial] doubleValue];
	value /= [[[self valueForKey: selectedArray] objectAtIndex: final] doubleValue];
	return value;
}

@end
