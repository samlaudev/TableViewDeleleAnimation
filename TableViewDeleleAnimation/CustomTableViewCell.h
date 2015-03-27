//
//  CustomTableViewCell.h
//  TableViewDeleleAnimation
//
//  Created by Sam Lau on 3/27/15.
//  Copyright (c) 2015 Sam Lau. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HandleGestureEndStateBlock)(BOOL isDeleted, NSIndexPath *indexPath);

@interface CustomTableViewCell : UITableViewCell

// UI Properties
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
//  Logical Properties
@property (copy, nonatomic) HandleGestureEndStateBlock handleBlock;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
