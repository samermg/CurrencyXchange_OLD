//
//  NotificationCellView.h
//  TableView
//
//  Created by Samer Ghanim on 08/02/2024.
//

#import <UIKit/UIKit.h>
#import "LoadingIndicator.h"
NS_ASSUME_NONNULL_BEGIN

@interface AlertCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *media;
@property (weak, nonatomic) NSString *mediaURL;
@property (weak, nonatomic) IBOutlet LoadingIndicator *spinner;
- (void)setupSpinner ;
-(void)StartSpinner;
-(void)StopSpinner;
@end

NS_ASSUME_NONNULL_END
