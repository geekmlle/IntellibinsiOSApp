//
//  Util.h
//  Intellibins
//
//  Created by Ben on 20/2/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

@property (nonatomic, retain) NSArray *categories;

+ (Util *) sharedInstance;
+ (void) loadCategories;

@end
