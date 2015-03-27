//
//  CustomTableViewCell.m
//  TableViewDeleleAnimation
//
//  Created by Sam Lau on 3/27/15.
//  Copyright (c) 2015 Sam Lau. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (strong, nonatomic) UIView* snapShotView;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib
{
    self.containerView.layer.cornerRadius = 5.0;
    // setup shadow
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    self.shadowView.layer.shadowOpacity = 0.5;
    self.shadowView.layer.shadowRadius = 5.0;

    // add long press gesture support
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self addGestureRecognizer:longPressGesture];
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
    case UIGestureRecognizerStateBegan: {
        // Get the snap shot view and rorate, add it to content view
        self.snapShotView = [self.containerView snapshotViewAfterScreenUpdates:NO];
        self.snapShotView.frame = self.containerView.frame;
        self.snapShotView.transform = CGAffineTransformMakeRotation(M_PI / 30);
        [self.contentView addSubview:self.snapShotView];
        // Hide container view and shadow view
        self.containerView.hidden = YES;
        self.shadowView.hidden = YES;

        break;
    }
    case UIGestureRecognizerStateChanged: {
        // Change snap shot view position
        CGPoint changePoint = [gesture locationInView:self.contentView];
        self.snapShotView.center = changePoint;

        break;
    }
    case UIGestureRecognizerStateEnded: {
        // Delete cell
        CGPoint endPoint = [gesture locationInView:self.containerView];
        BOOL isDeleted = endPoint.x > self.containerView.frame.size.width - 50;
        if (self.handleBlock) {
            self.handleBlock(isDeleted, self.indexPath);
        }
        // Remove snap shot view and show container, shadow view
        [self.snapShotView removeFromSuperview];
        self.containerView.hidden = NO;
        self.shadowView.hidden = NO;

        break;
    }
    default:
        break;
    }
}

@end
