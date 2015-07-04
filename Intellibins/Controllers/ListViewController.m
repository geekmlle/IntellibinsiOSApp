//
//  ListViewController.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "ListViewController.h"
#import "Util.h"
#import "CategoryTableViewCell.h"
#import "TempItem.h"
#import "MapViewController.h"
#import "UIColor+IntellibinsColor.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

#define TUTORIAL_KEY_2 @"switchTutorial"
#define TOGGLEDALLFILTERS @"toggledAllFilters"

@interface ListViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftButtonItem;
@property (nonatomic) BOOL toggledAll;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
	//self.screenName = @"Main Screen";
	
	id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	[tracker set:kGAIScreenName value:@"Main"];
	[tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    categories = [Util sharedInstance].categories;
    [_tableView registerClass:[CategoryTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.title = @"Intellibins";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor blackColor];
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 6.0, 0, 6.0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    self.policyViewHolder.hidden = YES;

}


- (void)setUpPolicyView
{
    self.policyViewHolder.hidden = NO;
    self.policyTextView.editable = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:TUTORIALHELP_KEY])
    {
        [self setUpPolicyView];
    }else {
        [self setUpStyle];
    }
    
    if([defaults boolForKey:TOGGLEDALLFILTERS]){
        self.leftButtonItem.title = @"Deselect All";
        self.toggledAll = YES;
    }else {
        self.leftButtonItem.title = @"Select All";
        self.toggledAll = NO;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showTutorial:(NSInteger)tut
{
    hideHelp = YES;
    CGFloat height = self.view.frame.size.width / 2;
    CGRect frame = CGRectMake(0, self.view.frame.size.height - height, self.view.frame.size.width, height + 20);
    if(tut == 0)
    {
        if(!help){
            help = [[HelpView alloc] initWithFrame:frame];
        }
        help.textLabel.text = @"Select the items you'd like to know where to recycle.";
        [self.view addSubview:help];
        
        [help animateViewEnter];
    }
    else
    {
        if(!help2){
            help2 = [[HelpView alloc] initWithFrame:frame];
        }
        help2.textLabel.text = @"Tap 'Apply' to view where they can be disposed of on the map";
        [self.view addSubview:help2];
        
        [help2 animateViewEnter];
    }
}
    

- (void)applyFilterClicked:(id)sender
{
    [Util saveCategories];
    if (self.onCompletion) {
        self.onCompletion([Util sharedInstance].reloadMap);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectAllClicked:(id)sender
{
	id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
 
	[tracker set:kGAIScreenName value:@"SelectAllClicked"];
	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
														  action:@"touch"
														   label:@"test"
														   value:nil] build]];
	[tracker set:kGAIScreenName value:nil];
	
    if (self.toggledAll) {
        for (TempItem *item in categories) {
            item.is_toggled = NO;
        }
        self.toggledAll = NO;
        self.leftButtonItem.title = @"Select All";

    }else {
        for (TempItem *item in categories) {
            item.is_toggled = YES;
        }
        self.toggledAll = YES;
        self.leftButtonItem.title = @"Deselect All";

    }
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:self.toggledAll] forKey:TOGGLEDALLFILTERS];
    [defaults synchronize];
    
    [Util sharedInstance].reloadMap = YES;
    [_tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    TempItem *item = [categories objectAtIndex:indexPath.row];
    
    CGRect frame = cell.mainView.frame;
    frame.size.width = tableView.frame.size.width;
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.mainView.frame = frame;
    cell.name.text = item.item_name;
    cell.toggle.on = item.is_toggled;
    cell.toggle.tag = indexPath.row;
    cell.icon.image = [Util getImageForCategoryName:item.item_type];
    [cell.toggle addTarget:self action:@selector(didToggleSwitch:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (void) didToggleSwitch:(UISwitch *)_switch
{
    if(help)
    {
        [help hideView:nil];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:TUTORIAL_KEY_2])
    {
        [self showTutorial:1];
        [defaults setBool:YES forKey:TUTORIAL_KEY_2];
        [defaults synchronize];
    }
    
    TempItem *item = [categories objectAtIndex:_switch.tag];
    item.is_toggled = !item.is_toggled;
    
    [Util sharedInstance].reloadMap = YES;
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(hideHelp)
    {
        hideHelp = NO;
        if(help) [help hideView:nil];
        if(help2) [help2 hideView:nil];
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(hideHelp)
    {
        hideHelp = NO;
        if(help) [help hideView:nil];
        if(help2) [help2 hideView:nil];
    }
}
- (IBAction)onPolicyAcceptTapped:(id)sender
{
    [self showTutorial:0];
    self.policyViewHolder.hidden = YES;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:TUTORIALHELP_KEY])
    {
        [defaults setBool:YES forKey:TUTORIALHELP_KEY];
        [defaults synchronize];
    }
    
    [self setUpStyle];
	
}

- (void)setUpStyle
{
    self.view.alpha = 0.8;
	
    // show apply button after user "accept" policy
    self.title = @"Item Types";
    
    UIBarButtonItem *applyBtn = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(applyFilterClicked:)];
    [applyBtn setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:17.], NSForegroundColorAttributeName: [UIColor kIntellibinsGreen]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = applyBtn;
    
    self.leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Select All" style:UIBarButtonItemStyleDone target:self action:@selector(selectAllClicked:)];
    [self.leftButtonItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:17.], NSForegroundColorAttributeName: [UIColor kIntellibinsGreen]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = self.leftButtonItem;
}
@end
