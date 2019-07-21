//  Created by dasdom on 17.07.19.
//  
//

#import "DDHBaseTableViewCell.h"

@implementation DDHBaseTableViewCell

+ (NSString *)identifier {
    return NSStringFromClass(self);
}

- (void)updateWithItem:(id)item {
    NSAssert(false, @"Subclasses need to implement this.");
}

@end
