//
//  AddCardViewController.h
//  TruLi
//
//  Created by Jesse Tellez on 4/7/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CardsTableViewController.h"
@interface AddCardViewController : UIViewController {
    BOOL checkBoxSelected;
}
@property (strong, nonatomic) NSMutableArray *userCards;
@property (strong, nonatomic) PFRelation *cardsRelation;
@property (weak, nonatomic) IBOutlet UITextView *createNewCardText;
@property (retain, nonatomic) IBOutlet UIButton *isTruthCard;
@property (retain, nonatomic) IBOutlet UIButton *isLieCard;
- (IBAction)addCardToArray:(id)sender;
- (void)checkBoxIsSelected:(id)sender;
- (IBAction)TruthButtonPushed:(id)sender;
- (void)setSelectedTruthYes:(UIButton *)sender;
@end