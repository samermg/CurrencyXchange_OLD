//
//  NotificationVC.m
//  DownloadMe
//
//  Created by Samer Ghanim on 11/03/2024.
//

#import "NotificationVC.h"
#import "Helper.h"
@interface NotificationVC ()
@property (weak, nonatomic) IBOutlet LoadingIndicator *downloadSpinner;
@end
typedef void(^mediaImageData)(NSData* data);
@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSpinner];
    if (self.saveNewNotification!=nil) {
        self.saveNewNotification(self.message);
    }
    NSString* title = [[[_message objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"title"];
    NSString* subtitle = [[[_message objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"subtitle"];
    NSString* body = [[[_message objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];
    
    self.alertTitle.text = title;
    self.alertSubtitle.text = subtitle;
    self.alertBody.text = body;
    self.alertDate.text = [self.message objectForKey:@"timestamp"];
    NSString* imgURL = [self.message objectForKey:@"ct_mediaUrl"];
    if (imgURL == nil) {
        imgURL = [[self.message objectForKey:@"aps"] objectForKey:@"ct_mediaUrl"];
    }
    if (imgURL != nil) {
        [self.downloadSpinner startAnimating];
        [self downloadMediaFromURL:imgURL andWithHandler:^(NSData *data) {
            [self.downloadSpinner stopAnimating];
            self.alertMedia.image = [UIImage imageWithData:data];
        }];
    }

    // Do any additional setup after loading the view.
}

-(void)downloadMediaFromURL:(NSString*)url andWithHandler:(mediaImageData)handler {

    dispatch_queue_t dwnQueue = dispatch_queue_create("DownloadQueue", NULL);
    dispatch_async(dwnQueue, ^ {
        NSURL *URL = [NSURL URLWithString:url];
        NSData *imgData = [NSData dataWithContentsOfURL:URL];
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"Finished Downloading: %d", stid );
            handler(imgData);
        });
        
    });
};
- (void)setupSpinner {
    self.downloadSpinner.lineWidth = 3;
    self.downloadSpinner.spinnerColors = @[[Helper colorWithHexString:@"0066FF"]];
    self.downloadSpinner.hidesWhenStopped = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
