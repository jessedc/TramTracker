//
//  REATramStopsProvider.h
//  TramTracker
//
//  Created by Jesse Collis on 5/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REATramStop.h"

@class REATramStopsProvider;

@protocol REATramStopProviderDelegate <NSObject>
- (void)tramStopsProviderDidUpdateStops:(REATramStopsProvider *)provider;
@end

@protocol REATramStopsProvider <NSObject>

@property (nonatomic, weak) id<REATramStopProviderDelegate> delegate;

- (void)fetchStops;

- (NSInteger)routeNumber;
- (NSArray *)stops;
- (NSInteger)countOfStops;
- (REATramStop *)stopAtIndex:(NSInteger)stopIndex;

@end

@interface REATramStopsProvider : NSObject <REATramStopsProvider>

- (instancetype)initWithRouteNumber:(NSInteger)routeNumber;

@end
