//
//  TutorialViewCell.m
//  Intellibins
//
//  Created by Ben on 24/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "TutorialViewCell.h"

@implementation TutorialViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self addSubview:self.mainImg];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

-(UIImageView *)mainImg
{
    if(_mainImg == nil)
    {
        _mainImg = [[UIImageView alloc] initWithFrame:self.frame];
    }
    return _mainImg;
}

- (UILabel *)descriptionLabel
{
    if(_descriptionLabel == nil)
    {
        CGRect frame = self.frame;
        frame.size.width -= 40;
        frame.size.height = 50;
        
        _descriptionLabel = [[UILabel alloc] initWithFrame:frame];
        [_descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [_descriptionLabel setTextColor:[UIColor whiteColor]];
        [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
        [_descriptionLabel setNumberOfLines:2];
        
        [_descriptionLabel setCenter:self.center];
    }
    return _descriptionLabel;
}

@end
