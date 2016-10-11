//
//  MHSlideMenuItem.h
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHSlideMenuItem : UIControl

@property (nonatomic,assign) id target;
@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,strong) UIColor *selectedColor;


@end
