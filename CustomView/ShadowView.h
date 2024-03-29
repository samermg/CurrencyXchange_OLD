#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ShadowView : UIView

@property (nonatomic, strong) IBInspectable UIColor *shadowColor;
@property (nonatomic) IBInspectable CGFloat shadowOpacity;
@property (nonatomic) IBInspectable CGSize shadowOffset;
@property (nonatomic) IBInspectable CGFloat shadowRadius;

- (void)updateView;

@end

@implementation ShadowView

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    [self updateView];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    _shadowOpacity = shadowOpacity;
    [self updateView];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffset = shadowOffset;
    [self updateView];
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    [self updateView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateView];
}

- (void)updateView {
    self.layer.shadowColor = self.shadowColor.CGColor;
    self.layer.shadowOpacity = self.shadowOpacity;
    self.layer.shadowOffset = self.shadowOffset;
    self.layer.shadowRadius = self.shadowRadius;
}

@end
