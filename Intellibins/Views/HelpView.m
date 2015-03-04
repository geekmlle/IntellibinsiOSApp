//
//  HelpView.m
//  Intellibins
//
//  Created by Ben on 26/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "HelpView.h"

@implementation HelpView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        NSArray *screens = [[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:self options:nil];
        [self addSubview:[screens lastObject]];
        
        CGRect newFrame = self.mainView.frame;
        newFrame.size.width = frame.size.width;
        newFrame.size.height = frame.size.height;
        [self.mainView setFrame:newFrame];
    }
    
    return self;
}

- (void) animateViewEnter
{
    self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, self.frame.size.height);
    
    __block CGFloat yAxis = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, yAxis);
        yAxis += 20;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, yAxis);
            yAxis -= 5;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}

-(IBAction)hideView:(id)sender
{
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, -10);
    }completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, self.frame.size.height);
        }completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
    }];
}

@end
