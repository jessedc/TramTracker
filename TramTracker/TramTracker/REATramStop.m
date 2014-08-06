//
//  REATramStop.m
//  TramTracker
//
//  Created by Jesse Collis on 5/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REATramStop.h"

@implementation REATramStop

- (instancetype)initWithJSON:(NSDictionary *)jsonDictionary
{
    NSParameterAssert(jsonDictionary);
    self = [super init];
    if (self)
    {
        self.upStop = [jsonDictionary[@"upStop"] boolValue];
        self.name = jsonDictionary[@"StopName"];
        self.suburb = jsonDictionary[@"SuburbName"];
        self.number = jsonDictionary[@"StopNo"];

        CLLocationDegrees latitude = [jsonDictionary[@"Latitude"] doubleValue];
        CLLocationDegrees longitude = [jsonDictionary[@"Longitude"] doubleValue];

        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}

@end

@implementation REATramStop (MKAnnotation)

- (NSString *)title
{
    return [NSString stringWithFormat:@"%@ - %@",self.number,self.name];
}

- (NSString *)subtitle
{
    return self.suburb;
}

@end

@implementation NSArray (REATramStop)

- (NSArray *)asTramStops
{
    NSMutableArray *arrayOfTramsStops = [[NSMutableArray alloc] initWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSAssert([obj isKindOfClass:[NSDictionary class]], @"items in the array must be NSDictionary");
        [arrayOfTramsStops addObject:[[REATramStop alloc]  initWithJSON:obj]];
    }];

    return [arrayOfTramsStops copy];
}

@end