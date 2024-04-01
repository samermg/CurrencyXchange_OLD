//
//  ListCountriesViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
@protocol TableSelectionDelegate <NSObject>
- (void)didSelectValue:(NSDictionary *)currency SenderDelegate:(CurrencyCode)sender;
@end
@interface ListCountriesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate> {
    NSDictionary* data;
}
@property (nonatomic, strong) id <TableSelectionDelegate> UpdateFlagDelegate;
@property (weak, nonatomic) IBOutlet UITableView *countries;
@property CurrencyCode CurrencyFlag;
@property (strong,nonatomic) NSArray* currencies;
@property (strong,nonatomic) NSArray*symbols;
@property (strong,nonatomic) NSDictionary* rates;
@property (weak, nonatomic) IBOutlet UISearchBar *fromSearch;


@end
