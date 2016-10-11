//
//  MHSlideMenuItem.m
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "MHSlideMenuItem.h"

@implementation MHSlideMenuItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{

    self = [super init];
    if (self) {
        if (title) {
            _title = title;
        }
        if (image) {
            _icon = image;
        }
        if (selectedImage) {
            _selectedIcon = selectedImage;
        }
    }
    return self;
}



@end
