//
//  MapViewController.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "MapViewController.h"
#import "ListViewController.h"
#import "Util.h"
#import "TempBin.h"
#import "TempItem.h"
#import "MapAnnotion.h"

#define MAP_TUTORIAL @"map_tutorial"

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
    
    binList = [Util sharedInstance].bins;
    [self addAnnotationsForBins];
}

- (void)viewDidAppear:(BOOL)animated
{
    [locationManager startUpdatingLocation];
    
    //Proximity list not implemented for this iteration
    /*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:MAP_TUTORIAL])
    {
        [self showTutorial];
        [defaults setBool:YES forKey:MAP_TUTORIAL];
        [defaults synchronize];
    }
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showTutorial
{
    CGFloat height = self.view.frame.size.width / 2;
    CGRect frame = CGRectMake(0, self.view.frame.size.height - height, self.view.frame.size.width, height + 20);
        if(!help){
            help = [[HelpView alloc] initWithFrame:frame];
        }
        help.textLabel.text = @"Tap 'List' to view locations in list form sorted by proximity.";
        [self.view addSubview:help];
        
        [help animateViewEnter];
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

- (void) addAnnotationsForBins
{
    for(TempBin *bin in binList)
    {
        MapAnnotion *pin = [[MapAnnotion alloc] initWithCoordinate:CLLocationCoordinate2DMake(bin.latitude, bin.longitude) andTitle:bin.short_name andSubtitle:bin.park_site_name andIndex:[binList indexOfObject:bin]];
        
        [_mapView addAnnotation:pin];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
