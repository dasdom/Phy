//
//  DetailFormula.h
//  PhysForm
//
//  Created by Dominik Hauser on 06.03.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DetailFormula : NSObject {
	NSInteger formulaID;
	NSString *formulaName;
	NSString *imageName;
	
	BOOL hasChangedInMemory;
	BOOL isFromSelection;
}

@property (nonatomic, readonly) NSInteger formulaID;
@property (nonatomic, copy) NSString *formulaName;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, readwrite) BOOL hasChangedInMemory;
@property (nonatomic, readwrite) BOOL isFromSelection;

+ (void)getInitialDataToDisplay: (NSString *)dbPath;
+ (void)finalizeStatements;

- (id)initWithPrimaryKey: (NSInteger)pk;
- (void)deleteFormula;
- (void)addDetailFormula;

@end
