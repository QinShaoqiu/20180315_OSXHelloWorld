//
//  TestModel.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/30.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (instancetype)initWithTitle:(NSString *)title rowIndex:(NSInteger)index{
    if (self = [super init]) {
        self.title = title;
        self.rowIndex = index;
    }
    return self;
}

@end
