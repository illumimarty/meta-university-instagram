//
//  HomeViewController.m
//  meta-university-instagram
//
//  Created by Marthan Nodado on 5/30/22.
//

#import "HomeViewController.h"
#import "DetailsViewController.h"
#include <Parse/Parse.h>
#include "Post.h"
#include "PostCell.h"
#include "CommentCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchPosts];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];

}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    // Create NSURL and NSURLRequest
    [self fetchPosts];

    // ... Use the new data to update the data source ...

    // Reload the tableView now that there is new data
    [self.tableView reloadData];

    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

- (void)fetchPosts {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKeys: [NSArray arrayWithObjects:@"author", @"comments", @"comments.author", nil]];
//    [postQuery includeKey:@"author"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.postsArray = (NSMutableArray *)posts;
            NSLog(@"%@", posts);
            [self.tableView reloadData];
        }
        else {
            // handle error
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"homeToDetails"]) {
        UINavigationController *nav = [segue destinationViewController];
        DetailsViewController *vc = (DetailsViewController *)nav.topViewController;
        PostCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Post *post = self.postsArray[indexPath.section];
        vc.post = post;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    Post *post = self.postsArray[indexPath.section];
    NSArray *comments = post[@"comments"];
    
    if (indexPath.row == 0) {
        PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
        [cell setPost:post];
        
        return cell;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        
        NSDictionary *comment = comments[indexPath.row - 1];
        cell.commentLabel.text = comment[@"text"];
        
        PFUser *user = comment[@"author"];
        cell.usernameLabel.text = user.username;
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // TODO: how to initialize comments array if it's empty?
    Post *post = self.postsArray[section];
    NSArray *comments = post[@"comments"];
    
    return comments.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.postsArray.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Post *post = self.postsArray[indexPath.section];
    
    PFObject *comment = [[PFObject alloc] initWithClassName:@"Comment"];
    comment[@"text"] = @"This is pretty cool I guess";
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
}

@end
