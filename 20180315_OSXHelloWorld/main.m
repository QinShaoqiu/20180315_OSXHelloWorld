//
//  main.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/15.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    NSApplication *app = [NSApplication sharedApplication];
    id delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    
    return NSApplicationMain(argc, argv);
}
