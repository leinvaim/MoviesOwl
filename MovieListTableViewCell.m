//
//  MovieListTableViewCell.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 29/11/2014.
//  Copyright (c) 2014 leinvaim. All rights reserved.
//

#import "MovieListTableViewCell.h"

@implementation MovieListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
