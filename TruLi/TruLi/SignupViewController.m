//
//  SignupViewController.m
//  TruLi
//
//  Created by Jesse Tellez on 3/30/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)Signup:(id)sender {
    //this is the code that runs when the signup button is pressed
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //on the below line of code, check for valid email parameters
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *firstName = [self.firstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *lastName = [self.lastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *homeTown = [self.homeTown.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //next check if any of the fields have been left blank or not
    //chain the conditions together using special operators
    if ([username length] == 0 || [password length] == 0 || [email length] == 0 || [homeTown length]==0) {
        //create the alert
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Make sure you enter a username, password, home town, and email adress!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //show the alert
        [alertview show];
    }
    else {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        [newUser setObject:firstName forKey:@"firstName"];
        [newUser setObject:lastName forKey:@"lastName"];
        [newUser setObject:homeTown forKey:@"homeTown"];
        UIImage *image = [UIImage imageNamed:@"headImage.png"];
        NSData *imageData = UIImagePNGRepresentation(image);
        PFFile *imageFile = [PFFile fileWithName:@"headImage.png" data:imageData];
        [newUser addObject:imageFile forKey:@"profilePicture"];
        
        //the signUpinBackground method is a separate thread
        //this is a block of code, but the whole block can be used and passed around like its own object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry!" message: [error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
}
@end
