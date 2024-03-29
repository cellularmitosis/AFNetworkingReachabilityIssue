//
//  ReachabilityViewController2.m
//  AFDemoA
//
//  Created by Jason Pepas on 5/15/14.
//  Copyright (c) 2014 Jason Pepas. All rights reserved.
//

#import "ReachabilityViewController2.h"
#import <AFNetworking.h>


@implementation ReachabilityViewController2


#pragma mark - object lifecycle methods


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self == nil)
    {
        return nil;
    }
    
    [self _commonSetup];
    
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _commonSetup];
}


- (void)_commonSetup
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_AFNetworkingReachabilityDidChangeNotificationReceived:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self _houndReachabilityUntilItReachesAValidState];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - view lifecycle methods


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _updateVisualStateToReflectReachability];
}


#pragma mark - notification handlers


- (void)_AFNetworkingReachabilityDidChangeNotificationReceived:(NSNotification*)notification
{
    [self _updateVisualStateToReflectReachability];
}


#pragma mark - internal methods


- (void)_houndReachabilityUntilItReachesAValidState
{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusUnknown)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _houndReachabilityUntilItReachesAValidState];
        });
    }
    else
    {
        [self _updateVisualStateToReflectReachability];
    }
}


- (void)_updateVisualStateToReflectReachability
{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    NSLog(@"%s status: %@", __FUNCTION__, AFStringFromNetworkReachabilityStatus(status));
    [self _updateBackgroundColorBasedOnReachabilityStatus:status];
    [self _updateLabelBasedOnReachabilityStatus:status];
}


- (void)_updateLabelBasedOnReachabilityStatus:(AFNetworkReachabilityStatus)status
{
    self.label.text = AFStringFromNetworkReachabilityStatus(status);
}


- (void)_updateBackgroundColorBasedOnReachabilityStatus:(AFNetworkReachabilityStatus)status
{
    self.view.backgroundColor = [self _backgroundColorForReachabilityStatus:status];
}


- (UIColor*)_backgroundColorForReachabilityStatus:(AFNetworkReachabilityStatus)status
{
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus)
    {
        case AFNetworkReachabilityStatusUnknown:
            return [UIColor brownColor];
            break;
            
        case AFNetworkReachabilityStatusNotReachable:
            return [UIColor redColor];
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return [UIColor yellowColor];
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return [UIColor greenColor];
            break;
            
        default:
            return [UIColor whiteColor];
            break;
    }
}


@end
