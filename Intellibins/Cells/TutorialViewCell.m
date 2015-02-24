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
        NSArray *screens = [[NSBundle mainBundle] loadNibNamed:@"TutorialViewCell" owner:self options:nil];
        [self addSubview:[screens firstObject]];
        
        CGRect frame = self.mainView.frame;
        frame.size.width = [[UIScreen mainScreen] bounds].size.width;
        frame.size.height = [[UIScreen mainScreen] bounds].size.height;
        self.mainView.frame = frame;
    }
    return self;
}

@end
