//  Created by dasdom on 17.07.19.
//  
//

#import <Foundation/Foundation.h>
#import "PhyDiscipline.h"
#import "PhyFormulaSection.h"

@interface PhyMainSection : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSArray<PhyDiscipline *> *disciplines;
@property (nonatomic) NSArray<PhyFormulaSection *> *sections;
@end
