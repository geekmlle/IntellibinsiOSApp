//
//  MapViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "HelpView.h"
#import "GAITrackedViewController.h"

@interface MapViewController : GAITrackedViewController <MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet MKMapView *_mapView;
    IBOutlet UICollectionView *categoryCollectionView;
    IBOutlet UIButton *redoSearch;
    
    HelpView *help;
}

@property (nonatomic, retain) CLLocation *userLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D userCoordinate;
@property (nonatomic, retain) NSArray *binList;
@property (nonatomic, retain) NSMutableArray *categoryList;
@property (nonatomic, assign) NSInteger distanceFilter;

@end
