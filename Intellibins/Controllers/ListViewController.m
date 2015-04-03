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

#define TUTORIAL_KEY @"listTutorial"
#define TUTORIAL_KEY_2 @"switchTutorial"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *applyBtn = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(applyFilterClicked:)];
    self.navigationItem.rightBarButtonItem = applyBtn;
    
    categories = [Util sharedInstance].categories;
    [_tableView registerClass:[CategoryTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    
    self.title = @"Filter";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:TUTORIAL_KEY])
    {
        [self showTutorial:0];
        [defaults setBool:YES forKey:TUTORIAL_KEY];
        [defaults synchronize];
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
@end
