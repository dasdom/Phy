//
//  CollectionOfElementsView.h
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxMass 300.0f
#define kMaxPauling 6.0f

@interface CollectionOfElementsView : UIView

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, strong) UILabel *abkLabel;
@property (nonatomic, strong) UILabel *ordinalLabel;
@property (nonatomic, strong) UIView *labelView;

- (id)initWithFrame: (CGRect)frame andElementsArray: (NSArray*)pElementsArray;

@end
