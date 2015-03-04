//
//  TempBin.h
//  Intellibins
//
//  Created by Ben on 3/3/15.
//  Copyright (c) 2015 Intellibins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@interface TempBin : NSObject

@property (nonatomic, retain) NSString *bin_type;
@property (nonatomic, retain) NSString *short_name;
@property (nonatomic, retain) NSString *borough;
@property (nonatomic, retain) NSString *park_site_name;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, retain) NSString *item_list;

- (id) initWithDictionary:(NSDictionary *)source;

@end
