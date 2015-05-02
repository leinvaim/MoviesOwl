//
//  MovieTableViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "MovieTableViewController.h"
#import "SessionTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "SeatViewController.h"
#import "ApiManager.h"

@interface MovieTableViewController ()
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableArray *seats;
@property (nonatomic, strong) NSString *dte;
@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =[self.movie objectForKey:@"title"];
    
    [self setupSeatsWithDummyData];
    [self setBackgroundImageAsMoviePoster];
    [self setupMovieDetails];
    [self setupRottenTomatoesRating];
    [self setupTableHeaderViewHeight];
}


- (void)setupSeatsWithDummyData {
    // Fill seats with empty arrays to be replaced with real data when its loaded
    self.seats = [NSMutableArray array];
    for (int i = 0; i < [[self getShowings] count]; i++) {
        [self.seats addObject:[NSArray array]];
    }
}

- (NSArray *)getShowings {
    return [[self.movie objectForKey:@"showings"] objectForKey:@"data"];
}

- (void)setupRottenTomatoesRating {
    //convert rating to int
    NSNumber *getRating = [self.movie objectForKey:@"tomato_meter"];
    int rating = [getRating intValue];
    
    self.moviePlayingRating.text = [NSString stringWithFormat:@"%@",getRating];
    //set background colour
    if (rating >= 70) {
        [self.moviePlayingRating setBackgroundColor:[UIColor colorWithRed:40/255.0f green:226/255.0f blue:72/255.0f alpha:0.7f]];
    }
    else if (rating >= 50) {
        [self.moviePlayingRating setBackgroundColor:[UIColor colorWithRed:251/255.0f green:255/255.0f blue:28/255.0f  alpha:0.7f]];
    }
    else {
        [self.moviePlayingRating setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:4/255.0f alpha:0.7f]];
    }
}

