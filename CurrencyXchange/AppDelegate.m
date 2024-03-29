//
//  AppDelegate.m
//  TableView
//
//  Created by Samer Ghanim on 08/02/2024.
//

#import "AppDelegate.h"
#import "NSData+Conversion.h"
#import "NotificationService.h"
#import "NotificationsVC.h"
#import "NotificationVC.h"
#import "CurrenciesViewController.h"
@import UIKit;

// Hide deprecated warning
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)_queryNotificationsStatus
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings){

    //1. Query the authorization status of the UNNotificationSettings object
    switch (settings.authorizationStatus) {
    case UNAuthorizationStatusAuthorized:
        NSLog(@"Status Authorized");
        break;
    case UNAuthorizationStatusDenied:
        NSLog(@"Status Denied");
        break;
    case UNAuthorizationStatusNotDetermined:
        NSLog(@"Undetermined");
        break;
    default:
        break;
    }


    //2. To learn the status of specific settings, query them directly
    NSLog(@"Checking Badge settings");
        if (settings.badgeSetting == UNAuthorizationStatusAuthorized) {
            NSLog(@"Yeah. We can badge this app");
        } else {
            NSLog(@"Not authorized, bagde is disabled ");
        }
  }];
}
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    appName = [Helper appName];
    NSString *filePath = [Helper getPathDirectory:@""];
    NSLog(@"%@",filePath);
    //[FIRMessaging messaging].delegate = self;
    //return YES;

    [self _queryNotificationsStatus];
    // Set isNotification 1 if Notification does not exist in PLIST.
    NSLog(@"%@",[Helper loadObjectFromUserDefaultsForKey:@"DeviceToken"] );
    int isARN = [[Helper loadObjectFromUserDefaultsForKey:@"isNotificationOn"] intValue];
    NSNumber *isRegisteredForRN = [NSNumber numberWithInt:isARN];
    
    BOOL NotificationKeyDoesExists = (isRegisteredForRN == [NSNumber numberWithInt:1]) ? YES : NO ;
    if (!NotificationKeyDoesExists) {
        [Helper saveObjectToUserDefaults:[NSNumber numberWithLong:1] forKey:@"isNotificationOn"];
    }
    //NSString* UDID = [Helper loadObjectFromUserDefaultsForKey:@"DeviceToken"];
#if TARGET_IPHONE_SIMULATOR
    //if ([UDID length]==0) {
        //Simulator

    [Helper saveObjectToUserDefaults:appName forKey:@"AppName"];
    NSString* UDID=@"5b97ad028a8e765661359b9bd568c1a43cefc1c8aec6f2bc350775979847a56b";
    [Helper saveObjectToUserDefaults:UDID forKey:@"DeviceToken"];
    NSString* user_id = [Helper randomStringWithLength:10];
    [Helper saveObjectToUserDefaults:user_id forKey:@"UserID"];
    int devicetype  =(unsigned)[[UIDevice currentDevice] platformType];// ex: UIDevice4GiPhone
    NSNumber* device_type = [NSNumber numberWithInteger:devicetype];
    [Helper saveObjectToUserDefaults:[Helper bundleID] forKey:@"Bundle_ID"];
    [Helper saveObjectToUserDefaults:device_type forKey:@"DeviceType"];
    NSString* app_version = [Helper appVersion];
    [Helper saveObjectToUserDefaults:app_version forKey:@"App_Version"];
    NSString* device_name = [Helper deviceName];
    [Helper saveObjectToUserDefaults:device_name forKey:@"DeviceName"];
    NSString* ios_version = [Helper iosVersion];
    [Helper saveObjectToUserDefaults:ios_version forKey:@"IOSVersion"];
    //int isactive = (unsigned)0;
    //NSNumber* is_active = [NSNumber numberWithInteger:isactive];
    [Helper saveUserDefaultsForBooleanKey:YES forKey:@"IsRegisteredInDB"];
    //}
    NSLog(@"Running in Simulator - no app store or giro");
    
#else
    NSLog(@"Running on the Device");
#endif
    
    //################# Remote Notification ##################//
    isNotificationReceived=false;
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    } else {
        // iOS < 8 Notifications
        //[application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
        UIUserNotificationType types = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    if (launchOptions != nil)
    {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil)
        {
            //NSLog(@"Launched from push notification: %@", dictionary);
            [self addMessageFromRemoteNotification:dictionary updateUI:NO appInForeground:(application.applicationState == UIApplicationStateActive)];
        }
    }
    //Clear App Badge
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if( SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO( @"10.0" ) ) {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
            
             if( !error ) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [[UIApplication sharedApplication] registerForRemoteNotifications];
                     if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
                         NSLog(@"Push Notification is Enabled");
                     }else{
                         NSLog(@"Push Notification is Dsabled");
                     }
                 });
                 NSLog( @"Push registration success." );
             } else {
                 NSLog( @"Push registration FAILED" );
                 NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
             }
         }];
    } else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound |    UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    //Clear App Badge
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    return YES;
}

