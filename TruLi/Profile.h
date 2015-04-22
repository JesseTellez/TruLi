//
//  Profile.h
//  TruLi
//
//  Created by Jesse Tellez on 4/2/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "ProfileViewController.h"

@interface Profile : NSObject
@property (strong, nonatomic)PFUser *currentUser;

@property (strong, nonatomic)NSString *user_name;
@property (strong, nonatomic)NSString *user_location;
@property (strong, nonatomic)UIImage *User_Picture;
@property (assign, nonatomic)NSUInteger *userGamesPlayed;
@property (assign, nonatomic)NSUInteger *numberOfUserWins;
@property (assign, nonatomic)NSUInteger *numberOfUserHonors;

-(instancetype)initWithUser:(PFUser *)User;

@end
