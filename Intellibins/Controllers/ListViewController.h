//
//  ListViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpView.h"
#import "GAITrackedViewController.h"

#define TUTORIALHELP_KEY @"listTutorial"

@interface ListViewController : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
    
    NSArray *categories;
    HelpView *help;
    HelpView *help2;
    BOOL hideHelp;
}

@property (strong, nonatomic) IBOutlet UIView *policyViewHolder;
@property (strong, nonatomic) IBOutlet UITextView *policyTextView;
@property (nonatomic, strong) void (^onCompletion)(BOOL reload);
- (IBAction)onPolicyAcceptTapped:(id)sender;

@end
