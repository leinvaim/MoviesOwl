//
//  TimePickerTableViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 3/05/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "TimePickerTableViewController.h"
#import "TimePickerTableViewCell.h"

@interface TimePickerTableViewController ()
@end

@implementation TimePickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //Get current time
    NSDate* now = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitHour  | NSCalendarUnitMinute) fromDate:now];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    int max = 21;
    if (minute > 30) {
        return (max - hour)*2 -1;
    }
    return (max - hour)*2;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimePickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timePickerCell" forIndexPath:indexPath];
    NSArray *timeSlots = [[self class] timeSlots];
    cell.timePicker.text = timeSlots[indexPath.row];
    
    return cell;
}

+ (NSArray *)timeSlots
{
    static NSArray *_timeSlots;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timeSlots = @[@"10:00",
                       @"10:30",
                       @"11:00",
                       @"11:30",
                       @"12:00",
                       @"12:30",
                       @"13:00",
                       @"13:30",
                       @"14:00",
                       @"14:30",
                       @"15:00",
                       @"15:30",
                       @"16:00",
                       @"16:30",
                       @"17:00",
                       @"17:30",
                       @"18:00",
                       @"18:30",
                       @"19:00",
                       @"19:30",
                       @"20:00",
                       @"20:30",
                       @"21:00",
                       ];
    });
    return _timeSlots;
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
