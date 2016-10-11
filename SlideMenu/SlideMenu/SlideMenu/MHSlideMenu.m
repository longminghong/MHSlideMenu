//
//  MHSlideMenu.m
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "MHSlideMenu.h"

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

CGFloat const defaultToggleButtonWidth = 20.0f;
CGFloat const defaultMHSlideMenuHeigh = 60.0f;


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
}

@end
