//
//  ProfileViewController.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 5/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
- (IBAction)onTapLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendsCountLabel;

@end

NS_ASSUME_NONNULL_END
