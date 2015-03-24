//
//  CategoryCollectionViewCell.m
//  Intellibins
//
//  Created by Ben on 19/3/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell
@synthesize categoryIcon = _categoryIcon;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.categoryIcon];
    }
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[[UIImage imageNamed:@"avatar_mask"] CGImage];
    mask.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
    return self;
}

- (UIImageView *)categoryIcon
{
    if(_categoryIcon == nil)
    {
        _categoryIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
        _categoryIcon.backgroundColor = [UIColor clearColor];
        _categoryIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _categoryIcon;
}

@end
