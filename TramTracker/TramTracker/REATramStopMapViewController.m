//
//  REATramStopMapViewController.m
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REATramStopMapViewController.h"
#import "REATramStopsProvider.h"

@interface REATramStopMapViewController () <REATramStopProviderDelegate>
@end

@implementation REATramStopMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tramStopsProvider.delegate = self;
    [self.tramStopsProvider fetchStops];
}

#pragma mark - REATramStopProviderDelegate

- (void)tramStopsProviderDidUpdateStops:(REATramStopsProvider *)provider
{
    [self.mapView removeAnnotations:self.mapView.annotations];

    [self.mapView addAnnotations:provider.stops];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
    NSString *viewIdentifier = @"MapViewIdentifier";

    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:viewIdentifier];
    if (!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewIdentifier];
        annotationView.canShowCallout = YES;
    }
    else
    {
        annotationView.annotation = annotation;
    }

    return annotationView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
