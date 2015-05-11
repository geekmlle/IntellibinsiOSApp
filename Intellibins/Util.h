//
//  Util.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CoreDataManager.h"

@interface Util : NSObject

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) NSArray *bins;
@property (nonatomic, assign) BOOL reloadMap;

+ (Util *) sharedInstance;
+ (void) loadCategories;
+ (void) saveCategories;
+ (void) loadTempBins;

+ (void ) loadBinsFromCoreData;

+ (NSString *) NSStringConsistencyCheck:(NSString *)string;
+ (CGFloat) CGFloatConsistencyCheck:(id)number;
+ (UIImage *)getImageForCategoryName:(NSString *)category;
+ (UIColor *)getColorForCategoryName:(NSString *)category;

@end
