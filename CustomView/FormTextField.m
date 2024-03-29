#import <UIKit/UIKit.h>

@interface FormTextField : UITextField

@end

@implementation FormTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *underlineView = [[UIView alloc] init];
    underlineView.translatesAutoresizingMaskIntoConstraints = NO;
    underlineView.backgroundColor = [UIColor colorWithRed:185/255.0 green:185/255.0 blue:185/255.0 alpha:1];
    [self addSubview:underlineView];
    
    [NSLayoutConstraint activateConstraints:@[
        [underlineView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [underlineView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [underlineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
        [underlineView.heightAnchor constraintEqualToConstant:1]
    ]];
}

@end
