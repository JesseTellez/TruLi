//
//  ProfileViewController.m
//  TruLi
//
//  Created by Jesse Tellez on 3/31/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import "ProfileViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_usernameTextLabel superview]bringSubviewToFront:_usernameTextLabel];
    [[_profilePicImage superview]bringSubviewToFront:_profilePicImage];
    [[_userLocationTextLabel superview]bringSubviewToFront:_userLocationTextLabel];
    PFUser *user = [PFUser currentUser];
    NSString *location = user[@"homeTown"];
    self.userLocationTextLabel.text = location;
    self.usernameTextLabel.text = user.username;
    PFQuery *query = [PFQuery queryWithClassName:@"profilePicture"];
    PFFile *file = [user objectForKey:@"headImage.png"];
    
    if (file != NULL) {
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *thumbnail = [UIImage imageWithData:data];
            UIImageView *thumbnailiv = [[UIImageView alloc]initWithImage:thumbnail];
            self.profilePicImage.image = thumbnailiv.image;
        }];
    }
    
    
    self.profilePicImage.layer.masksToBounds = YES;
    
}

- (IBAction)addPictureTapped:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([mediaTypes containsObject:(NSString *)kUTTypeImage]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = (id)self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
            
        }
        else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController *photoLibraryController = [[UIImagePickerController alloc]init];
            photoLibraryController.delegate = (id)self;
            photoLibraryController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            photoLibraryController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            photoLibraryController.allowsEditing = NO;
            [self presentViewController:photoLibraryController animated:YES completion:nil];
        }
        else{
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Camera Gallery Is Currently Not Availible" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertview show];
        }
        
        
        
    }
}

- (void)ImagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSObject *)id {
    NSData *data = UIImageJPEGRepresentation(image, 0.08);
    //PFFile *file = data;
    
}
@end
