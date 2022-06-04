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
    [postQuery includeKey:@"author"];
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

        DetailsViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;

        Post *post = self.postsArray[indexPath.row];
        vc.post = post;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.postsArray[indexPath.row];
    [cell setPost:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
