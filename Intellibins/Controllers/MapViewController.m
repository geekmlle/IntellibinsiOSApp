//
//  MapViewController.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "MapViewController.h"
#import "ListViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *filter = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(openFilterList:)];
    self.navigationItem.leftBarButtonItem = filter;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = 1000;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    [locationManager requestWhenInUseAuthorization];
}

- (void)viewDidAppear:(BOOL)animated
{
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openFilterList:(id)sender
{
    ListViewController *listVC = [[ListViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:listVC];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    userLocation = newLocation;
    userCoordinate = newLocation.coordinate;
    
    [locationManager stopUpdatingLocation];
    //Creating region for mapview
    MKCoordinateRegion region = {{userCoordinate.latitude, userCoordinate.longitude}, {0.02, 0.02}};
    [_mapView setRegion:region animated:YES];
}

@end
