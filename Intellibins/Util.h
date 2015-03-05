//
//  Util.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@interface Util : NSObject

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) NSArray *bins;

+ (Util *) sharedInstance;
+ (void) loadCategories;
+ (void) loadTempBins;

+ (NSString *) NSStringConsistencyCheck:(NSString *)string;
+ (CGFloat) CGFloatConsistencyCheck:(id)number;
@end
