//
//  SeatViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 9/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "SeatViewController.h"
#import "Seat.h"
#import "SVWebViewController.h"
#import "ApiManager.h"
@interface SeatViewController ()
@property (nonatomic, strong) NSArray *seats;
@end

@implementation SeatViewController

- (void)loadSeatData {
    if([self.seatsData count] > 0) {
        self.seats = self.seatsData;
        [self loadSeats];
        return;
    }
    
    NSString *stringID = [self.session objectForKey:@"id" ];
    int showId = [stringID intValue];
    NSLog(@"getting show id %d", showId);
    [[ApiManager sharedManager] getShowing:(showId) success:^(NSArray *seats) {
        self.seats = seats;
        NSLog(@"num of seats %@", self.seats);
        //[self.view setNeedsDisplay];
        [self loadSeats];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Getting seats failed");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.sessionTime.text = [NSString stringWithFormat:@" Today's Show at %@", self.showtime];
    [self loadSeatData];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadSeats {
    
    int padding = 10;
    CGSize seatSize = CGSizeMake(self.view.frame.size.width - padding, self.view.frame.size.height);
    int seatLength = (int)[self.seats.firstObject count];
    CGFloat width = (seatSize.width - seatLength -1 ) / seatLength;
    CGFloat height = width;
    CGFloat xPosition = self.view.frame.origin.x + padding/2;
    //navbar height becomes 0 after adding background, so add 44px (navbar height)
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    NSLog(@"navbar height %f", navBarHeight);
    if (navBarHeight == 0) {
        navBarHeight = 44;
        NSLog(@"navbar after height %f", navBarHeight);
    }
    CGFloat yPosition = navBarHeight + height + 1;
    NSLog(@"origin %f", self.navigationController.navigationBar.frame.size.height);
    
    NSLog(@"frame width %f", width);
    NSLog(@"frame height %f", height);
    NSLog(@"x pos %f", xPosition);
    NSLog(@"y pos%f", yPosition);

    UIView *screen = [[UIView alloc] initWithFrame:CGRectMake(xPosition + width, yPosition, self.view.frame.size.width - width - width - padding -1, 30)];
    UILabel *screenLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.frame.size.width/2 - 50, 0, 100, 30)];
    [screenLabel setText:@"SCREEN"];
    [screenLabel setTextAlignment:NSTextAlignmentCenter];
    [screenLabel setTextColor:[UIColor whiteColor]];
    [screenLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size: 15]];
    [screen setBackgroundColor:[UIColor blackColor]];
    [screen addSubview:screenLabel];
    [self.view addSubview:screen];
    
    yPosition = yPosition + screen.frame.size.height + 15;
    for (int i = 0; i< [self.seats count]; i++) {
        for (int j = 0; j<[self.seats[i] count]; j++) {
            UIView *seat = [[UIView alloc] initWithFrame:CGRectMake(xPosition, yPosition, width, height)];

            if ([self.seats[i][j] isEqualToString:@"available"]){
                [seat setBackgroundColor:[UIColor colorWithRed:8/255.0f green:68/255.0f blue:255/255.0f alpha:1.0f]];
                [self.view addSubview:seat];
            }
            else if ([self.seats[i][j] isEqualToString:@"taken"]){
                [seat setBackgroundColor:[UIColor redColor]];
                [self.view addSubview:seat];
            }
            
            
            xPosition = xPosition + width +1;
        }
        xPosition = self.view.frame.origin.x + padding / 2;
        yPosition = yPosition + height +1;
    }
    

}

- (void)presentWebViewController {
    NSURL *URL = [NSURL URLWithString:[self.session objectForKey:@"tickets_url"]];
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}


//- (void)setBackgroundImageAsMoviePoster {
//  //  NSURL *url = [NSURL URLWithString:[self.movie objectForKey:@"poster"]];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        // NSData *imageData = [NSData dataWithContentsOfURL:url];
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // Update the UI
//            //http://stackoverflow.com/questions/19432773/creating-a-blur-effect-in-ios7
//            
//            // UIImage *image = [UIImage imageWithData:imageData];
//            UIImageView *background = [[UIImageView alloc] initWithImage:self.backgroundImage];
//            UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//            effectView.frame = self.view.frame;
//            [background addSubview:effectView];
//            
//            [self.view addSubview:background];
//        });
//    });
//}
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showBooking"]) {
//        NSURL *url = [NSURL URLWithString:[self.session objectForKey:@"tickets_url"]];
//        BookingViewController *bookingView = [segue destinationViewController];
//        bookingView.bookingURL = url;
//
//    }
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
