//
//  TutorialViewCell.h
//  Intellibins
//
//  Created by Ben on 24/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewCell : UICollectionViewCell

@property (nonatomic, assign) IBOutlet UIView *mainView;
@property (nonatomic, assign) IBOutlet UIImageView *mainImg;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;

@end
