//
//  AppDelegate.m
//  tryst2015
//
//  Created by Robin Malhotra on 11/01/15.
//  Copyright (c) 2015 Robin's code kitchen. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
#import "initialViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (int)hoursBetween:(NSDate *)firstDate and:(NSDate *)secondDate {
    NSUInteger unitFlags = NSCalendarUnitHour;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:firstDate toDate:secondDate options:0];
    return [components hour]+1;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse enableLocalDatastore];
    // Initialize Parse.
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];

    [Parse setApplicationId:@"gXMF3SXAsbKMjgjSjzKRNK8djmuyIxoO2LPtlNyJ"
                  clientKey:@"zulRcOx80KDfiMNSCNnrfaA4Hp9HCScfq5OtD2Cc"];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    
    
    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:
                          @"ADBD15B8-9A2F-492F-BB26-C7C92E05CAD3"];
    NSString *regionIdentifier = @"us.iBeaconModules";
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
                                    initWithProximityUUID:beaconUUID identifier:regionIdentifier];
    
    self.locationManager = [[CLLocationManager alloc] init];
    // New iOS 8 request for Always Authorization, required for iBeacons to work!
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startUpdatingLocation];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound
                                                                                                              categories:nil]];
    }
    
    UIStoryboard * myStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BOOL ranBefore = [[NSUserDefaults standardUserDefaults] boolForKey:@"ranBefore"];
    if (!ranBefore)
    {
        initialViewController * initialVC = [myStoryboard instantiateViewControllerWithIdentifier:@"InitialViewControllerIdentifier"];
        [self.window setRootViewController:initialVC];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ranBefore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        
        UITabBarController * defaultViewController = [myStoryboard instantiateInitialViewController];
        [self.window setRootViewController:defaultViewController];
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Do background work
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    });
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *timeOfLastDownload=[defaults objectForKey:@"timeOfLastDownload"];
    NSDate *now = [NSDate date];
    if ([self hoursBetween:now and:timeOfLastDownload]>2 || timeOfLastDownload==Nil)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"iBeaconMessages"];
        [query orderByAscending:@"minor"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"%lu",(unsigned long)[objects count]);
            NSMutableArray *iBeaconMessages=[[NSMutableArray alloc]init];
            [iBeaconMessages addObject:@"NULL"];
            for (int i=0; i<[objects count]; i++)
            {
                [iBeaconMessages addObject:[[objects objectAtIndex:i] objectForKey:@"Message"]];
            }
            [defaults setObject:iBeaconMessages forKey:@"iBeaconMessages"];
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:now forKey:@"timeOfLastDownload"];
    }
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)sendLocalNotificationWithMessage:(NSString*)message {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:
(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSMutableArray *objects=[[NSUserDefaults standardUserDefaults]objectForKey:@"iBeaconMessages"];
         if ([objects count]>0)
         {
             
         
             NSString *message = @"";
            if(beacons.count > 0) {
                CLBeacon *nearestBeacon = beacons.firstObject;
                switch(nearestBeacon.proximity) {
                    case CLProximityFar:
                        message =[NSString stringWithFormat:@"You are far away from the beacon %@",nearestBeacon.minor];
                        break;
                    case CLProximityNear:
                    case CLProximityImmediate:
                        message = [NSString stringWithFormat:[objects objectAtIndex:[nearestBeacon.minor integerValue]]];
                        break;
                    case CLProximityUnknown:
                        return;
                }
            } else {
                message = @"No beacons are nearby";
            }
            
            NSLog(@"%@", message);
            if (![self.lastNotification isEqualToString:message])
            {
                [self sendLocalNotificationWithMessage:message];
                self.lastNotification=message;
            }
         }
    

}

-(void)locationManager:(CLLocationManager *)manager
        didEnterRegion:(CLRegion *)region {
    [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"You entered the region.");
    [self sendLocalNotificationWithMessage:@"You entered the region."];
}

-(void)locationManager:(CLLocationManager *)manager
         didExitRegion:(CLRegion *)region {
    [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"You exited the region.");
    [self sendLocalNotificationWithMessage:@"You exited the region."];
}



@end
