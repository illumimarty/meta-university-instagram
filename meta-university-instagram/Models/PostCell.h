//
//  PostCell.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/1/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import  Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (strong, nonatomic) Post *post;

- (void)setPost:(Post * _Nonnull)post;

@end

NS_ASSUME_NONNULL_END
