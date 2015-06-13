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
#import "MapAnnotationView.h"
#import "UIColor+IntellibinsColor.h"

#define MAP_TUTORIAL @"map_tutorial"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize locationManager = _locationManager;

static BOOL mapChangedFromUserInteraction = NO;

- (CLLocationManager *)locationManager
{
    if(_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 1000;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    //Distance Filter is the amount of miles to restrict search of bins
    self.distanceFilter = 1;
    
    self.binList = [Util sharedInstance].bins;
    self.categoryList = [[NSMutableArray alloc] init];
    
    
    [self.locationManager startUpdatingLocation];
    [self addAnnotationsForBinsNearCoordinate:CLLocationCoordinate2DMake(40.765592, -73.979506)];
    
    [categoryCollectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCell"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    NSLog(@"%f, %f", self.userCoordinate.latitude, self.userCoordinate.longitude);
    [super viewWillAppear:animated];
    [self refreshCategoryAndAnnotation];
    
    //not show Navigation Bar (such as Filter) before showing Policy
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults boolForKey:TUTORIALHELP_KEY]){
        [self setUpNavigationBarStyle];
    }

    
}

- (void)setUpNavigationBarStyle
{
    UIBarButtonItem *filter = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(openFilterList:)];
    [filter setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Lato-Regular" size:17.], NSForegroundColorAttributeName: [UIColor kIntellibinsGreen]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = filter;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.title = @"Bins";

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshCategoryAndAnnotation
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
    
    if([Util sharedInstance].reloadMap)
    {
        [Util sharedInstance].reloadMap = NO;
        CLLocationCoordinate2D center = [_mapView centerCoordinate];
        [self addAnnotationsForBinsNearCoordinate:center];
    }
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
    nvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    listVC.onCompletion = ^(BOOL reload) {
        if(reload)
        {
            [self refreshCategoryAndAnnotation];
        }
    };
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
    if (status == kCLAuthorizationStatusNotDetermined && [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"Requesting when in use auth");
        [self.locationManager requestWhenInUseAuthorization];
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
    self.userLocation = newLocation;
    self.userCoordinate = newLocation.coordinate;
    
    //Random location near Central Park for testing...
    //self.userCoordinate = CLLocationCoordinate2DMake(40.765592, -73.979506);
    
    [manager stopUpdatingLocation];
    
    //Creating region for mapview
    MKCoordinateRegion region = {{self.userCoordinate.latitude, self.userCoordinate.longitude}, {0.02, 0.02}};
    [_mapView setRegion:region animated:YES];
    
    [self addAnnotationsForBinsNearCoordinate:self.userCoordinate];
}

- (void) addAnnotationsForBinsNearCoordinate:(CLLocationCoordinate2D)coordinate
{
    //Removing old annotations first, so we don't re-add them
    [_mapView removeAnnotations:_mapView.annotations];
    
    //Get the rect in mapview where the coordinate is the center and has a radius of 1 mile (1600 meters)
    MKMapPoint point = MKMapPointForCoordinate(coordinate);
    double milesInPoints = MKMapPointsPerMeterAtLatitude(coordinate.latitude) * 1600 * self.distanceFilter;
    MKMapRect rect = MKMapRectMake(point.x - milesInPoints / 2, point.y - milesInPoints / 2, milesInPoints, milesInPoints);
    
    //We set the visible region to the map
    [_mapView setRegion:MKCoordinateRegionForMapRect(rect) animated:YES];
    
    for(TempBin *bin in self.binList)
    {
        //Adding bins which are located whithin the maprect area, AND are within the chosen categories
        MKMapPoint p = MKMapPointForCoordinate(CLLocationCoordinate2DMake(bin.latitude, bin.longitude));
        NSArray *itemList = [bin.item_list componentsSeparatedByString:@","];
        if(MKMapRectContainsPoint(rect, p) && [self binIsIncludedInCategories:itemList])
        {
            MapAnnotion *pin = [[MapAnnotion alloc] initWithCoordinate:CLLocationCoordinate2DMake(bin.latitude, bin.longitude) andTitle:bin.short_name andSubtitle:bin.park_site_name andIndex:[self.binList indexOfObject:bin]];
            //Iterating through the accepted materials on the list, and the method inside matches the first toggled category who is included in the acceptable mats of the bin
            pin.item_type = [self filterCategoryListForItem:[bin.item_list componentsSeparatedByString:@","]];
            [_mapView addAnnotation:pin];
        }
    }
}

- (void) addAnnotationsForBinsNearMapRect:(MKMapRect)mapRect
{
    //Removing old annotations first, so we don't re-add them
    [_mapView removeAnnotations:_mapView.annotations];
    
    for(TempBin *bin in self.binList)
    {
        //Adding bins which are located whithin the maprect area, AND are within the chosen categories
        MKMapPoint p = MKMapPointForCoordinate(CLLocationCoordinate2DMake(bin.latitude, bin.longitude));
        NSArray *itemList = [bin.item_list componentsSeparatedByString:@","];
        if(MKMapRectContainsPoint(mapRect, p) && [self binIsIncludedInCategories:itemList])
        {
            MapAnnotion *pin = [[MapAnnotion alloc] initWithCoordinate:CLLocationCoordinate2DMake(bin.latitude, bin.longitude) andTitle:bin.short_name andSubtitle:bin.park_site_name andIndex:[self.binList indexOfObject:bin]];
            //Iterating through the accepted materials on the list, and the method inside matches the first toggled category who is included in the acceptable mats of the bin
            pin.item_type = [self filterCategoryListForItem:[bin.item_list componentsSeparatedByString:@","]];
            [_mapView addAnnotation:pin];
        }
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MapAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        
        //TempBin *bin = self.binList objectAtIndex:annotation.
        
        static NSString *defaultPinID = @"IntellibinPin";
        pinView = (MapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
        {
            pinView = [[MapAnnotationView alloc] initWithAnnotation:annotation
                                                    reuseIdentifier:defaultPinID
                                                           andFrame:CGRectMake(0, 0, 20, 20)];
            pinView.canShowCallout = YES;
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        else
        {
            pinView.annotation = annotation;
        }
        
        if([annotation isKindOfClass:[MapAnnotion class]])
        {
            MapAnnotion *mapA = (MapAnnotion *)annotation;
            pinView.colorBackground.backgroundColor = [Util getColorForCategoryName:mapA.item_type];
        }
    }
    else {
        [mapView.userLocation setTitle:@"You are here"];
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MapAnnotationView *aV;
    for (aV in views) {
        
        // Check if current annotation is inside visible map rect, else go to next one or if annotation is user location
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(mapView.visibleMapRect, point) || [aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    [UIView animateWithDuration:0.1 animations:^{
                        aV.transform = CGAffineTransformIdentity;
                    }];
                }];
            }
        }];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MapAnnotion *annotation = view.annotation;
    TempBin *bin = [self.binList objectAtIndex:annotation.index];
    
    BinDetailViewController *detail = [[BinDetailViewController alloc] init];
    detail.bin = bin;
    detail.userCoordinate = self.userCoordinate;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    mapChangedFromUserInteraction = [self mapViewRegionDidChangeFromUserInteraction];
    
    if(redoSearch.isHidden && mapChangedFromUserInteraction)
    {
        [self animateSearchButtonHide:NO];
    }
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

- (BOOL) binIsIncludedInCategories:(NSArray *)binItems
{
    BOOL answer = NO;
    for(TempItem *item in self.categoryList)
    {
        NSArray *temp = [NSArray arrayWithArray:binItems];
        NSString *search = item.item_type;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", search];
        NSArray *results = [temp filteredArrayUsingPredicate:predicate];
        
        
        if([results count] > 0) {
            answer = YES;
            break;
        }
    }
    return answer;
}

-(NSString *)filterCategoryListForItem:(NSArray *)itemTypes
{
    for(TempItem *item in self.categoryList)
    {
        NSArray *temp = [NSArray arrayWithArray:itemTypes];
        NSString *search = item.item_type;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", search];
        NSArray *results = [temp filteredArrayUsingPredicate:predicate];
        
        if([results count] > 0)
            return [results firstObject];
    }
    
    return nil;
}

- (IBAction)redoSearchClicked:(id)sender
{
    [self animateSearchButtonHide:YES];
    [self addAnnotationsForBinsNearMapRect:_mapView.visibleMapRect];
}

- (BOOL)mapViewRegionDidChangeFromUserInteraction
{
    UIView *view = _mapView.subviews.firstObject;
    //  Look through gesture recognizers to determine whether this region change is from user interaction
    for(UIGestureRecognizer *recognizer in view.gestureRecognizers) {
        if(recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateEnded) {
            return YES;
        }
    }
    
    return NO;
}

- (void) animateSearchButtonHide:(BOOL)hide
{
    if(hide)
    {
        redoSearch.alpha = 1.0;
        [UIView animateWithDuration:1.0 animations:^{
            redoSearch.alpha = 0.0;
        } completion:^(BOOL finished){
            redoSearch.hidden = YES;
        }];
    }
    else
    {
        redoSearch.alpha = 0.0;
        redoSearch.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{
            redoSearch.alpha = 1.0;
        } completion:^(BOOL finished){
            
        }];
    }
}
@end
