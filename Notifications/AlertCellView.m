//
//  NotificationCellView.m
//  TableView
//
//  Created by Samer Ghanim on 08/02/2024.
//

#import "AlertCellView.h"
#import "Helper.h"
@implementation AlertCellView
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setupSpinner {
    self.spinner.lineWidth = 2;
    self.spinner.spinnerColors = @[[Helper colorWithHexString:@"0066FF"]];
    self.spinner.hidesWhenStopped = YES;
}
-(void)StartSpinner {
    [self.spinner startAnimating];
}
-(void)StopSpinner {
    [self.spinner stopAnimating];
}
@end
