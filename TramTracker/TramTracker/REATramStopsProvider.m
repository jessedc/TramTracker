//
//  REATramStopsProvider.m
//  TramTracker
//
//  Created by Jesse Collis on 5/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REATramStopsProvider.h"
#import "REATramStop.h"

//http://ws3.tramtracker.com.au/TramTracker/RestService/GetDeviceToken/?aid=TTIOSJSON&devInfo=WWCM06082014
static NSString * const kREATramTrackerAPIKey = @"4757107f-4e81-4773-9cc4-6ba2f4178558";

@interface REATramStopsProvider()
@property (nonatomic, assign) NSInteger routeNumber;
@property (nonatomic, strong, readwrite) NSArray *stops;
@end

@implementation REATramStopsProvider
@synthesize delegate = _delegate;

- (instancetype)initWithRouteNumber:(NSInteger)routeNumber
{
    self = [super init];
    if (self)
    {
        self.routeNumber = routeNumber;
    }
    return self;
}

#pragma mark - REATramStopsProvider

- (void)fetchStops
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *getRouteStopsByRouteURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ws3.tramtracker.com.au/TramTracker/RestService/GetRouteStopsByRoute/%d/?aid=TTIOSJSON&tkn=%@", self.routeNumber, kREATramTrackerAPIKey]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:getRouteStopsByRouteURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSAssert(error == nil, @"Network error must be nil");

        NSError *jsonError;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSAssert(jsonError == nil, @"JSON error must be nil");

        self.stops = [JSON[@"responseObject"] asTramStops];

        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(self.delegate) strongDelegate = self.delegate;
            [strongDelegate tramStopsProviderDidUpdateStops:self];
        });
    }];
    [dataTask resume];
}

- (NSInteger)countOfStops
{
    return (NSInteger)[self.stops count];
}

- (REATramStop *)stopAtIndex:(NSInteger)stopIndex
{
    NSAssert(stopIndex < [self countOfStops], @"stopIndex is out of bounds");
    return self.stops[(NSInteger)stopIndex];
}

@end
