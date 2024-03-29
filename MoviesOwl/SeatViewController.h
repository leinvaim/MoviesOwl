//
//  SeatViewController.h
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 9/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UILabel *sessionTime;
@property (nonatomic, strong) NSString *showtime;
@property (nonatomic, strong) NSArray *seatsData;
@property (nonatomic, strong) NSDictionary *session;
@property (nonatomic, strong) NSDictionary *movie;
@property (nonatomic, strong) UIImage *backgroundImage;
- (IBAction)presentWebViewController;
@end
