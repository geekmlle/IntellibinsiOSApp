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
#import "UIColor+IntellibinsColor.h"

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

        TempItem *plasticBottle = [[TempItem alloc] init];
        plasticBottle.item_name = @"Plastic Bottle";
        plasticBottle.item_type = @"plasticBottle";
        plasticBottle.is_toggled = YES;
        
        TempItem *plasticBag = [[TempItem alloc] init];
        plasticBag.item_name = @"Plastic Bag";
        plasticBag.item_type = @"PlasticBag";
        plasticBag.is_toggled = YES;
        
        TempItem *newspaper = [[TempItem alloc] init];
        newspaper.item_name = @"Newspaper";
        newspaper.item_type = @"newspaper";
        newspaper.is_toggled = YES;
        
        TempItem *glassBottle = [[TempItem alloc] init];
        glassBottle.item_name = @"Glass Bottle";
        glassBottle.item_type = @"glassBottle";
        glassBottle.is_toggled = YES;
        
        TempItem *clothes = [[TempItem alloc] init];
        clothes.item_name = @"Clothes";
        clothes.item_type = @"clothes";
        clothes.is_toggled = YES;
        
        TempItem *aluminumCan = [[TempItem alloc] init];
        aluminumCan.item_name = @"Aluminum Can";
        aluminumCan.item_type = @"aluminumCan";
        aluminumCan.is_toggled = YES;
        
        TempItem *bubbleWrap = [[TempItem alloc] init];
        bubbleWrap.item_name = @"Bubble Wrap";
        bubbleWrap.item_type = @"bubbleWrap";
        bubbleWrap.is_toggled = YES;
        
        TempItem *electronics = [[TempItem alloc] init];
        electronics.item_name = @"Electronics";
        electronics.item_type = @"electronics";
        electronics.is_toggled = YES;
        
        
        
        /*
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
        
        TempItem *glass = [[TempItem alloc] ini sqt];
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
         
         */
        
        [Util sharedInstance].categories = [[NSArray alloc] initWithObjects:plasticBottle, plasticBag, newspaper, glassBottle, clothes, aluminumCan, bubbleWrap, electronics, nil];
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
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"binData" ofType:@"json"];
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
    NSRange range = [category rangeOfString:@"plasticBottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticBottle"];
    
    range = [category rangeOfString:@"plasticBag" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticBag"];
    
    range = [category rangeOfString:@"Newspaper" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"newspaper"];
    
    range = [category rangeOfString:@"glassBottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"glassBottle"];
    
    range = [category rangeOfString:@"clothes" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"clothes"];
    
    range = [category rangeOfString:@"aluminumCan" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"aluminumCan"];
    
    range = [category rangeOfString:@"bubbleWrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"bubbleWrap"];
    
    range = [category rangeOfString:@"Electronics" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
    return [UIImage imageNamed:@"electronics"];
    
    return [UIImage imageNamed:@"Other"];
    
}

+ (UIColor *)getColorForCategoryName:(NSString *)category
{
    NSRange range = [category rangeOfString:@"plasticBottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsRed];
    
    range = [category rangeOfString:@"electronic" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsGray];
    
    range = [category rangeOfString:@"aluminumCan" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsYellow];
    
    range = [category rangeOfString:@"glassBottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsBlue];
    
    range = [category rangeOfString:@"clothes" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLightRed];
    
    range = [category rangeOfString:@"paper" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsOrange];
    
    range = [category rangeOfString:@"bubbleWrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsPurple];
    
    range = [category rangeOfString:@"plasticBag" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLightGreen];
    
    return [UIColor whiteColor];
}

@end
