//
//  ConverterModel.h
//  PhysForm
//
//  Created by Dominik Hauser on 21.02.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConverterModel : NSObject {
	NSArray *pickerArray0;
	NSArray *energieStringArray;
	NSArray *energieFaktorArray;
	
	NSArray *laengeStringArray;
	NSArray *laengeFaktorArray;
	
	NSArray *druckStringArray;
	NSArray *druckFaktorArray;
	
	NSArray *zeitStringArray;
	NSArray *zeitFaktorArray;
	
	NSArray *leistungStringArray;
	NSArray *leistungFaktorArray;
	
	NSArray *dichteStringArray;
	NSArray *dichteFaktorArray;
	
}

@property (nonatomic, strong) NSArray *pickerArray0;
@property (nonatomic, strong) NSArray *energieStringArray;
@property (nonatomic, strong) NSArray *energieFaktorArray;

@property (nonatomic, strong) NSArray *laengeStringArray;
@property (nonatomic, strong) NSArray *laengeFaktorArray;

@property (nonatomic, strong) NSArray *druckStringArray;
@property (nonatomic, strong) NSArray *druckFaktorArray;

@property (nonatomic, strong) NSArray *zeitStringArray;
@property (nonatomic, strong) NSArray *zeitFaktorArray;

@property (nonatomic, strong) NSArray *leistungStringArray;
@property (nonatomic, strong) NSArray *leistungFaktorArray;

@property (nonatomic, strong) NSArray *dichteStringArray;
@property (nonatomic, strong) NSArray *dichteFaktorArray;

- (double)convertValue: (double)value from: (NSInteger)initial to: (NSInteger)final withFaktorArray: (NSInteger)array;

@end
