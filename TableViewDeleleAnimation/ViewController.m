//
//  ViewController.m
//  TableViewDeleleAnimation
//
//  Created by Sam Lau on 3/27/15.
//  Copyright (c) 2015 Sam Lau. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

// UI properties
@property (weak, nonatomic) IBOutlet UITableView* tableView;
// Model properties
@property (assign, nonatomic) NSInteger rowCount;

@end

@implementation ViewController

#pragma mark - View controller lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rowCount = 10;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowCount;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    CustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    cell.indexPath = indexPath;
    cell.handleBlock = ^(BOOL isDeleted, NSIndexPath* indexPath) {
        if (isDeleted) {
            // Delete cell animation
            [self.tableView beginUpdates];
            self.rowCount--;
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [self.tableView endUpdates];
            // Reload table view
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    };

    return cell;
}

#pragma mark - Table view delegate

@end
