//  Created by dasdom on 17.07.19.
//  
//

#import <Foundation/Foundation.h>
#import "PhyFormula.h"

@interface PhyFormulaSection : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSArray<PhyFormula *> *formulas;
@end

