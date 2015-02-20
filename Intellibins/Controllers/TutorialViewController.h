//
//  TutorialViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController
{
    UIPageControl *pageControl;
    UIImageView *imageView;
    UILabel *description;
}

- (IBAction)getStartedClicked:(id)sender;

@end
