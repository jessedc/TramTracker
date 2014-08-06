//
//  REATram.h
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface REATram : NSObject

- (instancetype)initWithJSON:(NSDictionary *)jsonDictionary;

@property (nonatomic, strong) NSDate *predictedArrival;
@property (nonatomic, strong) NSNumber *vehicleNumber;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *routeNumber;

- (NSString *)formattedPredictedArrivalDate;

@end

@interface NSArray (REANextTrams)

- (NSArray *)asNextTrams;

@end