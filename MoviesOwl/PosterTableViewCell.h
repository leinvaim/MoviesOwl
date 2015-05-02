//
//  PosterTableViewCell.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 18/02/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PosterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *widePoster;
@property (weak, nonatomic) IBOutlet UILabel *selectedMovieTitle;

@end
