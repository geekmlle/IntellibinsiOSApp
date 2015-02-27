//
//  HelpView.h
//  Intellibins
//
//  Created by Ben on 26/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpView : UIView

@property (nonatomic, assign) IBOutlet UILabel *textLabel;
@property (nonatomic, assign) IBOutlet UIView *mainView;

- (void) animateViewEnter;
-(IBAction)hideView:(id)sender;
@end
