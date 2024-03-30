//
//  ListCountriesViewController.h
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//

#import <UIKit/UIKit.h>

@interface ListCountriesViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate> {
    NSDictionary* data;
}
@property (weak, nonatomic) IBOutlet UITableView *countries;
@property (strong,nonatomic) NSArray* currencies;
@property (strong,nonatomic) NSDictionary* rates;
@property (weak, nonatomic) IBOutlet UISearchBar *fromSearch;


@end
