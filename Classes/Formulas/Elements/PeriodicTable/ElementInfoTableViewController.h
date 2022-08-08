//  Created by Dominik Hauser on 20.07.22.
//  Copyright © 2022 dasdom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChemElement;

NS_ASSUME_NONNULL_BEGIN

@interface ElementInfoTableViewController : UITableViewController
@property (nonatomic, strong) ChemElement *element;
- (instancetype)initWithElement: (ChemElement *)element;
@end

NS_ASSUME_NONNULL_END
