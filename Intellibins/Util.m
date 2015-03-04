//
//  Util.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "Util.h"
#import "TempItem.h"
#import "TempBin.h"


@implementation Util

+ (Util *) sharedInstance
{
    static Util *instance = nil;
    if(instance == nil)
    {
        instance = [[Util alloc] init];
        
    }
    return instance;
}

+ (void) loadCategories
{
    //TODO: Retrieve data from internal data
    //NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    TempItem *paper = [[TempItem alloc] init];
    paper.item_name = @"Paper";
    paper.item_type = @"paper";
    paper.is_toggled = NO;
    
    TempItem *plastic = [[TempItem alloc] init];
    plastic.item_name = @"Plastic";
    plastic.item_type = @"plastic";
    plastic.is_toggled = NO;
    
    TempItem *metal = [[TempItem alloc] init];
    metal.item_name = @"Metal";
    metal.item_type = @"metal";
    metal.is_toggled = NO;
    
    TempItem *glass = [[TempItem alloc] init];
    glass.item_name = @"Glass";
    glass.item_type = @"glass";
    glass.is_toggled = NO;
    
    TempItem *hazard = [[TempItem alloc] init];
    hazard.item_name = @"Hazard";
    hazard.item_type = @"hazard";
    hazard.is_toggled = NO;
    
    [Util sharedInstance].categories = [[NSArray alloc] initWithObjects:paper, plastic, metal, glass, hazard, nil];
}

+ (void) loadTempBins
{
    NSError *error = nil;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bin_data" ofType:@"txt"];
    NSData *returnedData = [NSData dataWithContentsOfFile:filepath options:NSDataReadingMappedIfSafe error:&error];
    //NSString *returnedString = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    id object = [NSJSONSerialization
                 JSONObjectWithData:returnedData
                 options:NSJSONReadingAllowFragments
                 error:&error];
    
    if(!error)
    {
        NSArray *bins = (NSArray *)object;
        NSMutableArray *final = [[NSMutableArray alloc] init];
        for(NSDictionary *dict in bins)
        {
            TempBin *bin = [[TempBin alloc] initWithDictionary:dict];
            [final addObject:bin];
        }
        
        [Util sharedInstance].bins = final;
    }
    else
    {
        NSLog(@"Error parsing json - %@", error.localizedDescription);
    }
    
}

@end
