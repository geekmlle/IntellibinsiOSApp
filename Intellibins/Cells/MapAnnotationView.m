//
//  MapAnnotationView.m
//  Intellibins
//
//  Created by Ben on 3/4/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView
@synthesize colorBackground = _colorBackground, whiteBackground = _whiteBackground;

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier andFrame:(CGRect)_frame
{
    self = [super init];
    if(self)
    {
        self.frame = _frame;
        [self addSubview:self.whiteBackground];
        [self addSubview:self.colorBackground];
        
        CALayer *mask = [CALayer layer];
        mask.contents = (id)[[UIImage imageNamed:@"avatar_mask"] CGImage];
        mask.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
        self.whiteBackground.layer.mask = mask;
        self.whiteBackground.layer.masksToBounds = YES;
        
        CALayer *mask2 = [CALayer layer];
        mask2.contents = (id)[[UIImage imageNamed:@"avatar_mask"] CGImage];
        mask2.frame = CGRectMake(0, 0, self.colorBackground.frame.size.width, self.colorBackground.frame.size.height);
        self.colorBackground.layer.mask = mask2;
        self.colorBackground.layer.masksToBounds = YES;
    }
    
    return self;
}

- (UIView *)whiteBackground
{
    if(_whiteBackground == nil)
    {
        _whiteBackground = [[UIView alloc] initWithFrame:self.frame];
        _whiteBackground.backgroundColor = [UIColor whiteColor];
    }
    
    return _whiteBackground;
}

- (UIView *)colorBackground
{
    if(_colorBackground == nil)
    {
        _colorBackground = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 4)];
        _colorBackground.backgroundColor = [UIColor grayColor];
    }
    
    return _colorBackground;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
