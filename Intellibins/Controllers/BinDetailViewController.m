//
//  BinDetailViewController.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "BinDetailViewController.h"
#import "CategoryCollectionViewCell.h"
#import "MapAnnotion.h"
#import "Util.h"
#import "TempItem.h"

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
    
    [_categoryCollection registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCell"];
    
    CLLocation *binLocation = [[CLLocation alloc] initWithLatitude:self.bin.latitude longitude:self.bin.longitude];
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.userCoordinate.latitude longitude:self.userCoordinate.longitude];
    CLLocationDistance meters = [binLocation distanceFromLocation:userLocation];
    
    CGFloat miles = meters / 1609.344;
    
    self.distance.text = [NSString stringWithFormat:@"%.2f miles away", miles];
    
    MapAnnotion *pin = [[MapAnnotion alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.bin.latitude, self.bin.longitude) andTitle:self.bin.short_name andSubtitle:self.bin.park_site_name andIndex:0];
    [_mapView addAnnotation:pin];
    [_mapView setMapType:MKMapTypeStandard];
    
    MKCoordinateRegion region = {{self.bin.latitude, self.bin.longitude}, {0.005, 0.005}};
    [_mapView setRegion:region animated:NO];
    [_mapView setAlpha:0.0];
    
    [UIView animateWithDuration:1.0 animations:^{
        [_mapView setAlpha:1.0];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openGoogleMaps:(id)sender
{
    NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?saddr=%0.6f,%0.6f&daddr=%0.6f,%0.6f", self.userCoordinate.latitude, self.userCoordinate.longitude, self.bin.latitude, self.bin.longitude];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else
    {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.bin.latitude, self.bin.longitude);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coord addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:self.bin.short_name];
        
        [mapItem openInMapsWithLaunchOptions:[NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsDirectionsModeKey, nil]];
    }
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
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    cell.categoryIcon.image = [Util getImageForCategoryName:[self.categoryList objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
