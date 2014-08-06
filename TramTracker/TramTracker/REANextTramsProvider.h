//
//  REANextTramsProvider.h
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REATram.h"

@class REANextTramsProvider;
@class REATramStop;

@protocol REANextTramsProviderDelegate <NSObject>
- (void)nextTramsProviderDidUpdateStops:(REANextTramsProvider *)provider;
@end

@protocol REANextTramsProvider <NSObject>

@property (nonatomic, weak) id<REANextTramsProviderDelegate> delegate;

- (void)fetchNextTrams;

- (NSArray *)nextTrams;
- (NSInteger)countOfNextTrams;
- (REATram *)tramAtIndex:(NSInteger)tramIndex;

@end

@interface REANextTramsProvider : NSObject <REANextTramsProvider>

- (instancetype)initWithRouteNumber:(NSInteger)routeNumber tramStop:(REATramStop *)tramStop;

@end

