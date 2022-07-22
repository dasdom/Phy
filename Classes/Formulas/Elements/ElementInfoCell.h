//  Created by Dominik Hauser on 21.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ElementInfoCell : UITableViewCell
+ (NSString *)identifier;
- (void)updateWithText: (NSString *)text;
@end

NS_ASSUME_NONNULL_END
