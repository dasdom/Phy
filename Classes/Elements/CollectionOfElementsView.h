//
//  CollectionOfElementsView.h
//  PhysForm
//
//  Created by Dominik Hauser on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaxMass 500.0f
#define kMaxPauling 6.0f

@interface CollectionOfElementsView : UIView

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *massLabel;
@property (nonatomic, strong) UILabel *elConfigLabel;
@property (nonatomic, strong) UILabel *periodeLabel;
@property (nonatomic, strong) UILabel *gruppeLabel;
@property (nonatomic, strong) UILabel *paulingLabel;
@property (nonatomic, strong) UILabel *abkLabel;

- (id)initWithFrame: (CGRect)frame andElementsArray: (NSArray*)pElementsArray;

@end
