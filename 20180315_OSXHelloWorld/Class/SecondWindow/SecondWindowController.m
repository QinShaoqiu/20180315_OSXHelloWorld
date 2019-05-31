//
//  SecondWindowController.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/15.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import "SecondWindowController.h"
#import "AppDelegate.h"
#import "ThirdWindowController.h"

@interface SecondWindowController ()
@property (nonatomic, strong) ThirdWindowController *nextVC;

@end

@implementation SecondWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.title = @"第二个页面";
    
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
    
    NSButton *button2 = [[NSButton alloc] initWithFrame:NSMakeRect(0, 100, 100, 100)];
    button2.title = @"下一页";
    button2.wantsLayer = YES ;
    button2.layer.backgroundColor = [NSColor orangeColor].CGColor ;
    button2.target = self;
    button2.action = @selector(buttonClick2:);
    [self.window.contentView addSubview:button2];
}

- (void)buttonClick:(NSButton *)sender{
    NSLog(@"返回");
  
    // 通过代理设置主窗口
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    [self.window close];
    [delegate.mainWindowController.window center];
    [delegate.mainWindowController.window makeKeyAndOrderFront:nil];
}

- (void)buttonClick2:(NSButton *)sender{
    NSLog(@"下一页");
    
    // 不把下一页设置成属性，那么下一页就不能返回到这一页。
    // ThirdWindowController *nextVC  = [[ThirdWindowController alloc] initWithWindowNibName:@"ThirdWindowController"];
    
    _nextVC  = [[ThirdWindowController alloc] initWithWindowNibName:@"ThirdWindowController"];
    
    // 显示下一个接口
    [_nextVC.window orderFront:nil];
    
    // 关闭当前窗口
    [self.window orderOut:nil];
}

@end
