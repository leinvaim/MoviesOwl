//
//  SelectedMovieTableViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 18/02/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "SelectedMovieTableViewController.h"
#import "PosterTableViewCell.h"
#import "RatingTableViewCell.h"
#import "MovieSessionTableViewCell.h"
#import "RuntimeTableViewCell.h"
#import "SynopsisTableViewCell.h"
#import "CastTableViewCell.h"
#import "DirectorTableViewCell.h"
#import "CriticsTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieTableViewController.h"
#import "SynopsisViewController.h"
#import "ApiManager.h"

@interface SelectedMovieTableViewController ()

@property (nonatomic, strong) NSArray *SectionTitles;
@end

@implementation SelectedMovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImageAsMoviePoster];
    self.title =[self.movie objectForKey:@"title"];
    self.SectionTitles = @[@"", @"Ratings", @"Sessions", @"Runtime", @"Synopsis", @"Director", @"Casts", @"Review"];
    
    //adding pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshInvoked:forState:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
   
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 1 ;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.SectionTitles objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    //Configure the cell..
    if(indexPath.section == 0) {
        NSLog(@"Section 0 created");
        // Poster and Title cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"posterCell" forIndexPath:indexPath];
        PosterTableViewCell* posterCell = (PosterTableViewCell *)cell;
        NSURL *url = [NSURL URLWithString:[self.movie objectForKey:@"poster"]];
        [posterCell.widePoster setImageWithURL:url];
        posterCell.selectedMovieTitle.text = [self.movie objectForKey:@"title"];
        self.widePosterForSynopsis = posterCell.widePoster;
        
        
    }
    else if (indexPath.section == 1) {
        NSLog(@"Section 1 created");
        cell = [tableView dequeueReusableCellWithIdentifier:@"ratingCell" forIndexPath:indexPath];
        RatingTableViewCell* ratingCell = (RatingTableViewCell *)cell;
        [self setupRottenTomatoesRating:ratingCell];
    }
    else if (indexPath.section == 2) {
        NSLog(@"Section 2 created");
        cell = [tableView dequeueReusableCellWithIdentifier:@"movieSessionCell" forIndexPath:indexPath];
        MovieSessionTableViewCell* sessionCell = (MovieSessionTableViewCell *)cell;
        NSInteger numOfSessions = [[[self.movie objectForKey:@"showings"] objectForKey:@"data"] count];
        sessionCell.numOfSessions.text = [NSString stringWithFormat:@"%li Sessions Available", (long)numOfSessions];
    }
    else if (indexPath.section == 3) {
        NSLog(@"Section 3 created");
        cell = [tableView dequeueReusableCellWithIdentifier:@"runtimeCell" forIndexPath:indexPath];
        RuntimeTableViewCell* runtimeCell = (RuntimeTableViewCell *)cell;
        runtimeCell.selectedRunTime.text = [NSString stringWithFormat:@" Run Time : %@ minutes",[self.movie objectForKey:@"run_time"]];
        
    }
    else if (indexPath.section == 4) {
        NSLog(@"Section 4 created");
        cell = [tableView dequeueReusableCellWithIdentifier:@"synopsisCell" forIndexPath:indexPath];
        SynopsisTableViewCell* synopsisCell = (SynopsisTableViewCell *)cell;
        synopsisCell.selectedSynopsis.text = [self.movie objectForKey:@"synopsis"];
        //synopsisCell.selectedSynopsis.preferredMaxLayoutWidth = self.view.frame.size.width - 20;
    }
    else if (indexPath.section == 5) {
        NSLog(@"Section 5 created");
        cell = [tableView dequeueReusableCellWithIdentifier:@"directorCell" forIndexPath:indexPath];
        DirectorTableViewCell* directorCell = (DirectorTableViewCell *)cell;
        directorCell.directors.text = [self.movie objectForKey:@"director"];
        
    }
    else if (indexPath.section == 6) {
        NSLog(@"Section 6 created");
        cell = [tableView dequeueReusableCellWithIdentifier:@"castCell" forIndexPath:indexPath];
        CastTableViewCell* castCell= (CastTableViewCell *)cell;
        castCell.selectedCast.text = [self.movie objectForKey:@"cast"];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)setupRottenTomatoesRating:(RatingTableViewCell*)cell {
    //convert rating to int
    NSNumber *getRating = [self.movie objectForKey:@"tomato_meter"];
    int rating = [getRating intValue];
    
    cell.selectedRottenRating.text = [NSString stringWithFormat:@"%@",getRating];
    //set background colour
    if (rating >= 70) {
        [cell.selectedRottenRating setBackgroundColor:[UIColor colorWithRed:40/255.0f green:226/255.0f blue:72/255.0f alpha:0.7f]];
    }
    else if (rating >= 50) {
        [cell.selectedRottenRating setBackgroundColor:[UIColor colorWithRed:251/255.0f green:255/255.0f blue:28/255.0f  alpha:0.7f]];
    }
    else {
        [cell.selectedRottenRating setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:4/255.0f alpha:0.7f]];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSessionsAvailable"]) {
       // NSArray *arr = [self.tableView indexPathsForSelectedRows];
       // NSIndexPath *path = [arr firstObject];
       // NSLog(@"selected row %li", (long)path.row);
        
         MovieTableViewController *movieView = [segue destinationViewController];
        movieView.movie = self.movie;
        movieView.backgroundImage = self.image;
        
    }
    
    if ([segue.identifier isEqualToString:@"showSynopsis"]) {
        SynopsisViewController *synopsisView = [segue destinationViewController];
        synopsisView.movieSynopsisObj = self.movie;
        //[synopsisView.synopsisPoster setImage:self.image];
        
        UIImageView *background = [[UIImageView alloc] initWithImage:self.image];
        background.frame = synopsisView.view.frame;
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        NSLog(@"size %f", synopsisView.view.frame.size.height);
        effectView.frame = synopsisView.view.frame;
        [background addSubview:effectView];
        [synopsisView.view addSubview:background ];
        
    }
    
}

- (void)setBackgroundImageAsMoviePoster {
    NSURL *url = [NSURL URLWithString:[self.movie objectForKey:@"poster"]];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       // NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            //http://stackoverflow.com/questions/19432773/creating-a-blur-effect-in-ios7
            
           
            self.image = self.widePosterForSynopsis.image;
            //self.image = [UIImage imageWithData:imageData];
            UIImageView *background = [[UIImageView alloc] initWithImage:self.image];
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



-(void) refreshInvoked:(id)sender forState:(UIControlState)state {
    // Refresh table here...
    // display invisible refresh because its hidden behind background
    //http://stackoverflow.com/questions/18903076/uirefreshcontrol-and-uitableviews-backgroundview

    if (self.refreshControl.refreshing) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /* (... refresh code ...) */
        self.tableView.backgroundView.layer.zPosition -= 1;
        NSLog(@"Refresh");
        NSString *stringID = [self.cinema objectForKey:@"id" ];
        int cinemaID = [stringID intValue];
        [[ApiManager sharedManager] getMoviesInCinema:(cinemaID) success:^(NSArray *movies) {
            self.movie = [movies objectAtIndex:self.indexPathRow];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Refresh Failed");
        }];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;


        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    });
    }

    //[self.refreshControl endRefreshing];
    
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
