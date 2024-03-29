//
//  SessionTableViewCell.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *session;
@property (weak, nonatomic) IBOutlet UILabel *showType;
@property (weak, nonatomic) IBOutlet UILabel *screenType;

@property (weak, nonatomic) IBOutlet UILabel *seatCapacity;

@end
