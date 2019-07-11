//
//  DetailFormula.m
//  PhysForm
//
//  Created by Dominik Hauser on 06.03.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DetailFormula.h"
#import "PhysFormAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;

@implementation DetailFormula

@synthesize formulaID, formulaName, imageName;
@synthesize hasChangedInMemory, isFromSelection;

+ (void)getInitialDataToDisplay: (NSString *)dbPath {
	PhysFormAppDelegate *appDelegate = (PhysFormAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select id, name, imageName from formula";
		sqlite3_stmt *selectstmt;
		if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			while (sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				DetailFormula *detailFormula = [[DetailFormula alloc] initWithPrimaryKey: primaryKey];
				detailFormula.formulaName = @((char *)sqlite3_column_text(selectstmt, 1));
				detailFormula.imageName = @((char *)sqlite3_column_text(selectstmt, 2));
				detailFormula.hasChangedInMemory = NO;
				[appDelegate.formulaArray addObject: detailFormula];
			}
		}
	} else {
		sqlite3_close(database);
	}
}

+ (void)finalizeStatements {
	if (database)
		sqlite3_close(database);
	if (deleteStmt)
		sqlite3_finalize(deleteStmt);
	if (addStmt)
		sqlite3_finalize(addStmt);
}

- (id)initWithPrimaryKey: (NSInteger)pk {
	if (self = [super init]) {
		formulaID = pk;
		isFromSelection = NO;
	}
	return self;
}

- (void)deleteFormula {
	if (deleteStmt == nil) {
		const char *sql = "delete from formula where id = ?";
		if (sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_int(deleteStmt, 1, (int)formulaID);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	sqlite3_reset(deleteStmt);
}

- (void)addDetailFormula {
	if (addStmt == nil) {
		const char *sql = "insert into formula (name, imageName) values (?, ?)";
		if (sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}
	}
	sqlite3_bind_text(addStmt, 1, [formulaName UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [imageName UTF8String], -1, SQLITE_TRANSIENT);
	
	if (SQLITE_DONE != sqlite3_step(addStmt)) {
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	} else {
		formulaID = sqlite3_last_insert_rowid(database);
	}
	sqlite3_reset(addStmt);
}


@end
