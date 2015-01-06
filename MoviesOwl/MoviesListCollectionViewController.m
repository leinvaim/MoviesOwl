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


@interface MoviesListCollectionViewController ()
@property (nonatomic, strong) NSArray *movies;
@end

@implementation MoviesListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.cinema objectForKey:@"location"];
    
    NSString *stringID = [self.cinema objectForKey:@"id" ];
    int cinemaID = [stringID intValue];
    NSLog(@"Debug: Getting posts");

    [[ApiManager sharedManager] getMoviesInCinema:(cinemaID) success:^(NSArray *movies) {
        self.movies = movies;
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"It failed");
    }];

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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
//    if (numberOfMovies == 0) {
//        return 1;
//    }
    return numberOfMovies;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *movies = [self.movies objectAtIndex:indexPath.row];
    
      MoviesListCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
//    if ([movies count] == 0) {
//        cell.rating.text = @"NO MOVIES AVAILABLE";
//        NSLog(@"im here");
//        return cell;
//    }

    // Configure the cell
    NSURL *url = [NSURL URLWithString:[movies objectForKey:@"poster"]];
    [cell.poster setImageWithURL:url];
    
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





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSelectedMovie"]) {
        NSArray *arr = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *path = [arr firstObject];
        NSLog(@"selected row %li", (long)path.row);
        
        MovieTableViewController *movieView = [segue destinationViewController];
  
            movieView.movie = [self.movies objectAtIndex:path.row];
        

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
