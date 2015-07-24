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
        plasticBottle.item_type = @"Plastic Bottle";
        plasticBottle.is_toggled = NO;
        
        TempItem *plasticBag = [[TempItem alloc] init];
        plasticBag.item_name = @"Plastic Bag";
        plasticBag.item_type = @"Plastic Bag";
        plasticBag.is_toggled = NO;
        
        TempItem *newspaper = [[TempItem alloc] init];
        newspaper.item_name = @"Newspaper";
        newspaper.item_type = @"Newspaper";
        newspaper.is_toggled = NO;
        
        TempItem *glassBottle = [[TempItem alloc] init];
        glassBottle.item_name = @"Glass Bottle";
        glassBottle.item_type = @"Glass Bottle";
        glassBottle.is_toggled = NO;
        
        TempItem *clothes = [[TempItem alloc] init];
        clothes.item_name = @"Clothes";
        clothes.item_type = @"Clothes";
        clothes.is_toggled = NO;
        
        TempItem *aluminumCan = [[TempItem alloc] init];
        aluminumCan.item_name = @"Aluminum Can";
        aluminumCan.item_type = @"Aluminum Can";
        aluminumCan.is_toggled = NO;
        
        TempItem *bubbleWrap = [[TempItem alloc] init];
        bubbleWrap.item_name = @"Bubble Wrap";
        bubbleWrap.item_type = @"Bubble Wrap";
        bubbleWrap.is_toggled = NO;
        
        TempItem *electronics = [[TempItem alloc] init];
        electronics.item_name = @"Electronics";
        electronics.item_type = @"Electronics";
        electronics.is_toggled = NO;
        
        
        TempItem *aluminumBottle = [[TempItem alloc] init];
        aluminumBottle.item_name = @"Aluminum Bottle";
        aluminumBottle.item_type = @"Aluminum Bottle";
        aluminumBottle.is_toggled = NO;
        
        TempItem *aluminumWrap = [[TempItem alloc] init];
        aluminumWrap.item_name = @"Aluminum Wrap";
        aluminumWrap.item_type = @"Aluminum Wrap";
        aluminumWrap.is_toggled = NO;
        
        TempItem *glassContainer = [[TempItem alloc] init];
        glassContainer.item_name = @"Glass Container";
        glassContainer.item_type = @"Glass Container";
        glassContainer.is_toggled = NO;
        
        TempItem *paperCardboard = [[TempItem alloc] init];
        paperCardboard.item_name = @"Paper Cardboard";
        paperCardboard.item_type = @"Paper Cardboard";
        paperCardboard.is_toggled = NO;
        
        TempItem *paperContainer = [[TempItem alloc] init];
        paperContainer.item_name = @"Paper Container";
        paperContainer.item_type = @"Paper Container";
        paperContainer.is_toggled = NO;
        
        TempItem *paperLid = [[TempItem alloc] init];
        paperLid.item_name = @"Paper Lid";
        paperLid.item_type = @"Paper Lid";
        paperLid.is_toggled = NO;
        
        TempItem *paperMagazine = [[TempItem alloc] init];
        paperMagazine.item_name = @"Paper Magazine";
        paperMagazine.item_type = @"Paper Magazine";
        paperMagazine.is_toggled = NO;
        
        TempItem *paperSheet = [[TempItem alloc] init];
        paperSheet.item_name = @"Paper Sheet";
        paperSheet.item_type = @"Paper Sheet";
        paperSheet.is_toggled = NO;
        
        TempItem *plasticContainer = [[TempItem alloc] init];
        plasticContainer.item_name = @"Plastic Container";
        plasticContainer.item_type = @"Plastic Container";
        plasticContainer.is_toggled = NO;
        
        TempItem *plasticCup = [[TempItem alloc] init];
        plasticCup.item_name = @"Plastic Cup";
        plasticCup.item_type = @"Plastic Cup";
        plasticCup.is_toggled = NO;
        
        TempItem *plasticLid = [[TempItem alloc] init];
        plasticLid.item_name = @"Plastic Lid";
        plasticLid.item_type = @"Plastic Lid";
        plasticLid.is_toggled = NO;
        
        TempItem *plasticUtensils = [[TempItem alloc] init];
        plasticUtensils.item_name = @"Plastic Utensils";
        plasticUtensils.item_type = @"Plastic Utensils";
        plasticUtensils.is_toggled = NO;
        
        TempItem *plasticWrap = [[TempItem alloc] init];
        plasticWrap.item_name = @"Plastic Wrap";
        plasticWrap.item_type = @"Plastic Wrap";
        plasticWrap.is_toggled = NO;
        
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
        
        [Util sharedInstance].categories = [[NSArray alloc] initWithObjects:plasticBottle, plasticBag, newspaper, glassBottle, clothes, aluminumCan, bubbleWrap, electronics, aluminumBottle, aluminumWrap, glassContainer, paperCardboard, paperContainer, paperLid, paperMagazine, paperSheet, plasticContainer, plasticCup, plasticLid, plasticUtensils, plasticWrap,  nil];
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
    NSRange range = [category rangeOfString:@"Plastic Bottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticBottle"];
    
    range = [category rangeOfString:@"Plastic Bag" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticBag"];
    
    range = [category rangeOfString:@"Newspaper" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"newspaper"];
    
    range = [category rangeOfString:@"Glass Bottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"glassBottle"];
    
    range = [category rangeOfString:@"Clothes" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"clothes"];
    
    range = [category rangeOfString:@"Aluminum Can" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"aluminumCan"];
    
    range = [category rangeOfString:@"Bubble Wrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"bubbleWrap"];
    
    range = [category rangeOfString:@"Electronics" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
    return [UIImage imageNamed:@"electronics"];

    range = [category rangeOfString:@"Aluminum Bottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"aluminumBottle"];
    
    range = [category rangeOfString:@"Aluminum Wrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"aluminumWrap"];
    
    range = [category rangeOfString:@"Glass Container" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"glassContainer"];
    
    range = [category rangeOfString:@"Paper Cardboard" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"paperCardboard"];
    
    range = [category rangeOfString:@"Paper Container" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"paperContainer"];
    
    range = [category rangeOfString:@"Paper Lid" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"paperLid"];
    
    range = [category rangeOfString:@"Paper Magazine" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"paperMagazine"];
    
    range = [category rangeOfString:@"Paper Sheet" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"paperSheet"];
    
    range = [category rangeOfString:@"Plastic Container" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticContainer"];
    
    range = [category rangeOfString:@"Plastic Cup" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticCup"];
    
    range = [category rangeOfString:@"Plastic Lid" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticLid"];
    
    range = [category rangeOfString:@"Plastic Utensils" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticUtensils"];
    
    range = [category rangeOfString:@"Plastic Wrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIImage imageNamed:@"plasticWrap"];
    
    //TODO: need new asset for Other types
    return [UIImage imageNamed:@"plasticWrap"];
    
}

+ (UIColor *)getColorForCategoryName:(NSString *)category
{
    NSRange range = [category rangeOfString:@"Plastic Bottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsRed];
    
    range = [category rangeOfString:@"Electronics" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsGray];
    
    range = [category rangeOfString:@"Aluminum Can" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsYellow];
    
    range = [category rangeOfString:@"Glass Bottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsBlue];
    
    range = [category rangeOfString:@"Clothes" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLightRed];
    
    range = [category rangeOfString:@"Newspaper" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsOrange];
    
    range = [category rangeOfString:@"Bubble Wrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsPurple];
    
    range = [category rangeOfString:@"Plastic Bag" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLightGreen];
    
    range = [category rangeOfString:@"Aluminum Bottle" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsPink];
    
    range = [category rangeOfString:@"Aluminum Wrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLime];
    
    range = [category rangeOfString:@"Glass Container" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsCyan];
    
    range = [category rangeOfString:@"Paper Cardboard" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsIndigo];
    
    range = [category rangeOfString:@"Paper Container" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsDeepYellow];
    
    range = [category rangeOfString:@"Paper Lid" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsTeal];
    
    range = [category rangeOfString:@"Paper Magazine" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsDarkGreen];
    
    range = [category rangeOfString:@"Paper Sheet" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsDeepOrange];
    
    range = [category rangeOfString:@"Plastic Container" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLightBlue];
    
    range = [category rangeOfString:@"Plastic Cup" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsLightGray];
    
    range = [category rangeOfString:@"Plastic Lid" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsVeryLightGreen];
    
    range = [category rangeOfString:@"Plastic Utensils" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsBrown];
    
    range = [category rangeOfString:@"Plastic Wrap" options:NSCaseInsensitiveSearch];
    if(range.location != NSNotFound)
        return [UIColor kIntellibinsAmber];
    
    return [UIColor kIntellibinsDefaultColor];
}


@end
