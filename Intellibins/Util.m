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

#define CATEGORY_KEY @"iCategories"

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:CATEGORY_KEY])
    {
        NSData *myDecodedObject = [defaults objectForKey:CATEGORY_KEY];
        NSArray *decodedArray =[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
        [[Util sharedInstance] setCategories:[NSMutableArray arrayWithArray:decodedArray]];
    }
    else
    {
        
        TempItem *paper = [[TempItem alloc] init];
        paper.item_name = @"Paper";
        paper.item_type = @"paper";
        paper.is_toggled = YES;
        
        TempItem *plastic = [[TempItem alloc] init];
        plastic.item_name = @"Plastic";
        plastic.item_type = @"plastic";
        plastic.is_toggled = YES;
        
        TempItem *metal = [[TempItem alloc] init];
        metal.item_name = @"Aluminum";
        metal.item_type = @"aluminum";
        metal.is_toggled = YES;
        
        TempItem *glass = [[TempItem alloc] init];
        glass.item_name = @"Glass";
        glass.item_type = @"glass";
        glass.is_toggled = YES;
        
        TempItem *hazard = [[TempItem alloc] init];
        hazard.item_name = @"Hazard";
        hazard.item_type = @"hazard";
        hazard.is_toggled = YES;
        
        TempItem *other = [[TempItem alloc] init];
        other.item_name = @"Other";
        other.item_type = @"other";
        other.is_toggled = YES;
        
        [Util sharedInstance].categories = [[NSArray alloc] initWithObjects:paper, plastic, metal, glass, hazard, other, nil];
        [Util saveCategories];
    }
}

+ (void) saveCategories
{
    if(![Util sharedInstance].categories)
    {
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:[Util sharedInstance].categories];
    [defaults setObject:myEncodedObject forKey:CATEGORY_KEY];
    [defaults synchronize];
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

+ (void ) loadBinsFromCoreData
{
    NSError *error = nil;
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bin_data" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filepath options:NSDataReadingMappedIfSafe error:&error];
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"Error parsing json, %@", error);
    }else {
        NSArray *bins = (NSArray *)object;
        for (NSDictionary *dic in bins) {
            [[CoreDataManager sharedInstance] insertBinWithData:dic];
        }
        [[CoreDataManager sharedInstance] saveContext];
    }
}

+ (NSString *) NSStringConsistencyCheck:(NSString *)string
{
    return (string && ![string isKindOfClass:[NSNull class]]) ? string : @"";
}

+ (CGFloat) CGFloatConsistencyCheck:(id)number
{
    return ([number isKindOfClass:[NSNull class]]) ? 0 : [number floatValue];
}

+(UIImage *)getImageForCategoryName:(NSString *)category
{
    NSRange range = [category rangeOfString:@"paper" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"paper"];
    
    range = [category rangeOfString:@"plastic" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plastic"];
    
    range = [category rangeOfString:@"aluminum" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"metal"];
    
    range = [category rangeOfString:@"glass" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"glass"];
    
    range = [category rangeOfString:@"hazard" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"hazard"];
    
    return [UIImage imageNamed:@"other"];
}

+ (UIColor *)getColorForCategoryName:(NSString *)category
{
    NSRange range = [category rangeOfString:@"paper" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor lightGrayColor];
    
    range = [category rangeOfString:@"plastic" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor colorWithRed:0.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    range = [category rangeOfString:@"aluminum" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor darkGrayColor];
    
    range = [category rangeOfString:@"glass" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor orangeColor];
    
    range = [category rangeOfString:@"hazard" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor greenColor];
    
    return [UIColor redColor];
}

@end
