//
//  LoginViewController.h
//  meta-university-instagram
//
//  Created by Marthan Nodado on 5/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)didTapLogin:(id)sender;
- (IBAction)didTapRegister:(id)sender;
- (void)registerUser;
- (void)loginUser;

@end

NS_ASSUME_NONNULL_END
