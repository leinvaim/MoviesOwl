//
//  MovieListTableViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 29/11/2014.
//  Copyright (c) 2014 leinvaim. All rights reserved.
//

#import "MovieListTableViewController.h"
#import "MovieListTableViewCell.h"
#import "HeaderTableViewCell.h"
#import "ApiManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "MovieViewController.h"
#import "SessionsTableViewController.h"
#import "MovieTableViewController.h"
@interface MovieListTableViewController ()
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MovieListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.cinema objectForKey:@"location"];

    NSString *stringID = [self.cinema objectForKey:@"id" ];
    int cinemaID = [stringID intValue];
      NSLog(@"Debug: Getting posts");
    [[ApiManager sharedManager] getMoviesInCinema:(cinemaID) success:^(NSArray *movies) {
        self.movies = movies;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"It failed");
    }];

    
//    [[ApiManager sharedManager] getMovies:^(NSArray *movies) {
//        self.movies = movies;
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"It failed");
//    }];

    
    
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *movies = [self.movies objectAtIndex:indexPath.row];
    MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movie" forIndexPath:indexPath];
   
    
     //Configure the cell...
    
    //[cell.poster setImage:[UIImage imageNamed:@"poster.jpg"] ];
    NSURL *url = [NSURL URLWithString:[movies objectForKey:@"poster"]];
    [cell.poster setImageWithURL:url];

    UIImageView *backgroundPoster = [[UIImageView alloc] initWithFrame:cell.frame];
    [backgroundPoster setImageWithURL:url];
    cell.backgroundView = backgroundPoster;
    cell.backgroundView.alpha = 0.1;
    

    
    [cell.title setText:[movies objectForKey:@"title"]];

    //convert rating to int
    NSNumber *getRating = [movies objectForKey:@"tomato_meter"];
    int rating = [getRating intValue];
    
    // fill rating
    if (rating <= 0) {
        [cell.rating setText:@"Rating is not available"];
    }
    else {
        [cell.rating setText:[NSString stringWithFormat:@"Rating : %@",getRating]];
    }
    
     //set background colour
    if (rating >= 70) {
        [cell setBackgroundColor:[UIColor colorWithRed:0 green:0.88 blue:0 alpha:0.3]];
    }
    else if (rating >= 40) {
       [cell setBackgroundColor:[UIColor colorWithRed:0.8 green:0.7 blue:0.5 alpha:0.3]];
    }
    else {
       [cell setBackgroundColor:[UIColor colorWithRed:0.88 green:0.2 blue:0.4 alpha:0.3]];
    }
    

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 67.0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"header";
    HeaderTableViewCell *headerView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (headerView == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    [headerView.icon setImage:[UIImage imageNamed:@"owlicon.png"] ];
   
    return headerView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMovie"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSLog(@"selected row %li", (long)path.row);
        
        MovieTableViewController *movieView = [segue destinationViewController];
        movieView.movie = [self.movies objectAtIndex:path.row];
//         SessionsTableViewController *sessionView = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //moviesView.cinema = [self.cinemas objectAtIndex:path.row];

    }
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//
//{
//   // return @"My Title";
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//   // NSString *string =[list objectAtIndex:section];
//    /* Section header is in 0th index... */
//   // [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}


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
