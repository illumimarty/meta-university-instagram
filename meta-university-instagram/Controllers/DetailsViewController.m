//
//  DetailsViewController.m
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/1/22.
//

#import "DetailsViewController.h"
#import "CommentDraftViewController.h"
#import "CommentCell.h"
//#import "PFImageView.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setPost:self.post];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;

}

- (void)viewWillAppear:(BOOL)animated {
    [self.commentTableView reloadData];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"detailsToComment"]) {
        CommentDraftViewController *vc = [segue destinationViewController];
        vc.post = self.post;
    }
    
    
}


- (IBAction)didTapHomeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapLikeButton:(id)sender {
}

- (IBAction)didTapCommentButton:(id)sender {
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
//    Post *post = self.postsArray[indexPath.section];
    
    Post *post = self.post;
    NSArray *comments = post[@"comments"];
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    
    NSDictionary *comment = comments[indexPath.row];
    cell.commentLabel.text = comment[@"text"];
    
    PFUser *user = comment[@"author"];
    cell.usernameLabel.text = user.username;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Post *post = self.post;
    NSArray *comments = post[@"comments"];
    
    return comments.count;
}


@end
