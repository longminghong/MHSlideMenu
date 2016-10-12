//
//  MHSlideMenu.m
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "MHSlideMenu.h"
#import "MHSlideMenuItem.h"
#import <CoreGraphics/CoreGraphics.h>

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

CGFloat const defaultToggleButtonWidth = 30.0f;
CGFloat const defaultMHSlideMenuHeigh = 60.0f;

NSTimeInterval const defaultOpenAnimationDuration = 0.2;
NSTimeInterval const defaultCloseAnimationDuration = 0.2;
NSTimeInterval const defaultMenuItemViewCloseDuration = 0.15;


CGFloat const defaultMenuItemIconWidth = 20.0f;

@interface MHSlideMenuItemView(){
    
    UIView *layerContainer;
    
    UIImageView *icon;
    UILabel *titleLable;
}

@property (nonatomic,strong) MHSlideMenuItem *item;
@end

@implementation MHSlideMenuItemView : UIControl

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    layerContainer = [[UIView alloc]initWithFrame:frame];
    
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    
    return self;
}

- (void)initImageLayer{
    
    icon = [[UIImageView alloc]initWithFrame:CGRectZero];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:icon];
}

- (void)initTextLayer{
    
    titleLable = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:titleLable];
}

- (void)setMenuItem:(MHSlideMenuItem *)item{
    
    self.item = item;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    if (nil == icon) {
        
        [self initImageLayer];
    }
    if (nil == titleLable) {
        [self initTextLayer];
    }
    
    if (_item) {
        
        CGFloat superLayerWidth = CGRectGetWidth(self.frame);
        
        if (_item.icon) {
            /**
             *  设置layer的frame不能放到 layoutSubviews 的顶部，会造成显示错误。
             */
            
            if (superLayerWidth>0) {
                
                icon.frame = CGRectMake(0, 0, defaultMenuItemIconWidth, defaultMHSlideMenuHeigh);
            }
            
            [icon setImage:_item.icon];
        }
        
        if (_item.title) {
            
            if (superLayerWidth>0) {
                
                CGFloat titleLayerWidth = CGRectGetWidth(self.bounds) - defaultMenuItemIconWidth;
                
                titleLable.frame = CGRectMake(defaultMenuItemIconWidth, 0, titleLayerWidth, defaultMHSlideMenuHeigh);
            }
            titleLable.text = _item.title;
            
        }
        
        if (_item.target) {
            
            [self addTarget:_item.target action:_item.targetAction forControlEvents:_item.events];
        }
    }
    
    [super layoutSubviews];
}

@end

@interface MHSlideMenu(){
    
    
    CGRect originFrame;
}

@property (nonatomic,strong) UIButton* toggleButton;
@property (nonatomic,strong) UIView *container;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSMutableArray *itemViews;
@property (nonatomic,strong) UIView *menuContentView;
@end

@implementation MHSlideMenu

#pragma mark -
#pragma mark property

- (NSMutableArray *)items{
    
    if (nil == _items) {
        
        _items = [[NSMutableArray alloc]init];
        _itemViews = [_items mutableCopy];
    }
    return _items;
}

#pragma mark -
#pragma mark initial

+ (instancetype)initWithDefaultConfig{
    
    return nil;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (CGRectEqualToRect(originFrame, CGRectZero)) {
        
        originFrame = self.frame;
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self config];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self config];
    }
    
    return self;
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        [self config];
    }
    return self;
}

- (UIView *)menuContentView{
    
    if (nil == _menuContentView) {
        
        _menuContentView = [[UIView alloc]init];
        _menuContentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_menuContentView];
    }
    return _menuContentView;
}
- (UIButton *)toggleButton{
    
    if (nil == _toggleButton) {
        
        _toggleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _toggleButtonWidth, defaultMHSlideMenuHeigh)];
        
        [_toggleButton addTarget:self action:@selector(toggleMenuOpen) forControlEvents:UIControlEventTouchUpInside];
        
        _toggleButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_toggleButton setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
        
        [_toggleButton setImage:[UIImage imageNamed:@"icon_favorite"] forState:UIControlStateNormal];
        
        [self addSubview:_toggleButton];
    }
    return _toggleButton;
}

- (void)config{
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.autoresizesSubviews = YES;
    self.clipsToBounds = YES;
    
    _heigh = defaultMHSlideMenuHeigh;
    _width = SCREEN_WIDTH;
    _toggleButtonWidth = defaultToggleButtonWidth;
    _menuState = MHSlideMenuStateClose;
    _itemWidthStyle = MHSlideMenuItemWidthStyleDynamic;
    
    [self.toggleButton setBackgroundColor:[UIColor whiteColor]];
    [self.menuContentView setBackgroundColor:[UIColor yellowColor]];
}

- (void)addItems:(NSArray *)items{
    
    [self.items removeAllObjects];
    
    [self.items addObjectsFromArray:items];
    
    if (self.itemViews.count>0) {
        
        [self.itemViews removeAllObjects];
    }
    for (UIView *subView in [self.menuContentView subviews]) {
        
        [subView removeFromSuperview];
    }
    
    [self layoutMenuItem];
}

