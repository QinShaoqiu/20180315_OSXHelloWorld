//
//  APPIconClickViewController.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/15.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import "APPIconClickViewController.h"

@interface APPIconClickViewController ()

@end

@implementation APPIconClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(10, self.view.frame.size.height - 100 - 10, 100, 100)];
    button.title = @"hello world";
    button.wantsLayer = YES ;
    button.layer.backgroundColor = [NSColor orangeColor].CGColor ;
    button.target = self;
    button.action = @selector(quitAPP:);
    [self.view addSubview:button];
}

- (void)quitAPP:(NSButton *)sender{
    //完全退出程序
    [[NSApplication sharedApplication] terminate:self];
}


@end
