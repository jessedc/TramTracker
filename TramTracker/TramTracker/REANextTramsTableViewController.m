//
//  REANextTramsTableViewController.m
//  TramTracker
//
//  Created by Jesse Collis on 6/08/2014.
//  Copyright (c) 2014 REA Group. All rights reserved.
//

#import "REANextTramsTableViewController.h"
#import "REANextTramsProvider.h"

@interface REANextTramsTableViewController () <REANextTramsProviderDelegate>

@end

@implementation REANextTramsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.nextTramsProvider.delegate = self;
    [self.nextTramsProvider fetchNextTrams];

    [self.refreshControl beginRefreshing];
}

#pragma mark - Refresh

- (IBAction)refreshTrams:(id)sender
{
    [self.nextTramsProvider fetchNextTrams];
}

#pragma mark - REANextTramsProviderDelegate

- (void)nextTramsProviderDidUpdateStops:(REANextTramsProvider *)provider
{
    [self.refreshControl endRefreshing];

    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nextTramsProvider countOfNextTrams];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TramCellIdentifier" forIndexPath:indexPath];

    REATram *tram = [self.nextTramsProvider tramAtIndex:indexPath.row];

    cell.textLabel.text = tram.formattedPredictedArrivalDate;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Vehicle Number: %@", tram.vehicleNumber];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
