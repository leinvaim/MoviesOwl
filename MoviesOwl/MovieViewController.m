//
//  MovieViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 4/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "MovieViewController.h"
#import "SessionTableTableViewCell.h"

@interface MovieViewController ()
@property (nonatomic, strong) NSArray *time;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"hey");
    self.title = [self.movieData objectForKey:@"title"];
    self.sessions = [[self.movieData objectForKey:@"showings"] objectForKey:@"data"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[[self.movieData objectForKey:@"showings"] objectForKey:@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   NSDictionary *time = [self.sessions objectAtIndex:indexPath.row] ;
    SessionTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"session" forIndexPath:indexPath];
    
    //configure the cell
    [cell.sessionTime setText:[time objectForKey:@"start_time"]];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
