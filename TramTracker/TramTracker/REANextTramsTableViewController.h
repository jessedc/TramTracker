//
//  REANextTramsTableViewController.h
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class REANextTramsProvider;

@interface REANextTramsTableViewController : UITableViewController

@property (nonatomic, strong) REANextTramsProvider *nextTramsProvider;

@end
