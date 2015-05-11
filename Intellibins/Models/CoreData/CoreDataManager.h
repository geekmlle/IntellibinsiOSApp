//
//  CoreDataManager.h
//  Intellibins
//
//  Created by rachel wu on 5/11/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Bin.h"
#import "Item.h"
#import "AppDelegate.h"

@interface CoreDataManager : NSObject

#define kvoSafeSetStrVar

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSEntityDescription *binEntity;
@property (nonatomic, strong) NSEntityDescription *itemEntity;

+ (id)sharedInstance;

- (void)insertBinWithData:(id)params;

- (void)saveContext;

@end
