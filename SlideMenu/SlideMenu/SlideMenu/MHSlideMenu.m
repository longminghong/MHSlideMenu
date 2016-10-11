//
//  MHSlideMenu.m
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "MHSlideMenu.h"

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

CGFloat const defaultToggleButtonWidth = 30.0f;
CGFloat const defaultMHSlideMenuHeigh = 60.0f;

@interface MHSlideMenu()

@property (nonatomic,strong) UIButton* toggleButton;
@property (nonatomic,strong) UIView *container;
@end

@implementation MHSlideMenu

#pragma mark -
#pragma mark property

- (NSMutableArray *)items{

    if (nil == _items) {
        
        _items = [[NSMutableArray alloc]init];
    }
    return _items;
}

#pragma mark -
#pragma mark initial 

+ (instancetype)initWithDefaultConfig{

    return nil;
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

- (void)config{
    
    _heigh = defaultMHSlideMenuHeigh;
    _width = SCREEN_WIDTH;
    _toggleButtonWidth = defaultToggleButtonWidth;
    _menuState = MHSlideMenuStateClose;
    _itemWidthStyle = MHSlideMenuItemWidthStyleDynamic;
    
    _toggleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _toggleButtonWidth, defaultMHSlideMenuHeigh)];
    _toggleButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_toggleButton setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
    [_toggleButton setImage:[UIImage imageNamed:@"ios7-arrow-forward.png"] forState:UIControlStateNormal];
    
    [self addSubview:_toggleButton];
    
    _container = [[UIView alloc]initWithFrame:CGRectZero];
    _container.backgroundColor = [UIColor blackColor];
    _container.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_container];
}

#pragma mark -
#pragma mark - constraints

- (void)updateConstraints {
    
    NSDictionary *metrics;
    NSString *constraintsString;
    NSArray *constraints;
    
    if (_toggleButton && _container) {
        
        metrics = @{@"margin_top":[NSNumber numberWithFloat:0],
                    @"margin_bottom":[NSNumber numberWithFloat:0],
                    @"margin_right":[NSNumber numberWithFloat:0],
                    @"button_width":[NSNumber numberWithFloat:_toggleButtonWidth]
                    };
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_toggleButton,_container);
        
        constraintsString = [NSString stringWithFormat:@"V:|[_toggleButton]|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
                                                              options:0
                                                              metrics:metrics
                                                                views:views];
        
        [self addConstraints:constraints];
        
        /**
         *  _container heigh
         */
        constraintsString = [NSString stringWithFormat:@"V:|[_container]|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
                                                              options:0
                                                              metrics:metrics
                                                                views:views];
        
        [self addConstraints:constraints];
        
        constraintsString = [NSString stringWithFormat:@"H:|[_container][_toggleButton(==button_width)]-margin_right-|"];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:constraintsString
                                                              options:0
                                                              metrics:metrics
                                                                views:views];
        
        [self addConstraints:constraints];
    }
    
    [super updateConstraints];
}

@end
