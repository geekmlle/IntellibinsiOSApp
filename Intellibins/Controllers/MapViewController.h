//
//  MapViewController.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    IBOutlet MKMapView *_mapView;
    
    CLLocation *userLocation;
    CLLocationCoordinate2D userCoordinate;
    CLLocationManager *locationManager;
}

@end
