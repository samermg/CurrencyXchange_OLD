#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DesignableUITextField : UITextField

@property (nonatomic, strong) IBInspectable UIImage *leftImage;
@property (nonatomic) IBInspectable CGFloat leftPadding;
@property (nonatomic, strong) IBInspectable UIColor *color;

- (void)updateView;

@end

@implementation DesignableUITextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += self.leftPadding;
    return textRect;
}

- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    [self updateView];
}

- (void)setLeftPadding:(CGFloat)leftPadding {
    _leftPadding = leftPadding;
    [self updateView];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self updateView];
}

- (void)updateView {
    if (self.leftImage) {
        self.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = self.leftImage;
        imageView.tintColor = self.color;
        self.leftView = imageView;
    } else {
        self.leftViewMode = UITextFieldViewModeNever;
        self.leftView = nil;
    }
    
    // Placeholder text color
    NSString *placeholderText = (self.placeholder != nil) ? self.placeholder : @"";
    NSDictionary *attributes = @{NSForegroundColorAttributeName: self.color};
    NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:attributes];
    self.attributedPlaceholder = attributedPlaceholder;
}

@end
