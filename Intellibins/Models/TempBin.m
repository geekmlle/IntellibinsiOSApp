//
//  TempBin.m
//  Intellibins
//
//  Created by Ben on 3/3/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "TempBin.h"
#import "Util.h"

@implementation TempBin
@synthesize bin_type, short_name, borough, park_site_name, address, latitude, longitude, item_list;

- (id) initWithDictionary:(NSDictionary *)source
{
    if(self = [super init])
    {
        if(source)
        {
            self.bin_type = [Util NSStringConsistencyCheck:[source objectForKey:@"Bin Type"]];
            self.short_name = [Util NSStringConsistencyCheck:[source objectForKey:@"Short Name"]];
            self.borough = [Util NSStringConsistencyCheck:[source objectForKey:@"Borough"]];
            self.park_site_name = [Util NSStringConsistencyCheck:[source objectForKey:@"Park/Site Name"]];
            self.address = [Util NSStringConsistencyCheck:[source objectForKey:@"Address"]];
            self.latitude = [Util CGFloatConsistencyCheck:[source objectForKey:@"Latitude"]];
            self.longitude = [Util CGFloatConsistencyCheck:[source objectForKey:@"Longitude"]];
            self.item_list = [Util NSStringConsistencyCheck:[source objectForKey:@"Item Type"]];
        }
    }
    return self;
}

@end
