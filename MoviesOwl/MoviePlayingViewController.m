//
//  MoviePlayingViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 6/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "MoviePlayingViewController.h"
#import "SessionTableViewCell.h"

@interface MoviePlayingViewController ()
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation MoviePlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
// This will tell your UITableView how many rows you wish to have in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sessionCell" forIndexPath:indexPath];
    
    NSDictionary *showing = [[[self.movie objectForKey:@"showings"] objectForKey:@"data"] objectAtIndex:indexPath.row];
    
    NSLog(@"showing is %@", showing);
    NSNumber *startTime = [showing objectForKey:@"start_time"];
    //    NSInteger startTime =
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]];
    NSLog(@"date %ld %@", (long)startTime, date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy-h:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Brisbane"]];
    
    //NSDate *date = [dateFormatter dateFromString:publicationDate];
    NSString *dte=[dateFormatter stringFromDate:date];
    NSLog(@"date %@", dte);
    cell.session.text = [NSString stringWithFormat:@"start time %@", dte];
    // Configure the cell...
    return cell;

    
    return cell;
}


@end
