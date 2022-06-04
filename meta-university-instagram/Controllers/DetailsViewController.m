//
//  DetailsViewController.m
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/1/22.
//

#import "DetailsViewController.h"
//#import "PFImageView.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setPost:self.post];

}

- (void)setPost:(Post *)post {
//    self.post = post;
    _post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    
//    NSString *caption = [NSString stringWithFormat:@"@%@ %@", post[@"author"], post[@"caption"]];
    NSString *caption = post[@"caption"];
    self.captionLabel.text = caption;
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
