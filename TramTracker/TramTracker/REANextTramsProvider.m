//
//  REANextTramProvider.m
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REANextTramsProvider.h"
#import "REATramStop.h"

//http://ws3.tramtracker.com.au/TramTracker/RestService/GetDeviceToken/?aid=TTIOSJSON&devInfo=WWCM06082014
static NSString * const kREATramTrackerAPIKey = @"4757107f-4e81-4773-9cc4-6ba2f4178558";

@interface REANextTramsProvider()
@property (nonatomic, strong) REATramStop *tramStop;
@property (nonatomic, assign) NSInteger routeNumber;
@property (nonatomic, strong) NSArray *nextTrams;
@end

@implementation REANextTramsProvider
@synthesize delegate = _delegate;

- (instancetype)initWithRouteNumber:(NSInteger)routeNumber tramStop:(REATramStop *)tramStop
{
    self = [super init];
    if (self)
    {
        self.routeNumber = routeNumber;
        self.tramStop = tramStop;
    }
    return self;
}

#pragma mark - REANextTramsProvider

- (void)fetchNextTrams
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *getRouteStopsByRouteURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ws3.tramtracker.com.au/TramTracker/RestService/GetNextPredictedRoutesCollection/%@/%d/false/?cid=2&aid=TTIOSJSON&tkn=%@", self.tramStop.number, self.routeNumber, kREATramTrackerAPIKey]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:getRouteStopsByRouteURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSAssert(error == nil, @"Network error must be nil");

        NSError *jsonError;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSAssert(jsonError == nil, @"JSON error must be nil");

        id responseObject = JSON[@"responseObject"];
        NSArray *nextTrams = [responseObject isKindOfClass:[NSArray class]] ? responseObject : @[];
        self.nextTrams = [nextTrams asNextTrams];

        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(self.delegate) strongDelegate = self.delegate;
            [strongDelegate nextTramsProviderDidUpdateStops:self];
        });
    }];
    [dataTask resume];
}

- (NSInteger)countOfNextTrams
{
    return (NSInteger)[self.nextTrams count];
}

- (REATram *)tramAtIndex:(NSInteger)tramIndex
{
    NSAssert(tramIndex < [self countOfNextTrams], @"tramIndex is out of bounds");
    return self.nextTrams[(NSInteger)tramIndex];
}

@end
