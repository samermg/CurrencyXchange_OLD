//
//  DictionaryRepresentation.m
//  CurrencyXchange
//
//  Created by Samer Ghanim on 06/04/2024.
//

#import "NSObject+DictionaryRepresentation.h"

@implementation NSObject (DictionaryRepresentation)

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);

    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = [self valueForKey:propertyName];
        
        // Skip if the property value is nil
        if (propertyValue == nil) {
            continue;
        }
        
        // If the property is an object, convert it to dictionary recursively
        if ([propertyValue isKindOfClass:[NSObject class]] && ![propertyValue isKindOfClass:[NSString class]] && ![propertyValue isKindOfClass:[NSNumber class]] && ![propertyValue isKindOfClass:[NSDictionary class]] && ![propertyValue isKindOfClass:[NSArray class]]) {
            propertyValue = [propertyValue dictionaryRepresentation];
        }

        [dictionary setObject:propertyValue forKey:propertyName];
    }

    free(properties);
    return dictionary;
}
@end
