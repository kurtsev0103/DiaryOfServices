//
//  OKCalendarViewController.m
//  DiaryOfServices
//
//  Created by Oleksandr Kurtsev on 07.09.17.
//  Copyright © 2017 Oleksandr Kurtsev. All rights reserved.
//

#import "OKCalendarViewController.h"
#import "OKDayTableViewController.h"
#import "CKCalendarView.h"

@interface OKCalendarViewController () <CKCalendarDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) CKCalendarView* calendar;

@end

@implementation OKCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CKCalendarView *calendar = [CKCalendarView new];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = NO;
    
    calendar.calendarStartDay = startSunday;
    calendar.backgroundColor = [UIColor clearColor];
    calendar.dayOfWeekTextColor = [UIColor blackColor];
    calendar.delegate = self;

    self.calendar = calendar;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.calendar removeFromSuperview];
    [self makeCalendarFrameFromInterfaceOrientation];
    [self.view addSubview:self.calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods 

- (void)makeCalendarFrameFromInterfaceOrientation {
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGFloat topBarSize = CGRectGetHeight(self.navigationController.navigationBar.frame);
    CGFloat downBarSize = CGRectGetHeight(self.parentViewController.tabBarController.tabBar.frame);
    
    if (orientation == UIDeviceOrientationPortrait ||
        orientation == UIDeviceOrientationPortraitUpsideDown) {
        
        self.calendar.frame =
        CGRectMake(0, (CGRectGetHeight(self.view.frame) - CGRectGetWidth(self.view.frame)) / 2,
                   CGRectGetWidth(self.view.frame),
                   CGRectGetWidth(self.view.frame));
        
        self.calendar.center = self.view.center;
        
    } else {
        
        self.calendar.frame =
        CGRectMake((CGRectGetWidth(self.view.frame) - CGRectGetHeight(self.view.frame) + topBarSize + downBarSize + 20.f) / 2,
                                    topBarSize,
                                    CGRectGetHeight(self.view.frame) - topBarSize - downBarSize - 20.f,
                                    CGRectGetHeight(self.view.frame) - topBarSize - downBarSize - 20.f);
    }
}

#pragma mark - CKCalendarDelegate

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return YES;
}

- (BOOL)calendar:(CKCalendarView *)calendar willDeselectDate:(NSDate *)date {
    return NO;
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    OKDayTableViewController* vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"OKDayTableViewController"];
    vc.date = date;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Orientation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.calendar removeFromSuperview];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self makeCalendarFrameFromInterfaceOrientation];
    [self.view addSubview:self.calendar];
}

@end
