//
//  TestModel.h
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/30.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger rowIndex;

- (instancetype)initWithTitle:(NSString *)title rowIndex:(NSInteger)index;

@end
