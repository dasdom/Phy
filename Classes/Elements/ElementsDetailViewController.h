//
//  ElementsDetailViewController.h
//  PhysForm
//
//  Created by Dominik Hauser on 20.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ElementsDetailViewController : UIViewController
//@property (nonatomic, retain) UILabel *name;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *abk;
@property (nonatomic, strong) NSString *ordnungszahl;
@property (nonatomic, strong) NSString *atommasse;
@property (nonatomic, strong) NSString *periode;
@property (nonatomic, strong) NSString *gruppe;
@property (nonatomic, strong) NSString *elKonfiguration;
@property (nonatomic, strong) NSString *pauling;
@property (nonatomic, strong) NSDictionary *elementsDict;

@end
