//
//  MapAnnotion.h
//  Intellibins
//
//  Created by Ben on 3/3/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotion : NSObject <MKAnnotation>

-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)_title andSubtitle:(NSString *)_subtitle andIndex:(NSInteger)index;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *item_type;
@property (nonatomic, retain) UIView *colorView;

@end
