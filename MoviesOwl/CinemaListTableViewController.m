//
//  CinemaListTableViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "CinemaListTableViewController.h"
#import "CinemaListTableViewCell.h"
#import "ApiManager.h"
#import "MoviesListCollectionViewController.h"

@interface CinemaListTableViewController ()
@property (nonatomic, strong) NSArray *cinemas;

@end

@implementation CinemaListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Debug: Getting cinemas");
    [[ApiManager sharedManager] getCinemas:^(NSArray *cinemas) {
        self.cinemas = cinemas;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Getting cinemas failed");
    }];
    
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
    return [self.cinemas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSDictionary *cinemas = [self.cinemas objectAtIndex:indexPath.row];
        CinemaListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cinema" forIndexPath:indexPath];
    
    //configure the cell
    [cell.cinema setText:[cinemas objectForKey:@"location"]];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        NSLog(@"selected");
//        NSDictionary *cinemas = [self.cinemas objectAtIndex:indexPath.row];
//        [self performSegueWithIdentifier:@"showMovies" sender: [cinemas objectForKey:@"id"]];
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMovies"]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSLog(@"selected row %li", (long)path.row);
        
        MoviesListCollectionViewController *moviesView = [segue destinationViewController];

        // Pass any objects to the view controller here, like...
        moviesView.cinema = [self.cinemas objectAtIndex:path.row];
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
