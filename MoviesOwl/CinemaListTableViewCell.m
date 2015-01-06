//
//  CinemListTableViewCell.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "CinemaListTableViewCell.h"
#import <pop/POP.h>


@implementation CinemaListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    [super setHighlighted:highlighted animated:animated];
//    if (self.highlighted) {
//        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//        scaleAnimation.duration = 0.1;
//        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//        [self.cinema pop_addAnimation:scaleAnimation forKey:@"scalingUp"];
//        
//        
//        
//    } else {
//        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//        sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
//        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
//        sprintAnimation.springBounciness = 20.f;
//        [self.cinema pop_addAnimation:sprintAnimation forKey:@"springAnimation"];
//    }
//}


@end
