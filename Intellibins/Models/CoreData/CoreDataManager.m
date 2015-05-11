//
//  CoreDataManager.m
//  Intellibins
//
//  Created by rachel wu on 5/11/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (id)sharedInstance
{
    static CoreDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
    
}

- (id) init
{
    if (self = [super init]) {
        
        self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        self.binEntity = [NSEntityDescription entityForName:@"Bin" inManagedObjectContext:self.managedObjectContext];
        self.itemEntity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
        
        
    }
    return self;
}


- (void)insertBinWithData:(id)params
{
    Bin *bin = [[Bin alloc] initWithEntity:self.binEntity insertIntoManagedObjectContext:self.managedObjectContext];
    
    if ([params objectForKey:@"Short Name"]) {
        [bin setShortName:[params objectForKey:@"Short Name"]];
    }
    if ([params objectForKey:@"Borough"]) {
        [bin setBorough:[params objectForKey:@"Borough"]];
    }
    if ([params objectForKey:@"Park/Site Name"]) {
        [bin setParkSiteName:[params objectForKey:@"Park/Site Name"]];
    }
    if ([params objectForKey:@"Latitude"] != [NSNull null]) {
        [bin setLatitude:[params objectForKey:@"Latitude"]];
    }
    if ([params objectForKey:@"Longitude"] != [NSNull null]) {
        [bin setLongitude:[params objectForKey:@"Longitude"]];
    }
    if ([params objectForKey:@"Material Type"]) {
         [bin setMaterialType:[params objectForKey:@"Material Type"]];
    }

    
}


- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        
        @try {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Unresolved exception %@", error.description);
        }
        
    }
}


@end
