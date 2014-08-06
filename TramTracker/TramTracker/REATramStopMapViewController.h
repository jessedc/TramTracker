//
//  REATramStopMapViewController.h
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@class REATramStopsProvider;

@interface REATramStopMapViewController : UIViewController
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) REATramStopsProvider *tramStopsProvider;
@end
