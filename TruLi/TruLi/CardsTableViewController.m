//
//  CardsTableViewController.m
//  TruLi
//
//  Created by Jesse Tellez on 4/7/15.
//  Copyright (c) 2015 CSCI3308. All rights reserved.
//

#import "CardsTableViewController.h"

@interface CardsTableViewController ()

@end

@implementation CardsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    [self performSelector:@selector(loadDataFromParse)];
    [self performSelector:@selector(isCardOwner:) withObject:self.currentUser];
    if ([self isCardOwner:self.currentUser]) {
        [self performSelector:@selector(cellForRowAtIndexPath:)];
    }
}

- (void)loadDataFromParse {
    PFQuery *query = [PFQuery queryWithClassName:@"userCard"];
    [query whereKey:@"CardOwner" equalTo:self.currentUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else {
            self.userCards = objects;
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            });
        }
    }];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.userCards.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CardsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    UIButton *deleteButton = (UIButton *)[cell viewWithTag:200];
//    [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    PFObject *card = [self.userCards objectAtIndex:indexPath.row];
    NSString *cardInfo = [card objectForKey:@"text"];
    cell.textLabel.text = cardInfo;
    //    if ([self isTruthCard:card]) {
//        color the card background green
//    }
//    else {
//        color the card background red
//    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showAddCard"]) {
        AddCardViewController *VC = (AddCardViewController *)segue.destinationViewController;
        VC.userCards = [NSMutableArray arrayWithArray:self.userCards];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *userCard = [self.allCards objectAtIndex:indexPath.row];
        [self.allCards removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [userCard deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                NSLog(@"ERROR: %@, %@",error, [error userInfo]);
            }
        }];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
    }
    else {
        //nil
    }
}
- (BOOL)isCardOwner:(PFUser *)user {
    for (PFObject *card in self.userCards) {
        if ([[card objectForKey:@"CardOwner"] isEqualToString:user.objectId]) {
            NSLog(@"This is the card owner");
            return YES;

        }
    }
    return NO;
}

- (BOOL)isTruthCard:(PFObject *)card {
    return YES;
}

@end
