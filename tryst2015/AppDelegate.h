//
//  AppDelegate.h
//  tryst2015
//
//  Created by Robin Malhotra on 11/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *lastNotification;


@end

