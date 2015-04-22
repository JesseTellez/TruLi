//
//  AddCardViewController.m
//  TruLi
//
//  Created by Jesse Tellez on 4/7/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import "AddCardViewController.h"

@interface AddCardViewController ()

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *imageLayer = _createNewCardText.layer;
    [imageLayer setCornerRadius:10];
    [imageLayer setBorderWidth:1];
    imageLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.isTruthCard = [[UIButton alloc]initWithFrame:CGRectMake(140, 400 , 100, 100)];
    [self.isTruthCard setBackgroundImage:[UIImage imageNamed:@"checkmark3.png"] forState:UIControlStateNormal];
    [self.isTruthCard setBackgroundImage:[UIImage imageNamed:@"checkmark1.png"] forState:UIControlStateSelected|UIControlStateHighlighted];
    [self.isTruthCard setBackgroundImage:[UIImage imageNamed:@"checkmark1.png"] forState:UIControlStateHighlighted];
    self.isTruthCard.adjustsImageWhenHighlighted = YES;
    [self.isTruthCard addTarget:self action:@selector(TruthButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_isTruthCard];
}



- (IBAction)addCardToArray:(id)sender {
    PFUser *user = [PFUser currentUser];
    NSString *cardInfo = [self.createNewCardText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //self.cardsRelation = [[PFUser currentUser]objectForKey:@"cardsRelation"];
    PFObject *newPlayerCard = [PFObject objectWithClassName:@"userCard"];
    
    [self.userCards addObject:newPlayerCard];
    newPlayerCard[@"text"] = cardInfo;
    newPlayerCard[@"CardOwner"] = user;
    //user[@"myCards"] = newPlayerCard;
    
    if ((self.isTruthCard.state == UIControlStateHighlighted) || (self.isTruthCard.state == UIControlStateSelected))
    {
//        PFObject *newPlayerCard = [PFObject objectWithClassName:@"userCard"];
//        
//        [self.userCards addObject:newPlayerCard];
//        newPlayerCard[@"text"] = cardInfo;
//        newPlayerCard[@"CardOwner"] = user;
        newPlayerCard[@"Truth"]= @YES;
        //[self.cardsRelation addObject:newPlayerCard];
        
        [newPlayerCard saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Saved" message:@"Your card has successfully been saved!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertview show];
            }
            else {
                NSLog(@"Error %@ %@", error, [error userInfo]);
            }
        }];
         
    }
    else{
        newPlayerCard[@"Truth"] = @NO;
        //[self.cardsRelation addObject:newPlayerCard];
        [newPlayerCard saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"Saved" message:@"Your card has successfully been saved!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertview show];
            }
            else {
                NSLog(@"Error %@ %@", error, [error userInfo]);
            }
        }];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backToCardsView"]){
        CardsTableViewController *lvc =segue.destinationViewController;
        lvc.navigationItem.hidesBackButton = YES;
    }
}

- (void)checkBoxIsSelected:(id)sender {
    checkBoxSelected = !checkBoxSelected;
    [self.isTruthCard setSelected:checkBoxSelected];
}

- (IBAction)TruthButtonPushed:(id)sender {
    //add functionallity to retain state
    [self performSelector:@selector(setSelectedTruthYes:) withObject:sender afterDelay:0];
}

- (void)setSelectedTruthYes:(UIButton *)sender {
    [sender setHighlighted:YES];
}
@end
