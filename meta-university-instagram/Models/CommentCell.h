//
//  CommentCell.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

NS_ASSUME_NONNULL_END
