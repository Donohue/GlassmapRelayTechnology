//
//  AppDelegate.m
//  GlassmapRelayTechnology
//
//  Created by Brian Donohue on 5/13/13.
//  Copyright (c) 2013 Brian Donohue. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [location_manager release];
    [last_location release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    location_manager = [[CLLocationManager alloc] init];
    location_manager.desiredAccuracy = kCLLocationAccuracyBest;
    location_manager.delegate = self;
    [location_manager startUpdatingLocation];
    updating_location = YES;
    
    BOOL ret = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^(void) {
        if (updating_location) {
            [location_manager stopUpdatingLocation];
            NSLog(@"Keep alive: Stopping location updates");
        }
        else {
            [location_manager startUpdatingLocation];
            NSLog(@"Keep alive: Starting location updates");
        }
        
        updating_location = !updating_location;
    }];
    
    if (ret) {
        NSLog(@"Keep alive handler registered");
    }
    
    return YES;
}

#pragma mark CLLocationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [last_location release];
    last_location = (CLLocation *)[[locations lastObject] retain];
    NSLog(@"Did update to location: %f, %f",
          last_location.coordinate.latitude, last_location.coordinate.longitude);
}

@end
