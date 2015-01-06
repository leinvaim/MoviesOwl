//
//  SessionsTableViewController.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *sessionTIme;
@property (weak, nonatomic) IBOutlet UILabel *sessionType;
@property (strong, nonatomic) NSDictionary *cinema;
@end
