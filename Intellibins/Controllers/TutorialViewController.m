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
    [_collectionView setHidden:YES];
}

- (void) viewDidAppear:(BOOL)animated
{
    [_collectionView setHidden:NO];
    [_collectionView setFrame:self.view.frame];
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
    CGSize size = [UIScreen mainScreen].bounds.size;
    size.height += 10;
    return size;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TutorialViewCell *cell = (TutorialViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    [pageControl setCurrentPage:indexPath.row];
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [pageControl setCurrentPage:page];
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
