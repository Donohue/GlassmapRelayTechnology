//
//  AppDelegate.h
//  GlassmapRelayTechnology
//
//  Created by Brian Donohue on 5/13/13.
//  Copyright (c) 2013 Brian Donohue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate> {
    CLLocationManager *location_manager;
    CLLocation *last_location;
    BOOL updating_location;
}

@property (strong, nonatomic) UIWindow *window;

@end
