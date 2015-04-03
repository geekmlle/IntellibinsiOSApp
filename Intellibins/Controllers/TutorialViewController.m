//
//  TutorialViewController.m
//
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "TutorialViewController.h"
#import "TutorialViewCell.h"
#import "ListViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [_collectionView registerClass:[TutorialViewCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
    //[_collectionView setHidden:YES];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect frame = CGRectMake(-10, 0, size.width, size.height + 20);
    
    [self.view setFrame:frame];
    [_collectionView setFrame:frame];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:size];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_collectionView setCollectionViewLayout:flowLayout];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[_collectionView setHidden:NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedClicked:(id)sender
{
    ListViewController *listVC = [[ListViewController alloc] init];
    UINavigationController *listNVC = [[UINavigationController alloc] initWithRootViewController:listVC];
    [self.navigationController presentViewController:listNVC animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

- (void) showCategoryList
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

/*
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    //size.height -= 20;
    
    NSLog(@"Item: %@", NSStringFromCGSize(size));
    NSLog(@"View: %@", NSStringFromCGSize(collectionView.frame.size));
    
    return size;
}*/


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

- (IBAction)pageControlClicked:(UIPageControl *)sender
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:sender.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
