//
//  BinDetailViewController.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "BinDetailViewController.h"

@interface BinDetailViewController ()

@end

@implementation BinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setFrame:[UIScreen mainScreen].bounds];
    [self.content setFrame:[UIScreen mainScreen].bounds];
    
    [self.scrollView addSubview:self.content];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 504)];
    
    self.title = self.bin.short_name;
    self.address.text = self.bin.address;
    
    self.categoryList = [self.bin.item_list componentsSeparatedByString:@","];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openGoogleMaps:(id)sender
{
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categoryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
