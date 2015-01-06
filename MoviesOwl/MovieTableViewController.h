//
//  MovieTableViewController.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIView *movieHeader;
@property (nonatomic, strong) NSDictionary *movie;
@end
