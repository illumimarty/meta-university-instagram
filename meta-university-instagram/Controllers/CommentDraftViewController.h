//
//  CommentDraftViewController.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/6/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentDraftViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *draftTextField;
@property (strong, nonatomic) Post *post;
- (IBAction)didTapPublishButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
