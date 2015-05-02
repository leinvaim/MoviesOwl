//
//  SelectedMovieTableViewController.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 18/02/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedMovieTableViewController : UITableViewController
@property (nonatomic, strong) NSDictionary *movie;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) UIImageView *widePosterForSynopsis;
@property (strong, nonatomic) NSDictionary *cinema;
@property int indexPathRow;
@end
