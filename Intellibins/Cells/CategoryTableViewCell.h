//
//  CategoryTableViewCell.h
//  Intellibins
//
//  Created by Ben on 25/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UIView *mainView;
@property (nonatomic, assign) IBOutlet UIImageView *icon;
@property (nonatomic, assign) IBOutlet UILabel *name;
@property (nonatomic, assign) IBOutlet UISwitch *toggle;

@end
