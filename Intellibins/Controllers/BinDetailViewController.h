//
//  BinDetailViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempBin.h"

@interface BinDetailViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) TempBin *bin;

@property (nonatomic, assign) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) IBOutlet UIView *content;
@property (nonatomic, assign) IBOutlet UIImageView *image;
@property (nonatomic, assign) IBOutlet UILabel *address;
@property (nonatomic, assign) IBOutlet UILabel *distance;
@property (nonatomic, assign) IBOutlet UICollectionView *categoryCollection;


@end
