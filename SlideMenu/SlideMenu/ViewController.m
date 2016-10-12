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
    
    self.view.backgroundColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    
    
    _menu = [[MHSlideMenu alloc]init];
    CGRect frame = CGRectMake(0, 100, 30, 60);
    [self.menu setFrame:frame];
    
    MHSlideMenuItem *item1 = [[MHSlideMenuItem alloc]initWithTitle:@"title1" image:[UIImage imageNamed:@"icon_favorite.png"] selectedImage:nil];
    MHSlideMenuItem *item2 = [[MHSlideMenuItem alloc]initWithTitle:@"title2" image:[UIImage imageNamed:@"icon_home"] selectedImage:nil];
    MHSlideMenuItem *item3 = [[MHSlideMenuItem alloc]initWithTitle:@"title3" image:[UIImage imageNamed:@"icon_search"] selectedImage:nil];
    MHSlideMenuItem *item4 = [[MHSlideMenuItem alloc]initWithTitle:@"title4" image:[UIImage imageNamed:@"icon_starred"] selectedImage:nil];
    
//    MHSlideMenuItemView *item1 = [[MHSlideMenuItemView alloc]init];
//    MHSlideMenuItemView *item2 = [[MHSlideMenuItemView alloc]init];
//    MHSlideMenuItemView *item3 = [[MHSlideMenuItemView alloc]init];
//    MHSlideMenuItemView *item4 = [[MHSlideMenuItemView alloc]init];
    
//    MHSlideMenuItem *item1 = [[MHSlideMenuItem alloc]init];
//    MHSlideMenuItem *item2 = [[MHSlideMenuItem alloc]init];
//    MHSlideMenuItem *item3 = [[MHSlideMenuItem alloc]init];
//    MHSlideMenuItem *item4 = [[MHSlideMenuItem alloc]init];
    
    [_menu addItems:@[item1,item2,item3,item4]];
    
     _menu.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_menu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
