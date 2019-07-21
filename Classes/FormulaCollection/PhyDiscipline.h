//  Created by dasdom on 17.07.19.
//  
//

#import <Foundation/Foundation.h>
#import "PhyFormulaSection.h"

@interface PhyDiscipline : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSArray<PhyFormulaSection *> *sections;
@end
