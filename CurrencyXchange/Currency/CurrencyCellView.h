//
//  CurrencyCellView.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *currency;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UIImageView *flag;
@property (weak, nonatomic) IBOutlet UIView *flagView;

@end

NS_ASSUME_NONNULL_END
