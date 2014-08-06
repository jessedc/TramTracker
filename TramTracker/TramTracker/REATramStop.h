//
//  REATramStop.h
//  TramTracker
//
//  Created by Jesse Collis on 5/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import MapKit;

@interface REATramStop : NSObject

- (instancetype)initWithJSON:(NSDictionary *)jsonDictionary;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *suburb;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, assign, getter = isUpStop) BOOL upStop;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@interface REATramStop (MKAnnotation)
@end

#pragma mark - Utilities

@interface NSArray (REATramStop)

- (NSArray *)asTramStops;

@end
