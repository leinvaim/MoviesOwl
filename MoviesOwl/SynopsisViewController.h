//
//  SynopsisViewController.h
//  Pods
//
//  Created by Kelvin Tamzil on 20/02/2015.
//
//

#import <UIKit/UIKit.h>

@interface SynopsisViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *synopsisPoster;
@property (weak, nonatomic) IBOutlet UITextView *fullSynopsis;

@property (nonatomic, strong) NSDictionary *movieSynopsisObj;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
