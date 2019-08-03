//  Created by dasdom on 10.07.19.
//  
//

#import <UIKit/UIKit.h>

@interface ConstantCell : UITableViewCell
+ (NSString *)reuseIdentifier;
- (void)updateWithItem:(id)item;
@end
