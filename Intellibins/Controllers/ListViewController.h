//
//  ListViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpView.h"

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
    
    NSArray *categories;
    HelpView *help;
    HelpView *help2;
    BOOL hideHelp;
}

@property (nonatomic, strong) void (^onCompletion)(BOOL reload);

@end
