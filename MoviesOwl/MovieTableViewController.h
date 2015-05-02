//
//  MovieTableViewController.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *moviePlayingTitle;
@property (weak, nonatomic) IBOutlet UILabel *moviePlayingRuntime;
@property (weak, nonatomic) IBOutlet UILabel *moviePlayingSynopsis;
@property (weak, nonatomic) IBOutlet UILabel *moviePlayingDirector;
@property (weak, nonatomic) IBOutlet UILabel *moviePlayingCasts;

@property (weak, nonatomic) IBOutlet UILabel *moviePlayingRating;

@property (nonatomic, strong) NSDictionary *movie;
@property (nonatomic, strong) UIImage *backgroundImage;
@end
