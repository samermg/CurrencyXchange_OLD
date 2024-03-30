//
//  ListCountriesViewController.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 30/03/2024.
//
#import "GlobalSingleton.h"
#import "ListCountriesViewController.h"
#import "CurrencyCellView.h"
#import "Helper.h"
@interface ListCountriesViewController () {
    NSMutableArray* ratesKeys;
    NSMutableArray* ratesValues;
}

@end

@implementation ListCountriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.countries.delegate = self;
    self.countries.dataSource=self;
    self.fromSearch.delegate = self;

    //#############################################################//
    //##############Expand the Cell on rotation ###################//
    //#############################################################//
    self.countries.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    //#############################################################//
    
    UINib *nib = [UINib nibWithNibName:@"CurrencyCellView" bundle:nil];
    [self.countries registerNib:nib forCellReuseIdentifier:@"CurrencyCV"];
    
    _rates = [NSDictionary dictionaryWithDictionary:[[GlobalSingleton sharedInstance] CurrenciesRates]];
    
    ratesKeys  =[[NSMutableArray alloc]initWithArray:[self.rates allKeys]];
    ratesValues=[[NSMutableArray alloc]initWithArray:[self.rates allValues]];
    [self.countries reloadData];
}
#pragma TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return 57;
 }
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rates.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CurrencyCV";
    CurrencyCellView *cell;

    cell = (CurrencyCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    int row = (int)indexPath.row;
    NSString *currency = [ratesKeys objectAtIndex:row];
    cell.currency.text = currency;
    cell.rate.text =[Helper doubleToString:[[ratesValues objectAtIndex:row] doubleValue] withPrecision:3];
    cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[currency lowercaseString]]];
   
    return cell;
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
