//
//  MovieListTableViewCell.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 29/11/2014.
//  Copyright (c) 2014 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rating;

@end
