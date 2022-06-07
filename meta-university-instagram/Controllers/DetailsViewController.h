//
//  DetailsViewController.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/1/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PFImageView.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
- (IBAction)didTapCommentButton:(id)sender;
- (IBAction)didTapLikeButton:(id)sender;
- (IBAction)didTapHomeButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
