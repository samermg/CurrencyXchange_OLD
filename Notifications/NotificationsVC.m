//
//  NotificationsVC.m
//  DownloadMe
//
//  Created by Samer Ghanim on 11/03/2024.
//

#import "NotificationsVC.h"
#import "LoadingIndicator.h"
#import "AlertCellView.h"
#import "Helper.h"
@interface NotificationsVC ()
@property (weak, nonatomic) IBOutlet LoadingIndicator *tableSpinner;
@property  (nonatomic,strong) NSArray* notifications;
@end
typedef void(^mediaImageData)(NSData* data);
@implementation NotificationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource=self;
    UINib *nib = [UINib nibWithNibName:@"AlertCellView" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"AlertCV"];
    //#############################################################//
    //##############Expand the Cell on rotation ###################//
    //#############################################################//
    self.tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    //#############################################################//
    [self setupSpinner];
    [self.tableSpinner startAnimating];
    dispatch_queue_t showAlertQue = dispatch_queue_create("AlertQueue", NULL);
    dispatch_async(showAlertQue, ^{
        self->_notifications = [[NSMutableArray alloc]initWithArray:[Helper loadObjectFromUserDefaultsForKey:@"Notifications"]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableSpinner stopAnimating];
        });
    });
}
- (void)setupSpinner {
    self.tableSpinner.lineWidth = 3;
    self.tableSpinner.spinnerColors = @[[Helper colorWithHexString:@"0066FF"]];
    self.tableSpinner.hidesWhenStopped = YES;
}
#pragma TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 119;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _notifications.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"AlertCV";
    AlertCellView *cell;
    
    cell = (AlertCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    int row = (int)indexPath.row;
    
    NSDictionary* object = [NSDictionary dictionaryWithDictionary:[_notifications objectAtIndex:row]];
    NSString* title = [[[object objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"title"];
    NSString* subtitle = [[[object objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"subtitle"];
    
    NSString* timestamp = [object objectForKey:@"timestamp"] ;
    cell.tag = row;
    cell.date.text = timestamp;
    cell.title.text = title;
    cell.subtitle.text = subtitle;
    [cell setupSpinner];
    [cell StartSpinner];
    NSString* imgURL = [object objectForKey:@"ct_mediaUrl"];
    cell.mediaURL= imgURL;
    if(imgURL != nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cell.mediaURL]];
            UIImage* image = [[UIImage alloc] initWithData:imageData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (cell.tag == row) {
                        cell.media.image = image;
                    }
                    [cell StopSpinner];
                    [cell setNeedsLayout];
                });
            }
        });
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSInteger row = [indexPath row];
    
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
