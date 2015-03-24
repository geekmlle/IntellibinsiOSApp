//
//  TempItem.m
//  Intellibins
//
//  Created by Ben on 25/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "TempItem.h"

@implementation TempItem
@synthesize item_name, item_type, is_toggled;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    [encoder encodeObject:item_name forKey:@"item_name"];
    [encoder encodeObject:item_type forKey:@"item_type"];
    [encoder encodeObject:[NSNumber numberWithBool:is_toggled] forKey:@"is_toggled"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        self.item_name = [decoder decodeObjectForKey:@"item_name"];
        self.item_type = [decoder decodeObjectForKey:@"item_type"];
        self.is_toggled = [[decoder decodeObjectForKey:@"is_toggled"] boolValue];
    }
    return self;
}

@end
