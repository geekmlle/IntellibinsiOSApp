//
//  Util.m
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import "Util.h"
#import "TempItem.h"

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
    
    TempItem *plastic = [[TempItem alloc] init];
    paper.item_name = @"Plastic";
    paper.item_type = @"plastic";
    
    TempItem *metal = [[TempItem alloc] init];
    paper.item_name = @"Metal";
    paper.item_type = @"metal";
    
    TempItem *glass = [[TempItem alloc] init];
    paper.item_name = @"Glass";
    paper.item_type = @"glass";
    
    TempItem *hazard = [[TempItem alloc] init];
    paper.item_name = @"Hazard";
    paper.item_type = @"hazard";
    
    [Util sharedInstance].categories = [[NSArray alloc] initWithObjects:paper, plastic, metal, glass, hazard, nil];
}

@end