- (void)registerForRemoteNotifications {
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ) {
                        // required to get the app to do anything at all about push notifications
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                            if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
                                NSLog(@"Push Notification is Enabled");
                            }else{
                                NSLog(@"Push Notification is Dsabled");
                            }
                        });
                        NSLog( @"Push registration success." );
                
                    } else {
                        NSLog( @"Push registration FAILED" );
                        NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                        NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
                    }
         }];
    }
    else {
        // Code for old versions
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UNAuthorizationOptionProvidesAppNotificationSettings) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}
- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI appInForeground:(BOOL)islunchedFromForeground
{
    BOOL isRegistration = [[userInfo objectForKey:@"registration"] boolValue];
    userInfo=[userInfo objectForKey:@"aps"];
    if (isRegistration) {
        //[self showMAlert:@"Your device has been successfully registered to receive notifications" withTitle:@"Notification"];
        return;
    }
    
    if (islunchedFromForeground) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updateRequired" object:self userInfo:userInfo];
    } else {
        [self loadMainView];
    }
}

-(void)loadMainView {
    //mainScreen
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //NotificationsVC *notificationsVC = (NotificationsVC*) [mainStoryboard  instantiateViewControllerWithIdentifier:@"notifyVC"];
    NotificationVC *notificationVC = (NotificationVC*)[mainStoryboard  instantiateViewControllerWithIdentifier:@"messageVC"];
    //UIViewController*rootViewController=[self topViewController:notificationsVC];
    [[self topViewController] presentViewController:notificationVC animated:YES completion:nil];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    if (_isDidReceiveRemoteNotificationCalled) return;
    _isDidReceiveRemoteNotificationCalled = YES;
    NSLog(@"DeviceToken: %@", deviceToken);
    //NSLog(@"UserID is: %@", [Helper loadObjectFromUserDefaultsForKey:@"UserID"] );
    //Reset Notifications
    
    BOOL isAPNsVerified = (BOOL)[Helper loadObjectFromUserDefaultsForKey:@"IsRegisteredInDB"];
    if (!isAPNsVerified) {
        __block BOOL isRegistreationCompleted;
        __block NSString* device_token;
        __block int userid;
        __block NSNumber* user_id;
        __block NSString* device_type;
        __block NSString* app_version;
        __block NSString* device_name;
        __block NSString* ios_version;
        __block NSString* bundle_id;
        __block int isactive;
        __block NSNumber* is_active;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            device_token = [deviceToken hexadecimalString];
            self.strDeviceToken = device_token;
            NSString* userIDStr = [Helper randomStringWithLength:8];
            userid = [[Helper randomStringWithLength:10] intValue];
            user_id = [NSNumber numberWithInteger:userid];
            device_type = [NSString stringWithFormat:@"%lu",(unsigned long)[[UIDevice currentDevice] platformType]] ;
            app_version = [Helper appVersion];
            device_name = [Helper deviceName];
            ios_version = [Helper iosVersion];
            bundle_id = [Helper bundleID];
            isactive = (unsigned)1;
            is_active = [NSNumber numberWithInteger:isactive];
            
            NSDictionary *jsonBodyDict = @{@"app_name": self->appName, @"device_token": device_token, @"bundle_id": bundle_id, @"user_id": user_id, @"device_type": device_type, @"app_version":app_version, @"device_name":device_name, @"os_version": ios_version, @"is_active": is_active};
            // watch out: error is nil here, but you never do that in production code. Do proper checks!
            NSLog(@"%@", jsonBodyDict);
            NSDictionary *header = @{@"x-api-key":API_KEY};
            [SGAPI call:NOTIFICATION_REG_URL method:POST headers:header andParams:jsonBodyDict res:^(NSDictionary * _Nullable json, NSError * _Nullable error) {
                NSLog(@"JSON: %@",json);
                isRegistreationCompleted = ([[json objectForKey:@"message"]  isEqual: @"SUCCESS"] ? TRUE : FALSE);
                if (isRegistreationCompleted) {
                    [Helper saveObjectToUserDefaults:self->appName forKey:@"AppName"];
                    [Helper saveObjectToUserDefaults:device_token forKey:@"DeviceToken"];
                    [Helper saveObjectToUserDefaults:userIDStr forKey:@"UserID"];
                    [Helper saveObjectToUserDefaults:device_type forKey:@"DeviceType"];
                    [Helper saveObjectToUserDefaults:app_version forKey:@"App_Version"];
                    [Helper saveObjectToUserDefaults:device_name forKey:@"DeviceName"];
                    [Helper saveObjectToUserDefaults:ios_version forKey:@"IOSVersion"];
                    //Set one if Registered in Database
                    [Helper saveUserDefaultsForBooleanKey:YES forKey:@"IsRegisteredInDB"];
                    [Helper saveObjectToUserDefaults:[NSNumber numberWithBool:YES] forKey:@"isVerified"];
                    [Helper saveObjectToUserDefaults:[NSNumber numberWithInt:1] forKey:@"isNotificationOn"];
                } else {
                    [Helper saveObjectToUserDefaults:[NSString stringWithFormat:@"%@",device_token] forKey:@"DeviceToken"];
                }
            }];
        });
    }
}
//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSDictionary* userInfo = [NSDictionary dictionaryWithDictionary:notification.request.content.userInfo];
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    [self addMessageFromRemoteNotification:userInfo updateUI:YES appInForeground:(app.applicationState == UIApplicationStateActive && !self.isResuming)];
}

