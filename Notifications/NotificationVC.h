//
//  NotificationVC.h
//  DownloadMe
//
//  Created by Samer Ghanim on 11/03/2024.
//

#import <UIKit/UIKit.h>
#import "LoadingIndicator.h"
NS_ASSUME_NONNULL_BEGIN

@interface NotificationVC : UIViewController
@property (strong,nonatomic) NSDictionary* message;
@property (copy) void (^saveNewNotification)(NSDictionary*info);
@property (weak,nonatomic) IBOutlet UILabel *alertTitle;
@property (weak, nonatomic) IBOutlet UILabel *alertDate;
@property (weak, nonatomic) IBOutlet UITextView *alertSubtitle;
@property (weak, nonatomic) IBOutlet UITextView *alertBody;
@property (weak, nonatomic) IBOutlet UIImageView *alertMedia;

@end

NS_ASSUME_NONNULL_END
