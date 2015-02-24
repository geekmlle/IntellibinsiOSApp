//
//  TutorialViewController.m
//
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "TutorialViewController.h"
#import "TutorialViewCell.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [_collectionView registerClass:[TutorialViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
}

- (void) viewDidAppear:(BOOL)animated
{
    CGSize screenSize = self.view.frame.size;
    NSLog(@"%@", NSStringFromCGSize(screenSize));
    
    [_collectionView setFrame:self.view.frame];
    //[_scrollView setContentSize:CGSizeMake(screenSize.width * 3, 1)];
    
/*
    CGRect frame = CGRectMake(0, -20, screenSize.width, screenSize.height);
    [img1 setFrame:frame];
    
    frame.origin.x += screenSize.width;
    [img2 setFrame:frame];
    
    frame.origin.x += screenSize.width;
    [img3 setFrame:frame];
    */
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    
    TutorialViewCell *cell = (TutorialViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    /*
    if(indexPath.row == 0)
    {
        [cell.mainImg setImage:[UIImage imageNamed:@"tutorial1"]];
        [cell.descriptionLabel setText:@"Find the nearest recycling bins within walking distance."];
    }
    else if(indexPath.row == 1)
    {
        [cell.mainImg setImage:[UIImage imageNamed:@"tutorial2"]];
        [cell.descriptionLabel setText:@"Learn about which stores take stuff back."];
    }
    */
    cell.backgroundColor = [UIColor blueColor];
    
    switch(indexPath.row % 3)
    {
        case 0:
            [cell.mainImg setImage:[UIImage imageNamed:@"tutorial1"]];
            [cell.descriptionLabel setText:@"Find the nearest recycling bins within walking distance."];
            break;
        case 1:
            [cell.mainImg setImage:[UIImage imageNamed:@"tutorial2"]];
            [cell.descriptionLabel setText:@"Learn about which stores take stuff back."];
            break;
        case 2:
            [cell.mainImg setImage:[UIImage imageNamed:@"tutorial3"]];
            [cell.descriptionLabel setText:@"Start making a difference, one can at a time."];
            break;
    }
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
