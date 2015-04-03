//
//  MapAnnotationView.h
//  Intellibins
//
//  Created by Ben on 3/4/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapAnnotationView : MKAnnotationView

@property (nonatomic, retain) UIView *whiteBackground;
@property (nonatomic, retain) UIView *colorBackground;

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                  reuseIdentifier:(NSString *)reuseIdentifier
                         andFrame:(CGRect)_frame;

@end
