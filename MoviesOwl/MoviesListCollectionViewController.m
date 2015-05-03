//
//  MoviesListCollectionViewController.m
//  MoviesOwl
//
//  Created by Kelvin Tamzil on 5/01/2015.
//  Copyright (c) 2015 leinvaim. All rights reserved.
//

#import "MoviesListCollectionViewController.h"
#import "MoviesListCollectionViewCell.h"
#import "HeaderTableViewCell.h"
#import "ApiManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "MovieViewController.h"
#import "SessionsTableViewController.h"
#import "MovieTableViewController.h"
#import "HeaderCollectionReusableView.h"
#import "NoMoviesCollectionViewCell.h"
#import "SelectedMovieTableViewController.h"
#import "MBProgressHUD.h"
#import "MoviesHeaderCollectionReusableView.h"
@import UIKit;

@interface MoviesListCollectionViewController ()
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MoviesListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     defaultCinemaId = NSUserDefaults getValue@"defaultCinemaId"
     if(!defaultCinemaId) {
        performSegue:@"showCinemas";
        return;
     }
     */

    self.title = [self.cinema objectForKey:@"location"];
    
    NSString *stringID = [self.cinema objectForKey:@"id" ];
    int cinemaID = [stringID intValue];
    NSLog(@"Debug: Getting posts");

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        [[ApiManager sharedManager] getMoviesInCinema:(cinemaID) success:^(NSArray *movies) {
            self.movies = movies;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            [self.collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"It failed");
        }];
    });
    


    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[NoMoviesCollectionViewCell class] forCellWithReuseIdentifier:@"test"];
//        [self.collectionView registerClass:[MoviesListCollectionViewCell class] forCellWithReuseIdentifier:@"movieCell"];
    
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

#pragma mark <UICollectionViewDataSource>
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
//        UIImage *headerImage = [UIImage imageNamed:@"owlicon.png"];
//        headerView.backgroundImage.image = headerImage;
        
        reusableview = headerView;
    }
//    
//    if (kind == UICollectionElementKindSectionFooter) {
//        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//        
//        reusableview = footerview;
//    }
    
    return reusableview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        NSInteger numberOfMovies = [self.movies  count];
    if (self.movies && numberOfMovies == 0) {
        return 1;
    }
    return numberOfMovies;
}

-(CGSize) collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width / 2 - 5 - 2.5, self.view.frame.size.width * 0.7);
//    return self.view.frame.size;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5,5,5);   //t,l,b,r
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if ([self.movies count] == 0) {
        NoMoviesCollectionViewCell *noCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
        noCell.backgroundColor = [UIColor redColor];
        noCell.noMovieLabel.text = @"No Movie Available";

        return noCell;
    }
    
    //movies available
    else {
        
    
    MoviesListCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    NSDictionary *movies = [self.movies objectAtIndex:indexPath.row];
    

    // Configure the cell
    NSURL *url = [NSURL URLWithString:[movies objectForKey:@"poster"]];
    [cell.poster setImageWithURL:url];
    
    //convert rating to int
    NSNumber *getRating = [movies objectForKey:@"tomato_meter"];
    int rating = [getRating intValue];
    
    // fill rating
    if (rating <= 0) {
        [cell.rating setText:@""];
    }
    else {
        [cell.rating setText:[NSString stringWithFormat:@"%@",getRating]];
    }
    
    //set background colour
    if (rating >= 70) {
        [cell.rating setBackgroundColor:[UIColor colorWithRed:40/255.0f green:226/255.0f blue:72/255.0f alpha:0.7f]];
    }
    else if (rating >= 50) {
        [cell.rating setBackgroundColor:[UIColor colorWithRed:251/255.0f green:255/255.0f blue:28/255.0f  alpha:0.7f]];
    }
    else {
        [cell.rating setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:4/255.0f alpha:0.7f]];
    }
        

        
        
//    //set time
        NSArray *sessions = [[movies objectForKey:@"showings"] objectForKey:@"data"];
        NSNumber *startTime = [sessions[0] objectForKey:@"start_time"];
        NSDate *startTimeDate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]];
        NSDate *now = [NSDate date];

        
        NSTimeInterval timeDifference = [startTimeDate timeIntervalSinceDate:now];
        int blah = (int)timeDifference/60;
        NSLog(@"coming in %i minutes", blah);
        cell.time.text = [NSString stringWithFormat:@"in %i minutes", blah];

    return cell;
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSelectedMovie"]) {
        NSArray *arr = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *path = [arr firstObject];
        NSLog(@"selected row %li", (long)path.row);
        
        SelectedMovieTableViewController *movieView = [segue destinationViewController];
        movieView.movie = [self.movies objectAtIndex:path.row];
        movieView.cinema = self.cinema;
        movieView.indexPathRow = path.row;
        
        

        //         SessionsTableViewController *sessionView = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //moviesView.cinema = [self.cinemas objectAtIndex:path.row];
        
    }
    
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
