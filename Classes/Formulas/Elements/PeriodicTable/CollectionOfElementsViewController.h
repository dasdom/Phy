//
//  CollectionOfElementsViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChemElement;

@interface CollectionOfElementsViewController : UIViewController

- (instancetype)initWithElements: (NSArray<ChemElement *> *)elements;
@property (nonatomic, strong) NSArray<ChemElement *> *elementArray;

@end
