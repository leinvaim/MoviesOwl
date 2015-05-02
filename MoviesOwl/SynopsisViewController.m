//
//  SynopsisViewController.m
//  Pods
//
//  Created by Kelvin Tamzil on 20/02/2015.
//
//

#import "SynopsisViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SynopsisViewController ()

@end

@implementation SynopsisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPosterForSynopsis];
    [self showSynopsis];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setPosterForSynopsis {
    NSURL *url = [NSURL URLWithString:[self.movieSynopsisObj objectForKey:@"poster"]];
    [self.synopsisPoster setImageWithURL:url];
}
- (void) showSynopsis {
   // self.fullSynopsis.text = [self.movieSynopsisObj objectForKey:@"synopsis"];
    [self.fullSynopsis setText:[self.movieSynopsisObj objectForKey:@"synopsis"]];
    //CGSize scrollableSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 220);
    //[self.scrollView setContentSize:scrollableSize];
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
