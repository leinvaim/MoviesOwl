//
//  MoviePlayingViewController.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 6/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayingViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *movie;

@end
