//  Created by dasdom on 17.07.19.
//  
//

#import "PhyCollectionTableViewController.h"
#import "DDHBaseTableViewCell.h"
#import "PhyFormulaSection.h"

@interface PhyCollectionTableViewController ()
@property (nonatomic) Class cellClass;
@end

@implementation PhyCollectionTableViewController

- (Class)cellClass {
    // This needs to be overriden.
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass identifier]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self hasSeveralSections]) {
        return [self.items count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self hasSeveralSections]) {
        PhyFormulaSection *phySection = self.items[section];
        return [phySection.formulas count];
    } else {
        return [self.items count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DDHBaseTableViewCell *cell = (DDHBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[self.cellClass identifier] forIndexPath:indexPath];
    
    id item = nil;
    if ([self hasSeveralSections]) {
        item = ((PhyFormulaSection *)self.items[indexPath.section]).formulas[indexPath.row];
    } else {
        item = self.items[indexPath.section];
    }
    
    [cell updateWithItem:item];
    
    return cell; 
}

#pragma mark - Helpers
- (BOOL)hasSeveralSections {
    return [self.items.firstObject isKindOfClass:[PhyFormulaSection class]];
}

@end