//Called to let your app know which action was selected by the user for a given notification.
//Called when the is in Background
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    NSDictionary* userInfo = [NSDictionary dictionaryWithDictionary:response.notification.request.content.userInfo];
    NSLog(@"User Info : %@",userInfo);
    BOOL isRegistration = [[userInfo objectForKey:@"registration"] boolValue];
    if (isRegistration) {
        [self showMAlert:@"Your device has been successfully registered to receive notifications from the Customers Service Center" withTitle:@"Notification Registration"];
        completionHandler();
        return;
    }
    [self storeUserNotification:userInfo];
    completionHandler();
}
-(void)storeUserNotification:(NSDictionary*)userInfo {
    NSString* timestamp = [userInfo valueForKey:@"timestamp"];
    if (timestamp == nil || [timestamp length]==0) {
        NSMutableDictionary*time = [[NSMutableDictionary alloc]initWithDictionary:userInfo];
        NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"dd/MM/yyyy hh:mm:ss a"];
        NSString* date = [dateFormatter1 stringFromDate:[NSDate date]];
        [time setValue:date forKey:@"timestamp"];
        userInfo = [[NSDictionary alloc]initWithDictionary: time];
    }
    
    [self loadMessagesView:userInfo];
}
-(void)loadMessagesView:(NSDictionary*)notification {
    //mainScreen
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NotificationVC *notificationVC = (NotificationVC*)[mainStoryboard  instantiateViewControllerWithIdentifier:@"messageVC"];
    notificationVC.message = [notification mutableCopy];
    
    notificationVC.saveNewNotification = ^(NSDictionary*info) {
        NSMutableArray* notificationsList = [[NSMutableArray alloc]initWithArray:[Helper loadObjectFromUserDefaultsForKey:@"Notifications"]];
        [notificationsList addObject:info];
        NSArray* notifications = [[NSArray alloc]initWithArray:notificationsList];
        [Helper saveObjectToUserDefaults:notifications forKey:@"Notifications"];
    };

    [[self topViewController] presentViewController:notificationVC animated:YES completion:nil];

    //[notificationsVC presentViewController:notificationVC animated:YES completion:nil];
    
}
-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void
  (^)(UIBackgroundFetchResult))completionHandler {
// iOS 10 will handle notifications through other methods
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        NSLog( @"iOS version >= 10. Let NotificationCenter handle this one." );
        // set a member variable to tell the new delegate that this is background
        return;
    }
    NSLog( @"HANDLE PUSH, didReceiveRemoteNotification: %@", userInfo );
    // custom code to handle notification content
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive ) {
        NSLog( @"INACTIVE" );
        //Show the view with the content of the push
        completionHandler( UIBackgroundFetchResultNewData );
        
    } else if([UIApplication sharedApplication].applicationState == UIApplicationStateBackground ){
        NSLog( @"BACKGROUND" );
        //Refresh the local model
        completionHandler( UIBackgroundFetchResultNewData );
    } else {
        NSLog( @"FOREGROUND" );
        //Show an in-app banner
        completionHandler( UIBackgroundFetchResultNewData );
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    NSLog(@"Open notification settings screen in app");
   }

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    self.isResuming=YES;
   
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.isResuming=NO;
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //Save User Selection
    //[self saveUserSelection];
}
- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    self.isResuming=NO;
    //Save User Selection
    //[self saveUserSelection];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (UIViewController *)topViewController{
    UIViewController* vc = [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    return vc;
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}
-(void)showMAlert:(NSString*)message withTitle:(NSString*)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //Button 1
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //code for performing acctions to be excuted when click Button1
        NSLog(@"Button 1 Pressed");
    }];
    [alert addAction:actionOK];
    [[self topViewController] presentViewController:alert animated:YES completion:nil];
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
