//
//  CategoryTableViewCell.m
//  Intellibins
//
//  Created by Ben on 25/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        NSArray *screens = [[NSBundle mainBundle] loadNibNamed:@"CategoryTableViewCell" owner:self options:nil];
        [self addSubview:[screens firstObject]];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
