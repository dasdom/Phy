//  Created by dasdom on 10.07.19.
//  
//

#import "ConstantsTableViewController.h"
#import "CalculatorConstant.h"
#import "ConstantCell.h"
#import "GeneralCalculatorViewController.h"

@interface ConstantsTableViewController ()
@property (nonatomic) NSArray *constants;
@end

@implementation ConstantsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.constants =
    @[
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Gravitationsbeschleunigung", @"") value:@"9.80665" unit:@"m s⁻²"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Normdruck", @"") value:@"101325"unit:@"Pa"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Gravitationskonstante", @"") value:@"6.673e-11" unit:@"m³ kg⁻¹ s⁻²"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"absoluter Nullpunkt", @"") value:@"-273.15" unit:@"C"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Molvolumen eines idealen Gases", @"") value:@"22.413996" unit:@"dm³ mol⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"allgemeine Gaskonstante", @"") value:@"8.314472" unit:@"J K⁻¹ mol⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Avogadrosche Konstante", @"") value:@"6.02214199e23" unit:@"mol⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Boltzmannkonstante", @"") value:@"1.3806503e-23" unit:@"J K⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"elektrische Feldkonstante", @"") value:@"8.85418782e-12" unit:@"A s V⁻¹ m⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"magnetische Feldkonstante", @"") value:@"pi*4e-7" unit:@"V s A⁻¹ m⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Vakuumlichtgeschwindigkeit", @"") value:@"2.99792458e8" unit:@"m s⁻¹"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Boltzmannkonstante", @"") value:@"5.670400e-8" unit:@"W m⁻² K⁻⁴"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Plancksches Wirkungsquantum", @"") value:@"6.62606876e-34" unit:@"J s"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Elementarladung", @"") value:@"1.602176462e-19" unit:@"C"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Ruhemasse des Elektrons", @"") value:@"9.10938199e-31" unit:@"kg"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Ruhemasse des Protons", @"") value:@"1.67262158e-27" unit:@"kg"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Ruhemasse des Neutrons", @"") value:@"1.67492716e-27" unit:@"kg"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Comptonwellenlänge", @"") value:@"2.426310215e-12" unit:@"m"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"reduziertes Plancksches Wirkungsquantum", @"") value:@"1.054571596e-34" unit:@"Js"],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Sommerfeldsche Feinstrukturkonstante", @"") value:@"7.297352533e-3" unit:@""],
        [[CalculatorConstant alloc] initWithName:NSLocalizedString(@"Rydberg-Konstante", @"") value:@"1.0973731568549e7" unit:@"m⁻¹"]
    ];
    
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
