//
//  MapAnnotion.m
//  Intellibins
//
//  Created by Ben on 3/3/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "MapAnnotion.h"

@implementation MapAnnotion
@synthesize coordinate, subtitle, title, index, item_type;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)_title andSubtitle:(NSString *)_subtitle andIndex:(NSInteger)_index
{
    if(self = [super init])
    {
        self.coordinate = c;
        self.title = _title;
        self.subtitle = _subtitle;
        self.index = _index;
    }
    
    return self;
}

@end
