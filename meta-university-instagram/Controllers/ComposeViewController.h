//
//  ComposeViewController.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 5/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *draftImageView;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;

- (IBAction)cancelButton:(id)sender;
- (IBAction)didTapPublishButton:(id)sender;
- (IBAction)didTapImageView:(id)sender;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;

@end

NS_ASSUME_NONNULL_END
