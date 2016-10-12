//
//  MHSlideMenu.h
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHSlideMenuItem;

typedef NS_ENUM(NSInteger,MHSlideMenuState) {

    MHSlideMenuStateClose,
    MHSlideMenuStateOpening,
    MHSlideMenuStateOpened,
};

typedef NS_ENUM(NSInteger,MHSlideMenuItemWidthStyle) {
    
    MHSlideMenuItemWidthStyleFixed,
    MHSlideMenuItemWidthStyleDynamic,
};


@interface MHSlideMenuItemView : UIControl

- (void)setMenuItem:(MHSlideMenuItem *)item;

@end

@interface MHSlideMenu : UIControl
/**
 *  by default, this slideMenu width as screen.
 */
@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat heigh;

@property (nonatomic,assign) CGFloat toggleButtonWidth;

@property (nonatomic,assign) MHSlideMenuState menuState;

@property (nonatomic,assign) MHSlideMenuItemWidthStyle itemWidthStyle;

+ (instancetype)initWithDefaultConfig;

- (void)addItems:(NSArray *)items;

- (void)toggleMenuOpen;

@end
