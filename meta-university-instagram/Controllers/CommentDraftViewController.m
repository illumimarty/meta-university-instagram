//
//  CommentDraftViewController.m
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/6/22.
//

#import "CommentDraftViewController.h"
#include <Parse/Parse.h>

@interface CommentDraftViewController ()

@end

@implementation CommentDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapPublishButton:(id)sender {
//    Post *post = self.postsArray[indexPath.section];
    Post *post = self.post;

    PFObject *comment = [[PFObject alloc] initWithClassName:@"Comment"];
    comment[@"text"] = self.draftTextField.text;
    comment[@"post"] = post;
    comment[@"author"] = PFUser.currentUser;

    [post addObject:comment forKey:@"comments"];

    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Comment saved!");
        } else {
            NSLog(@"Error saving comment!");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
