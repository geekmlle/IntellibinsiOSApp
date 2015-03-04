//
//  TempBin.m
//  Intellibins
//
//  Created by Ben on 3/3/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "TempBin.h"

@implementation TempBin
@synthesize bin_type, short_name, borough, park_site_name, address, latitude, longitude, item_list;

- (id) initWithDictionary:(NSDictionary *)source
{
    NSLog(@"%@", source);
    if(self = [super init])
    {
        if(source)
        {
            self.bin_type = [source objectForKey:@"Bin Type"];
            self.short_name = [source objectForKey:@"Short Name"];
            self.borough = [source objectForKey:@"Borough"];
            self.park_site_name = [source objectForKey:@"Park/Site Name"];
            self.address = [source objectForKey:@"Address"];
            self.latitude = [[source objectForKey:@"Latitude"] floatValue];
            self.longitude = [[source objectForKey:@"Longitude"] floatValue];
            self.item_list = [source objectForKey:@"Item Type"];
        }
    }
    return self;
}

@end
