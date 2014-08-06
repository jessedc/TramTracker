//
//  REATramStopsTableViewController.m
//  TramTracker
//
//  Created by Jesse Collis on 5/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REATramStopsTableViewController.h"
//#import "REANextTramsTableViewController.h"
//#import "REATramStopMapViewController.h"
#import "REATramStopsProvider.h"
#import "REANextTramsProvider.h"

@interface REATramStopsTableViewController () <REATramStopProviderDelegate>
@property (nonatomic, strong) REATramStopsProvider *tramStopsProvider;
@end

@implementation REATramStopsTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.tramStopsProvider = [[REATramStopsProvider alloc] initWithRouteNumber:109];
    self.tramStopsProvider.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tramStopsProvider fetchStops];
}

#pragma mark - REATramStopsProviderDelegate

- (void)tramStopsProviderDidUpdateStops:(REATramStopsProvider *)provider
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tramStopsProvider countOfStops];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TramStopCellIdentifier" forIndexPath:indexPath];

    REATramStop *tramStop = [self.tramStopsProvider stopAtIndex:indexPath.row];
    cell.textLabel.text = tramStop.name;
    cell.detailTextLabel.text = tramStop.suburb;
    
    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TramStopDetailSegue"])
    {
    }
    else if ([segue.identifier isEqualToString:@"TramStopMapSegue"])
    {
    }
}

@end