- (void)layoutMenuItem{
    
    if (_items.count>0){
        
        CGFloat width = (CGRectGetWidth(self.frame) - _toggleButtonWidth)/_items.count;
        
        for (int i = 0; i<_items.count; i++) {
            
            MHSlideMenuItem *item = _items[i];
            
            MHSlideMenuItemView *itemView = [[MHSlideMenuItemView alloc]init];
            
            CGRect rect = CGRectMake(width*i, 0, width, _heigh);
            
            CGFloat red = arc4random() / (CGFloat)INT_MAX;
            CGFloat green = arc4random() / (CGFloat)INT_MAX;
            CGFloat blue = arc4random() / (CGFloat)INT_MAX;
            UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
            
            [itemView setFrame:rect];
            
            [itemView setMenuItem:item];
            
            [self.menuContentView addSubview:itemView];
            
            [itemView setBackgroundColor:color];
            
            [self.itemViews addObject:itemView];
        }
    }
}

#pragma mark -
#pragma mark - toggle menu open

- (void)toggleMenuOpen{
    
    if (MHSlideMenuStateOpened == self.menuState) {
        
        [self menuCloseAnimation];
        
    }else if (MHSlideMenuStateClose == self.menuState){
        
        [self menuOpeningAnimation];
        
        [self needsUpdateConstraints];
    }
}

- (void)menuOpeningAnimation{
    
    [UIView animateWithDuration:defaultOpenAnimationDuration delay:0 options:0 animations:^{
        
        CGRect frame = self.frame;
        
        frame.size.width = _width;
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if (YES == finished) {
            
            self.menuState = MHSlideMenuStateOpened;
        }
    }];
    
    CGFloat width = (_width - _toggleButtonWidth)/_itemViews.count;
    
    for (UIView *itemView in _itemViews) {
        
        NSInteger idx = [_itemViews indexOfObject:itemView];
        
        [UIView animateWithDuration:defaultOpenAnimationDuration delay:defaultOpenAnimationDuration / (idx + 1) options:0 animations:^{
            
            CGRect frame = CGRectZero;
            
            frame.origin.x = idx*width;
            
            frame.size.width = width;
            
            frame.size.height = defaultMHSlideMenuHeigh;
            
            itemView.frame = frame;
            
            itemView.alpha = 1;
            
        } completion:nil];
    }
}

- (void)menuCloseAnimation{
    
    [UIView animateWithDuration:defaultCloseAnimationDuration delay:defaultCloseAnimationDuration/_itemViews.count options:0 animations:^{
        
        self.frame = originFrame;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        if (YES == finished) {
            
            self.menuState = MHSlideMenuStateClose;
        }
    }];
    
    CGFloat width = 0;
    
    for (UIView *itemView in _itemViews) {
        
        NSInteger idx = [_itemViews indexOfObject:itemView];
        
        [UIView animateWithDuration:defaultMenuItemViewCloseDuration delay:defaultMenuItemViewCloseDuration / (idx + 1) options:0 animations:^{
            
            CGRect frame = CGRectZero;
            
            frame.origin.x = idx*width;
            
            frame.size.width = width;
            
            frame.size.height = defaultMHSlideMenuHeigh;
            
            itemView.frame = frame;
            itemView.alpha = 0;
        } completion:nil];
    }
}

#pragma mark -
#pragma mark - constraints

- (void)updateConstraints {
    
    NSDictionary *metrics;
    NSString *constraintsString;
    NSArray *constraints;
    
    if (_toggleButton) {
        
        metrics = @{@"margin_top":[NSNumber numberWithFloat:0],
                    @"margin_bottom":[NSNumber numberWithFloat:0],
                    @"margin_right":[NSNumber numberWithFloat:0],
                    @"button_width":[NSNumber numberWithFloat:_toggleButtonWidth]
                    };
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_toggleButton,_menuContentView);
        
        constraintsString = [NSString stringWithFormat:@"V:|[_toggleButton]|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
                                                              options:0
                                                              metrics:metrics
                                                                views:views];
        
        [self addConstraints:constraints];
        
        /**
         *  _container heigh
         */
        
        constraintsString = [NSString stringWithFormat:@"V:|[_menuContentView]|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
                                                              options:0
                                                              metrics:metrics
                                                                views:views];
        
        [self addConstraints:constraints];
        
        /**
         *  width and margin
         */
        constraintsString = [NSString stringWithFormat:@"H:|[_menuContentView][_toggleButton(==button_width)]-margin_right-|"];
        
        //        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
        //                                                              options:0
        //                                                              metrics:metrics
        //                                                                views:views];
        
        //        [self addConstraints:constraints];
        //        constraintsString = [NSString stringWithFormat:@"H:[_toggleButton(==button_width)]-margin_right-|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
                                                              options:0
                                                              metrics:metrics
                                                                views:views];
        
        [self addConstraints:constraints];
    }
    
    [super updateConstraints];
}

@end