- (void)setupTableHeaderViewHeight {
    // http://stackoverflow.com/questions/26391979/systemlayoutsizefittingsize-returning-incorrect-height-for-tableheaderview-und
    // http://stackoverflow.com/questions/20982558/how-do-i-set-the-height-of-tableheaderview-uitableview-with-autolayout
    // get the fitting size
    CGSize s = [self.tableView.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    NSLog( @"fittingSize: %@", NSStringFromCGSize( s ));
    
    self.tableView.tableHeaderView.frame = CGRectMake(self.tableView.tableHeaderView.frame.origin.x, self.tableView.tableHeaderView.frame.origin.x, self.tableView.tableHeaderView.frame.size.width, s.height);
}

- (void)setupMovieDetails {
    // Movie attribute setting
    NSString *director = @"Directors name";
    director = [director stringByAppendingString:[self.movie objectForKey:@"director"]];
    
    self.moviePlayingTitle.text = [self.movie  objectForKey:@"title"];
    self.moviePlayingTitle.preferredMaxLayoutWidth = self.view.frame.size.width - 10 -50;
    
    self.moviePlayingRuntime.text = [NSString stringWithFormat:@"%@ minutes",[self.movie objectForKey:@"run_time"]];;
    
    self.moviePlayingSynopsis.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
    self.moviePlayingSynopsis.text = [self.movie objectForKey:@"synopsis"];

    
NSString *synopsis = [self.movie objectForKey:@"synopsis"];
    NSLog(@"view width %f", self.view.frame.size.width);
    self.moviePlayingDirector.text = director;
    self.moviePlayingDirector.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
    self.moviePlayingCasts.text = [self.movie objectForKey:@"cast"];
    self.moviePlayingCasts.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
    
//    self.moviePlayingSynopsis.numberOfLines = 0;
//    self.moviePlayingSynopsis.lineBreakMode = NSLineBreakByWordWrapping;
//    self.moviePlayingSynopsis.autoresizingMask = UIViewAutoresizingFlexibleHeight;
////
////
//    NSString *synopsis = [self.movie objectForKey:@"synopsis"];
//    UIFont *font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:21];
//    
//    CGSize constraint = CGSizeMake(300,NSUIntegerMax);
//    
//    NSDictionary *attributes = @{NSFontAttributeName: font};
//    
//    CGRect rect = [synopsis boundingRectWithSize:constraint
//                                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                    attributes:attributes
//                                       context:nil];
//    
//    NSLog(@" lalalalalla %f", rect.size.height);
//    NSLog(@"hihihihi %f", self.moviePlayingSynopsis.frame.size.height);
//  //  adjust the label the the new height.
//        CGRect newFrame = self.moviePlayingSynopsis.frame;
//        newFrame.size.height = rect.size.height;
//    NSLog(@" new frame %f", newFrame.size.height);
//
//        self.moviePlayingSynopsis.frame = newFrame;
//    NSLog(@" self %f", self.moviePlayingSynopsis.frame.size.height);
//        [self.moviePlayingSynopsis sizeToFit];

    
    // Construct your label
    
//    UILabel* label = [[UILabel alloc] initWithFrame:rect];
//    
//    [label setText:string];
//    
//    [label setTextAlignment:NSTextAlignmentRight];
//    
//    label.lineBreakMode = NSLineBreakByWordWrapping;
//    
//    label.numberOfLines = 0;
    
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
//    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
//    NSString *synopsis = [self.movie objectForKey:@"synopsis"];
//    
//    
//    CGRect textRect = [synopsis boundingRectWithSize:self.moviePlayingSynopsis.frame.size
//                                         options:NSStringDrawingUsesLineFragmentOrigin
//                                      attributes:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//                                         context:nil];
    
    //adjust the label the the new height.
//    CGRect newFrame = self.moviePlayingSynopsis.frame;
//    newFrame.size.height = textRect.size.height;
//    self.moviePlayingSynopsis.frame = newFrame;
//    [self.moviePlayingSynopsis sizeToFit];
    

}

- (void)setBackgroundImageAsMoviePoster {
    NSURL *url = [NSURL URLWithString:[self.movie objectForKey:@"poster"]];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       // NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            //http://stackoverflow.com/questions/19432773/creating-a-blur-effect-in-ios7
            
           // UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *background = [[UIImageView alloc] initWithImage:self.backgroundImage];
            UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = self.tableView.frame;
            [background addSubview:effectView];
            
            [self.tableView setBackgroundView:background];
            //self.tableView.backgroundColor = [UIColor colorWithPatternImage:image];
            //            self.tableView.backgroundColor = [UIColor whiteColor];
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger numberOfSessions = [[self getShowings] count];
    NSLog(@"numberof sessions %ld", numberOfSessions);
    return numberOfSessions;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Today's Sessions";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *showing = [[self getShowings] objectAtIndex:indexPath.row];
    
    NSLog(@"showing is %@", showing);
    NSNumber *startTime = [showing objectForKey:@"start_time"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]];
    NSLog(@"date test%ld %@", (long)startTime, date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"MMM dd, HH:mm"];
        [dateFormatter setDateFormat:@"h:mm a"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Brisbane"]];
     self.dte=[dateFormatter stringFromDate:date];
        NSLog(@"date %@", self.dte);
    cell.session.text = self.dte;
    cell.screenType.text = @"";
    [cell.screenType setTextColor:[UIColor whiteColor]];
    if ([[showing objectForKey:@"showing_type"]  isEqual: @"standard"]) {
        cell.showType.text = @"";
    }
    else {
        cell.showType.text =[showing objectForKey:@"showing_type"];
    }
    
    if ([[showing objectForKey:@"screen_type"]  isEqual: @"standard"]) {
        cell.screenType.text = @"";
    }
    else if ([[showing objectForKey:@"screen_type"]  isEqual: @"vmax"]) {
        cell.screenType.text = @"VMAX";
        UIColor * blue = [UIColor colorWithRed:0/255.0f green:94/255.0f blue:247/255.0f alpha:1.0f];
        [cell.screenType setTextColor:blue];

    }
    else {
        cell.screenType.text = @"Gold Class";
        UIColor * gold = [UIColor colorWithRed:188/255.0f green:188/255.0f blue:0/255.0f alpha:1.0f];
        [cell.screenType setTextColor:gold];
    }
    
    NSString *stringID = [showing objectForKey:@"id"];
    int showid = [stringID intValue];
    __block int counter = 0;
    __block int available = 0;
    __block int taken = 0;

 //   if (![[self.seats objectAtIndex:indexPath.row] count]) {
        [[ApiManager sharedManager] getShowing:(showid) success:^(NSArray *seats) {
            if([self.seats count] > indexPath.row) {
                [self.seats replaceObjectAtIndex:indexPath.row withObject:seats];
            } else {
                [self.seats insertObject:seats atIndex:indexPath.row];
            }
         
            for (int i = 0; i < [seats count]; i++) {
                for (int j = 0; j< [seats[i] count]; j++) {
                    if (![seats[i][j] isEqualToString:@"spacer"] ) {
                        counter++;
                    }
                    if ([seats[i][j] isEqualToString:@"available"]) {
                        available++;
                    }
                    if ([seats[i][j] isEqualToString:@"taken"]) {
                        taken++;
                    }
                }
            }
            if([cell.screenType.text isEqual: @""]) {
                NSLog(@"seat count!!! %i", counter);
                if(counter > 200) {
                    cell.screenType.text = @"Big";
                } else if (counter > 150) {
                    cell.screenType.text = @"Medium";
                } else {
                    cell.screenType.text = @"Small";
                }
                
            }
            int percentTaken =(int)((float)taken / (float)counter * 100.0);
            if(percentTaken > 80) {
                cell.seatCapacity.text = [NSString stringWithFormat:@"Full"] ;
            } else if(percentTaken > 30) {
                cell.seatCapacity.text = [NSString stringWithFormat:@"Almost full"] ;
            } else {
                cell.seatCapacity.text = [NSString stringWithFormat:@"%i%% Full", percentTaken] ;
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"It failed");
        }];
 //   }
    
    



     return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSeats"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSLog(@"selected row %li", (long)path.row);
        
        SeatViewController *seatView = [segue destinationViewController];
        
        NSDictionary *showing = [[self getShowings] objectAtIndex:path.row];
        // Pass any objects to the view controller here, like...
        seatView.session = showing;
        seatView.seatsData = [self.seats objectAtIndex:path.row];
        NSLog(@"seats data %@", seatView.seatsData);
        seatView.movie = self.movie;
        seatView.title = [self.movie objectForKey:@"title"];

        
        NSNumber *startTime = [showing objectForKey:@"start_time"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"h:mm a"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Brisbane"]];
        self.dte=[dateFormatter stringFromDate:date];
        seatView.showtime = self.dte;
    
        UIImageView *background = [[UIImageView alloc] initWithImage:self.backgroundImage];
        background.frame = self.view.frame;
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.view.frame;
        [background addSubview:effectView];
        [seatView.view addSubview:background ];
        [seatView.view sendSubviewToBack:background];
        
        

        
        
        
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
