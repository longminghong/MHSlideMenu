//
//  MHSlideMenuItem.h
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MHSlideMenuItemClick)(id selectedItem);

@interface MHSlideMenuItem : NSObject

@property (nonatomic,assign) id target;
@property (nonatomic,assign) SEL targetAction;
@property (nonatomic,assign) UIControlEvents events;

@property (nonatomic,strong) UIImage *icon;

@property (nonatomic,strong) UIImage *selectedIcon;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,strong) UIColor *selectedColor;

@property (nonatomic,strong) UIFont *font;

@property (nonatomic,copy) MHSlideMenuItemClick itemSelectedBlock;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

- (void)setSelectedBlock:(MHSlideMenuItemClick)block;

@end
