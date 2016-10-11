//
//  ViewController.m
//  SlideMenu
//
//  Created by longminghong on 16/10/11.
//  Copyright © 2016年 longminghong. All rights reserved.
//

#import "ViewController.h"

#import "MHSlideMenu.h"
#import "MHSlideMenuItem.h"

@interface ViewController ()

@property (nonatomic,strong) MHSlideMenu*menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    MHSlideMenuItem *item1 = [[MHSlideMenuItem alloc]initWithTitle:@"title1" image:[UIImage imageNamed:@"icon_favorite.png"] selectedImage:nil];
    MHSlideMenuItem *item2 = [[MHSlideMenuItem alloc]initWithTitle:@"title2" image:[UIImage imageNamed:@"icon_home"] selectedImage:nil];
    MHSlideMenuItem *item3 = [[MHSlideMenuItem alloc]initWithTitle:@"title3" image:[UIImage imageNamed:@"icon_search"] selectedImage:nil];
    MHSlideMenuItem *item4 = [[MHSlideMenuItem alloc]initWithTitle:@"title4" image:[UIImage imageNamed:@"icon_starred"] selectedImage:nil];
    
    _menu = [[MHSlideMenu alloc]initWithFrame:CGRectMake(0, 100, 300, 60)];
    [_menu.items addObject:item1];
    [_menu.items addObject:item2];
    [_menu.items addObject:item3];
    [_menu.items addObject:item4];
    _menu.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:_menu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
