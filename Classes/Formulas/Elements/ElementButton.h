//  Created by Dominik Hauser on 22.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ElementButton : UIButton
- (void)updateWithAbbr: (NSString *)abbr andOrdinal: (NSInteger)ordinal;
@end

NS_ASSUME_NONNULL_END
