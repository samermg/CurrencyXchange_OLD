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
const CGFloat cornerRadius = 22;
@interface ListCountriesViewController () {
    NSMutableArray* ratesKeys;
    NSMutableArray* ratesValues;
}
@property (strong,nonatomic)  NSArray* filteredCurrencies;
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
    NSLog(@"%u", self.CurrencyFlag);
    UINib *nib = [UINib nibWithNibName:@"CurrencyCellView" bundle:nil];
    [self.countries registerNib:nib forCellReuseIdentifier:@"CurrencyCV"];
    dispatch_queue_t dwnQueue = dispatch_queue_create("StartQ", NULL);
    dispatch_async(dwnQueue, ^ {
        self->_symbols = [NSArray arrayWithArray:[Helper Symbols]];
        self->_filteredCurrencies = [[NSArray alloc]initWithArray:self->_symbols];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->ratesKeys  =[[NSMutableArray alloc]initWithArray:[self.rates allKeys]];
            self->ratesValues=[[NSMutableArray alloc]initWithArray:[self.rates allValues]];
            [self.countries reloadData];
        });
    });
    //_currencies = [[NSArray alloc]initWithArray:[Helper Countries]];
}
#pragma TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return 55;
 }
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_fromSearch.text.length > 0) {
        return _filteredCurrencies.count;
    } else {
        return _symbols.count;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = (int)indexPath.row;
    
    NSDictionary *CountryCell;
    if (_fromSearch.text.length > 0) {
        CountryCell = [_filteredCurrencies objectAtIndex:row];
    } else {
        CountryCell = [_symbols objectAtIndex:row];
    }
    if ([self.UpdateFlagDelegate respondsToSelector:@selector(didSelectValue:SenderDelegate:)]) {
        [self.UpdateFlagDelegate didSelectValue:CountryCell SenderDelegate:self.CurrencyFlag];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CurrencyCV";
    CurrencyCellView *cell;

    cell = (CurrencyCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    int row = (int)indexPath.row;
    NSDictionary *country = (_fromSearch.text.length == 0) ? [_symbols objectAtIndex:row] : [_filteredCurrencies objectAtIndex:row] ;
    NSString* currency = [country objectForKey:@"Code"];
    NSString* symbol = [country objectForKey:@"Symbol"];
    cell.currency.text = currency;
    cell.country.text = [country objectForKey:@"CountryName"];
    
    //Flag View
    cell.flagView.layer.cornerRadius = cornerRadius;
    cell.flagView.clipsToBounds = YES;
    cell.flagView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.flagView.layer.borderWidth = 1.0;
    double rate=0.000000;
    @try {
         rate = [[_rates objectForKey:currency] doubleValue];
    }
    @catch (NSException *exception) {
        NSLog(@"%@ currency not found",currency);
    }
    @finally {
        cell.rate.text =[NSString stringWithFormat:@"%@ %@",symbol,[Helper doubleToString:rate withPrecision:3]];
    }
    
    cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.svg",[currency  lowercaseString]]];
   
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    // This method gets called when the cancel button is clicked
    self.filteredCurrencies = _symbols;
    [self.countries reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.filteredCurrencies = _symbols;
        [self.countries reloadData];
    } else {
        [self filterDataWithSearchQuery:_fromSearch.text];
    }
}
- (BOOL)keyExistsInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSArray *allKeys = [dictionary allKeys];
    BOOL isKeyFound = [allKeys containsObject:key];
    return isKeyFound;
}
    
- (void)filterDataWithSearchQuery:(NSString*)query {
    query = [query uppercaseString];
    if (query.length == 0) {
        self.filteredCurrencies = self.symbols;
    } else {

        NSArray *filtered = [_symbols filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryName CONTAINS[cd] %@", query]];
        if (filtered.count > 0) {
            NSLog(@"Matching dictionaries found:");
            for (NSDictionary *dictionary in filtered) {
                NSLog(@"%@", dictionary);
            }
        } else {
            NSLog(@"No matching dictionaries found");
        }
        //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Code == %@", query];
        _filteredCurrencies = filtered;
        [self.countries reloadData];
    }
}
@end
