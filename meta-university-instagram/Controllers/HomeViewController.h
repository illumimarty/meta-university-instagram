//
//  HomeViewController.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 5/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *postsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
