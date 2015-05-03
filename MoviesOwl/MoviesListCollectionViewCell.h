//
//  MoviesListCollectionViewCell.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 5/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
