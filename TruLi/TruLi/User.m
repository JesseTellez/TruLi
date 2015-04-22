//
//  User.m
//  TruLi
//
//  Created by Jesse Tellez on 4/2/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)initWithUser:(PFUser *)User {
    self = [super init];
    if (self) {
        PFUser *User = [PFUser currentUser];
        NSString *Name = user.user
        NSString *Locaton = User.username;
        
        
    }
}


@end
