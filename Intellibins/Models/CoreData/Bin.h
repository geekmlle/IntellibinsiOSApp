//
//  Bin.h
//  Intellibins
//
//  Created by rachel wu on 5/10/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Bin : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * binType;
@property (nonatomic, retain) NSString * borough;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * materialType;
@property (nonatomic, retain) NSString * parkSiteName;
@property (nonatomic, retain) NSString * shortName;
@property (nonatomic, retain) NSSet *binsHaveItems;

@end

@interface Bin (CoreDataGeneratedAccessors)

- (void)addBinsHaveItemsObject:(Item *)value;
- (void)removeBinsHaveItemsObject:(Item *)value;
- (void)addBinsHaveItems:(NSSet *)values;
- (void)removeBinsHaveItems:(NSSet *)values;

@end
