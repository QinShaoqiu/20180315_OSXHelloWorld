//
//  AppDelegate.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/15.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import "AppDelegate.h"
#import "APPIconClickViewController.h"

@interface AppDelegate ()<NSWindowDelegate>
@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSStatusItem *demoItem;  // 添加状态item属性
@property (nonatomic, strong) NSPopover *popover;      // 弹窗
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
    _mainWindowController.window.delegate = self;
    //显示在屏幕中心
    [[_mainWindowController window] center];

    //当前窗口显示
    [_mainWindowController.window orderFront:nil];
    
    
    // 创建NSStatusItem并添加到系统状态栏上
    self.demoItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    // 设置NSStatusItem 的图片
    NSImage *image = [NSImage imageNamed:@"settings"];
    [self.demoItem.button setImage: image];
    
    // 创建popover，并设置
    _popover = [[NSPopover alloc]init];
    _popover.behavior = NSPopoverBehaviorTransient;
    _popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    _popover.contentViewController = [[APPIconClickViewController alloc] initWithNibName:@"APPIconClickViewController" bundle:nil];
    
    // 为NSStatusItem 添加点击事件
    self.demoItem.target = self;
    self.demoItem.button.action = @selector(showMyPopover:);
    
    // 防止下面的block方法中造成循环引用
    __weak typeof (self) weakSelf = self;
    
    // 添加对鼠标左键进行事件监听
    // 如果想对其他事件监听也进行监听，可以修改第一个枚举参数： NSEventMaskLeftMouseDown | 你要监听的其他枚举值
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown handler:^(NSEvent * event) {
        if (weakSelf.popover.isShown) {
            // 关闭popover；
            [weakSelf.popover close];
        }
    }];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


/*、
 一、点击关闭时，同时移除Dock上的图标。有两种方法可以实现该功能。
 方法1：当关闭最后一个窗口时，退出app
 */
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return NO;//YES-窗口程序两者都关闭，NO-只关闭窗口；
}


/**
 方法2：遵循NSWindowDelegate代理，实现代理方法windowShouldClose。
 关闭窗口时，退出程序.
 */
#pragma mark - NSWindowDelegate
-(BOOL)windowShouldClose:(id)sender {
    [self.mainWindowController.window orderOut:nil];//窗口消失
//    exit(0);                                      //退出程序。只关闭窗口，不退出程序，注释这句即可
    return NO;
}


/*
 二，点击Dock栏重启。如果在标题栏点击关闭，点击dock，程序不会自动跳出来，这时候，需要在delegate.m 中
 实现 applicationShouldHandleReopen:hasVisibleWindows: 方法。
 */
-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    NSLog(@"hasVisibleWindows:%d",flag);
    
    [NSApp activateIgnoringOtherApps:NO];                       //取消其他程序的响应
    [self.mainWindowController.window makeKeyAndOrderFront:self];//主窗口显示自己方法一
    //[_mainWindow orderFront:nil];                              //主窗口显示自己方法二
    
    return YES;
}


// 显示popover方法
- (void)showMyPopover:(NSStatusBarButton *)button{
    [_popover showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];
}


@end
