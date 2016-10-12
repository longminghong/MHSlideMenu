//
//  MHSlideMenuItem.m
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "MHSlideMenuItem.h"

@interface MHSlideMenuItem()

@property (nonatomic,strong) UILabel *label;

@end

@implementation MHSlideMenuItem


//- (id)initWithCoder:(NSCoder *)aDecoder {
//    
//    self = [super initWithCoder:aDecoder];
//    
//    if (self) {
//        [self config];
//    }
//    return self;
//}
//
//- (id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//        [self config];
//    }
//    
//    return self;
//}
//
//- (instancetype)init{
//    
//    self = [super init];
//    
//    if (self) {
//        [self config];
//    }
//    return self;
//}
//- (void)config{
//    
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.autoresizesSubviews = YES;
//    self.clipsToBounds = YES;
//}
//
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage{
    
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
//
//- (void)layoutSubviews{
//
//    [super layoutSubviews];
//    
//    NSLog(@"%s",__FUNCTION__);
//    
//    if (nil == _label) {
//        _label = [[UILabel alloc] initWithFrame:self.frame];
//        
//        _label.backgroundColor = [UIColor redColor];
//        
//        [self addSubview:_label];
//    }
//    _label.text = _title;
//}

@end
