//  Created by dasdom on 10.07.19.
//  
//

#import "ConstantsTableViewController.h"
//#import "CalculatorConstant.h"
#import "Phy-Swift.h"
#import "ConstantCell.h"
#import "CalculatorViewController.h"

@interface ConstantsTableViewController ()
@property (nonatomic) NSArray *constants;
@end

@implementation ConstantsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.constants = [CalculatorConstant allConstants];
    
    [self.tableView registerClass:[ConstantCell class] forCellReuseIdentifier:[ConstantCell reuseIdentifier]];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.title = NSLocalizedString(@"Konstanten", nil);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.constants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConstantCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConstantCell reuseIdentifier] forIndexPath:indexPath];
    
    CalculatorConstant *constant = self.constants[indexPath.row];
    [cell updateWithItem:constant];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CalculatorConstant *constant = self.constants[indexPath.row];
    [self.delegate insertString:constant.value];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
