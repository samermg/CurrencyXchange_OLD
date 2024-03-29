//
//  AppDelegate.h
//  DownloadMe
//
//  Created by Samer on 3/29/24.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "Definitions.h"
#import "Helper.h"
#import "UIDeviceHardware.h"
#import "SGAPI.h"
#import <sys/utsname.h>
typedef void (^notificationsBlock)(NSDictionary* notifications);
@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate> {
    BOOL isNotificationReceived;
    UIApplication *app;
    NSString* appName;
}

@property (assign) BOOL isDidReceiveRemoteNotificationCalled;
@property (strong, nonatomic) NSString *strDeviceToken;
@property (nonatomic,assign) bool isResuming;
@property (strong, nonatomic) UIWindow *window;
@end

