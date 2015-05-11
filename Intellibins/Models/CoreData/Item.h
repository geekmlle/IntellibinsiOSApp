//
//  Item.h
//  Intellibins
//
//  Created by rachel wu on 5/10/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bin;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * iconName;
@property (nonatomic, retain) NSNumber * isToggled;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *itemsInBins;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addItemsInBinsObject:(Bin *)value;
- (void)removeItemsInBinsObject:(Bin *)value;
- (void)addItemsInBins:(NSSet *)values;
- (void)removeItemsInBins:(NSSet *)values;

@end
