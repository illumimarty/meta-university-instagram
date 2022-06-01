//
//  PostCell.m
//  meta-university-instagram
//
//  Created by Marthan Nodado on 6/1/22.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    
//    NSString *caption = [NSString stringWithFormat:@"@%@ %@", post[@"author"], post[@"caption"]];
    NSString *caption = post[@"caption"];
    self.captionLabel.text = caption;
}

@end
