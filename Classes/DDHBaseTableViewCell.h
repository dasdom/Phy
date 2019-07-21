//  Created by dasdom on 17.07.19.
//  
//

#import <UIKit/UIKit.h>

@interface DDHBaseTableViewCell : UITableViewCell
+ (NSString *)identifier;
- (void)updateWithItem:(id)item;
@end
