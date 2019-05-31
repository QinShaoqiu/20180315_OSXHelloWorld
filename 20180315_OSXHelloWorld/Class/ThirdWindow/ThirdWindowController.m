//
//  ThirdWindowController.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/15.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import "ThirdWindowController.h"
#import "AppDelegate.h"

@interface ThirdWindowController ()

@end

@implementation ThirdWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.title = @"第3个页面";
    
    [self initUI];
}

- (void)initUI{
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
    button.title = @"上一页";
    button.wantsLayer = YES ;
    button.layer.backgroundColor = [NSColor orangeColor].CGColor ;
    button.target = self;
    button.action = @selector(buttonClick:);
    [self.window.contentView addSubview:button];
}

- (void)buttonClick:(NSButton *)sender{
    NSLog(@"返回");
    
    [self.window close];
    
//    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
//    [delegate.mainWindow.window center];
//    [delegate.mainWindow.window makeKeyAndOrderFront:nil];
}

@end
