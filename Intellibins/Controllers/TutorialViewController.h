//
//  TutorialViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView *_collectionView;
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIView *img1;
    IBOutlet UIView *img2;
    IBOutlet UIView *img3;
}

- (IBAction)getStartedClicked:(id)sender;

@end
