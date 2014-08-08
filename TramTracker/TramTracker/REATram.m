//
//  REATram.m
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REATram.h"

@implementation REATram

- (instancetype)initWithJSON:(NSDictionary *)jsonDictionary
{
    NSParameterAssert(jsonDictionary);
    self = [super init];
    if (self)
    {
        // Process this uglly date manually... "/Date(1407276558000+1000)/"
        NSString *dateTimeString = jsonDictionary[@"PredictedArrivalDateTime"];

        NSRange startRange = [dateTimeString rangeOfString:@"("];
        NSRange endRange = [dateTimeString rangeOfString:@"+"];

        NSInteger startPosition = startRange.location + startRange.length;
        dateTimeString = [dateTimeString substringWithRange:NSMakeRange(startPosition, endRange.location - startPosition)];
        self.predictedArrival = [NSDate dateWithTimeIntervalSince1970:(dateTimeString.doubleValue / 1000)];

        self.vehicleNumber = jsonDictionary[@"VehicleNo"];
        self.destination = jsonDictionary[@"Destination"];
        self.routeNumber = jsonDictionary[@"HeadBoardRouteNo"];
    }
    return self;
}

- (NSString *)formattedPredictedArrivalDate
{
    NSTimeInterval interval = [self.predictedArrival timeIntervalSinceNow] / 60;
    return [NSString stringWithFormat:@"%0.0f minutes", interval];
}

@end


@implementation NSArray (REANextTrams)

- (NSArray *)asNextTrams
{
    NSMutableArray *arrayOfNextTrams = [[NSMutableArray alloc] initWithCapacity:self.count];

    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSAssert([obj isKindOfClass:[NSDictionary class]], @"items in the array must be NSDictionary");
        [arrayOfNextTrams addObject:[[REATram alloc] initWithJSON:obj]];
    }];

    return [arrayOfNextTrams copy];
}

@end

@implementation NSObject (REANextTrams)

- (NSArray *)asArray
{
    return [self isKindOfClass:[NSArray class]] ? (NSArray *)self : @[];
}

@end