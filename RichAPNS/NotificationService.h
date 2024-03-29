//
//  NotificationService.h
//  RichAPNS
//
//  Created by Samer Ghanim on 11/03/2024.
//

#import <UserNotifications/UserNotifications.h>

@interface NotificationService : UNNotificationServiceExtension
@property (nonatomic, retain) NSString * _Nullable mediaUrlKey;
@property (nonatomic, retain) NSString * _Nullable mediaTypeKey;
@end
