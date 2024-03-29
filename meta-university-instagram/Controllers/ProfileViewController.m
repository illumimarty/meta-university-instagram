//
//  ProfileViewController.m
//  meta-university-instagram
//
//  Created by Marthan Nodado on 5/30/22.
//

#import "ProfileViewController.h"
#include "Parse/Parse.h"
#include "LoginViewController.h"
#include "SceneDelegate.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFFileObject *userProfileImage = PFUser.currentUser[@"profileImageData"];
    
    [userProfileImage getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:imageData];
            CGRect bounds = UIScreen.mainScreen.bounds;
            CGFloat width = bounds.size.width;
            CGSize imageSize = CGSizeMake(width, width);
            self.profileImageView.image = [self resizeImage:image withSize:imageSize];
        }
    }];
    
    self.friendsCountLabel.text = @"48";
    self.followingCountLabel.text = @"1516";
    self.navigationItem.title = PFUser.currentUser[@"username"];
    
    // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAvatar:)];
      
      // Optionally set the number of required taps, e.g., 2 for a double click
      tapGestureRecognizer.numberOfTapsRequired = 1;
      
      // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
      [self.profileImageView setUserInteractionEnabled:YES];
      [self.profileImageView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)onTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];

    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

    myDelegate.window.rootViewController = loginViewController;
}
- (IBAction)onTapAvatar:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    // TODO: When choosing image from album, make sure that the user can confirm their image choice
    
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.sourceType = nil;
//
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"choose image!" preferredStyle:UIAlertControllerStyleActionSheet];
//
//    // Profile Picture by Camera
//    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Open camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NSLog(@"chosen camera!");
//
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//        }
//        else {
//            NSLog(@"Camera 🚫 available so we will use photo library instead");
//            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        }
//
//        [self presentViewController:imagePickerVC animated:YES completion:nil];
//    }];
//
//    [alertController addAction:cameraAction];
//
//    // Profile Picture by Album
//    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Select from album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NSLog(@"chosen album!");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:imagePickerVC animated:YES completion:nil];
//    }];
//
//    [alertController addAction:albumAction];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cencel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
//
//    [alertController addAction:cancelAction];
//
//    [self presentViewController:alertController animated:YES completion:^{
//
//        NSLog(@"Profile image picker finished!");
//    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    // MARK: create dimensions of image
    CGRect bounds = UIScreen.mainScreen.bounds;
    CGFloat width = bounds.size.width;
    CGSize imageSize = CGSizeMake(width, width);
    self.profileImageView.image = [self resizeImage:editedImage withSize:imageSize];
    
    // MARK: Save/update profile image to user's data
    NSData *imageData = UIImagePNGRepresentation(editedImage);
    PFFileObject *imageFile = [PFFileObject fileObjectWithName:@"avatar.png" data:imageData];

    PFUser.currentUser[@"profileImageData"] = imageFile;
    [PFUser.currentUser saveInBackground];
    NSLog(@"Profile image saved!");
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
