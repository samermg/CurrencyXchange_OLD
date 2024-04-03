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
@property (strong,nonatomic)  NSMutableArray* filteredCurrencies;
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
        //self->_filteredCurrencies = [[NSMutableArray alloc]initWithArray:self->_symbols];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = [NSString stringWithFormat:@"%@ [%lu]",self.title,(unsigned long)self->_symbols.count];
            [self.countries reloadData];
        });
    });
}
#pragma TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
    NSDictionary *selectedCell = (_fromSearch.text.length == 0) ? [_symbols objectAtIndex:row] : [_symbols objectAtIndex:[[self.filteredCurrencies objectAtIndex:indexPath.item] integerValue]];
    if ([self.UpdateFlagDelegate respondsToSelector:@selector(didSelectValue:SenderDelegate:)]) {
        [self.UpdateFlagDelegate didSelectValue:selectedCell SenderDelegate:self.CurrencyFlag];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CurrencyCV";
    CurrencyCellView *cell;
    
    cell = (CurrencyCellView*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    int row = (int)indexPath.row;
    NSDictionary *country = (_fromSearch.text.length == 0) ? [_symbols objectAtIndex:row] : [_symbols objectAtIndex:[[self.filteredCurrencies objectAtIndex:indexPath.item] integerValue]];
    NSArray* keys = [country allKeys];
    NSString* key = keys[0]; // Currency
    NSString* currency = [[country objectForKey:key] objectForKey:@"code"];
    NSString* symbol = [[country objectForKey:key] objectForKey:@"symbol"];
    int decimal = [[[country objectForKey:key] objectForKey:@"decimal_digits"] intValue];
    cell.name.text = [[country objectForKey:key] objectForKey:@"name"];
    cell.popularName.text = [[country objectForKey:key] objectForKey:@"name_plural"];
    cell.code.text = currency;
    //Flag View
    cell.flagView.layer.cornerRadius = cornerRadius;
    cell.flagView.clipsToBounds = YES;
    cell.flagView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.flagView.layer.borderWidth = 1.0;
    double rate=0.000000;
    @try {
        rate = [[[country objectForKey:key] objectForKey:@"rate"] doubleValue];
    }
    @catch (NSException *exception) {
        NSLog(@"%@ currency not found",currency);
    }
    @finally {
        cell.rate.text =[NSString stringWithFormat:@"%@ %@",symbol,[Helper doubleToString:rate withPrecision:decimal]];
    }
    
    cell.flag.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.svg",[currency  lowercaseString]]];
    
    return cell;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    // This method gets called when the cancel button is clicked
    self.filteredCurrencies = [[NSMutableArray alloc]initWithArray:_symbols];
    [self.countries reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //Remove all objects first.
    self.filteredCurrencies = [NSMutableArray array];
    if(![searchBar isFirstResponder]) {
        // user tapped the 'clear' button
       // shouldBeginEditing = NO;
        [self searchBarCancelButtonClicked:self.fromSearch];
        // do whatever I want to happen when the user clears the search...
    } else if ([searchText length] == 0) {
        // The user clicked the [X] button or otherwise cleared the text.
        [self.fromSearch performSelector: @selector(resignFirstResponder)
                           withObject: nil
                           afterDelay: 0.1];
    }
    if([searchText length] != 0) {
       // isSearching = YES;
        
        for (int i=0; i<_symbols.count; i++) {
            NSArray* keys = [[_symbols objectAtIndex:i] allKeys];
            
            NSString* key = keys[0]; // Currency
            NSDictionary* dictionary = [[_symbols objectAtIndex:i] objectForKey:key];
            NSString* name = [dictionary objectForKey:@"name"];
            //NSString* name = [[_symbols objectAtIndex:i] Name];
            if ([[name lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
                [_filteredCurrencies addObject:[NSNumber numberWithInt:i]];
                 //NSLog(@"%ld",(long)i);
            }
        }
        
    }
    else {
        //isSearching = NO;
    }
    
    
    [self.countries reloadData];
    [searchBar becomeFirstResponder];
}
/*
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.filteredCurrencies = _symbols;
        [self.countries reloadData];
    } else {
        [self filterDataWithSearchQuery:_fromSearch.text];
        
    }
}
 */
- (BOOL)keyExistsInDictionary:(NSDictionary *)dictionary forKey:(NSString *)key {
    NSArray *allKeys = [dictionary allKeys];
    BOOL isKeyFound = [allKeys containsObject:key];
    return isKeyFound;
}

- (void)filterDataWithSearchQuery:(NSString*)query {
    query = [query uppercaseString];

    if (query.length == 0) {
        self.filteredCurrencies = [[NSMutableArray alloc] initWithArray: self.symbols];
    } else {
        NSMutableArray* filtered = [NSMutableArray array];
        for (NSDictionary *dictionary in _symbols) {
            NSArray* keys = [dictionary allKeys];
            NSString* key = keys[0]; // Currency
            NSString* name = [[dictionary objectForKey:key] objectForKey:@"name"];
            NSRange range = [name rangeOfString:query];

            if (range.location != NSNotFound) {
                [filtered addObject:dictionary];
            }
        }
        if(filtered.count) {
            _filteredCurrencies = filtered;
            [self.countries reloadData];
        }
    }
}

@end
