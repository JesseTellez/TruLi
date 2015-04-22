//
//  CardsTableViewController.h
//  TruLi
//
//  Created by Jesse Tellez on 4/7/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AddCardViewController.h"

@interface CardsTableViewController : UITableViewController
@property (strong, nonatomic) PFUser *currentUser;
@property (strong, nonatomic) PFRelation *cardsRelation;
@property (strong, nonatomic) NSArray *userCards;
@property (strong, nonatomic) NSMutableArray *allCards;
@property (strong, nonatomic) PFObject *card;
- (BOOL)isTruthCard:(PFObject *)card;
-(void)loadDataFromParse;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
- (BOOL)isCardOwner:(PFUser *)user;
@end
