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
#import "BinDetailViewController.h"
#import "CategoryCollectionViewCell.h"

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
    
    //Distance Filter is the amount of miles to restrict search of bins
    self.distanceFilter = 1;
    
    self.binList = [Util sharedInstance].bins;
    self.categoryList = [[NSMutableArray alloc] init];
    
    self.title = @"Bins";
    
    [locationManager startUpdatingLocation];
    [self addAnnotationsForBinsNearCoordinate:CLLocationCoordinate2DMake(40.765592, -73.979506)];
    
    [categoryCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
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

- (void)viewWillAppear:(BOOL)animated
{
    [self.categoryList removeAllObjects];
    //Refresh selected categories
    for(TempItem *item in [Util sharedInstance].categories)
    {
        if(item.is_toggled)
        {
            [self.categoryList addObject:item];
        }
    }
    [categoryCollectionView reloadData];
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

// MKMapViewDelegate Methods
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    // Check authorization status
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    NSString *title;
    title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
    NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
    
    // User has never been asked to decide on location authorization
    if (status == kCLAuthorizationStatusNotDetermined && [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"Requesting when in use auth");
        [locationManager requestWhenInUseAuthorization];
    }
    // User has denied location use (either for this app or for all apps
    else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Location services denied");
        // Alert the user and send them to the settings to turn on location
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    userLocation = newLocation;
    userCoordinate = newLocation.coordinate;
    
    [manager stopUpdatingLocation];
    
    //Creating region for mapview
    MKCoordinateRegion region = {{userCoordinate.latitude, userCoordinate.longitude}, {0.02, 0.02}};
    [_mapView setRegion:region animated:YES];
    
    CLLocationCoordinate2D binCoord = CLLocationCoordinate2DMake(40.765592, -73.979506);
    //binCoord = userCoordinate;
    
    [self addAnnotationsForBinsNearCoordinate:binCoord];
}

- (void) addAnnotationsForBinsNearCoordinate:(CLLocationCoordinate2D)coordinate
{
    [_mapView removeAnnotations:_mapView.annotations];
    
    MKMapPoint point = MKMapPointForCoordinate(coordinate);
    double milesInPoints = MKMapPointsPerMeterAtLatitude(coordinate.latitude) * 1600 * self.distanceFilter;
    MKMapRect rect = MKMapRectMake(point.x - milesInPoints / 2, point.y - milesInPoints / 2, milesInPoints, milesInPoints);
    
    [_mapView setRegion:MKCoordinateRegionForMapRect(rect) animated:YES];
    
    for(TempBin *bin in self.binList)
    {
        MKMapPoint p = MKMapPointForCoordinate(CLLocationCoordinate2DMake(bin.latitude, bin.longitude));
        if(MKMapRectContainsPoint(rect, p))
        {
            MapAnnotion *pin = [[MapAnnotion alloc] initWithCoordinate:CLLocationCoordinate2DMake(bin.latitude, bin.longitude) andTitle:bin.short_name andSubtitle:bin.park_site_name andIndex:[self.binList indexOfObject:bin]];
            [_mapView addAnnotation:pin];
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        //TempBin *bin = self.binList objectAtIndex:annotation.
        
        static NSString *defaultPinID = @"IntellibinPin";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        CGRect frame = CGRectMake(0, 0, 20, 20);
        
        //UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, frame.size.width - 6, frame.size.height - 6)];
        //colorView.backgroundColor = [Util getColorForCategoryName:<#(NSString *)#>];
        
        pinView.canShowCallout = YES;
        pinView.frame = frame;
        pinView.backgroundColor = [UIColor whiteColor];
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    else {
        [mapView.userLocation setTitle:@"You are here"];
    }
    return pinView;
}

/*
//Temporary method until custom pin images are provided
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"MyLocation";
    if (annotation != mapView.userLocation) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    
    return nil;
}
 */

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MapAnnotion *annotation = view.annotation;
    TempBin *bin = [self.binList objectAtIndex:annotation.index];
    
    BinDetailViewController *detail = [[BinDetailViewController alloc] init];
    detail.bin = bin;
    detail.userCoordinate = userCoordinate;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categoryList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    TempItem *category = [self.categoryList objectAtIndex:indexPath.row];
    cell.categoryIcon.image = [Util getImageForCategoryName:category.item_type];
    cell.backgroundColor = [Util getColorForCategoryName:category.item_type];
    
    return cell;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

@end
