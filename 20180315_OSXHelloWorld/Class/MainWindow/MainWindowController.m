//
//  MainWindowController.m
//  20180315_OSXHelloWorld
//
//  Created by shaoqiu on 2018/3/15.
//  Copyright © 2018年 shaoqiu. All rights reserved.
//

#import "MainWindowController.h"
#import "SecondWindowController.h"
#import "TestModel.h"

#define D_GrayColor3 [NSColor colorWithSRGBRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1]

@interface MainWindowController ()<NSTableViewDelegate, NSTableViewDataSource>
@property (nonatomic, strong) SecondWindowController *nextVC;
@property (nonatomic, strong) NSTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MainWindowController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

//此默认返回NO，当返回YES的时候，则坐标系变成左手坐标系，坐标原点变成左上角。
- (BOOL)isFlipped{
    return YES;
}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.window.title = @"hello world";
    
    [self initUI];
}


- (void)initUI{
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    
    //按钮
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(marginX, marginY, 100, 100)];
//    button.title = @"hello world";
    button.alignment = NSTextAlignmentCenter;//标题居中显示
    button.toolTip = @"提示信息";              //鼠标悬停上去可以添加提示信息
    button.wantsLayer = YES ;
    button.layer.backgroundColor = [NSColor orangeColor].CGColor;
    button.bezelStyle = NSRoundedBezelStyle;            //按钮样式
    button.bordered = YES;                              //是否显示背景 默认YES
    [button setButtonType:NSButtonTypeMomentaryPushIn]; //按钮的Type
    //button.image = [NSImage imageNamed:@"safari_icon"]; //设置图片
    button.transparent = NO;    //设置背景是否透明
    button.state = NSOffState;  //按钮初始状态
    button.highlighted = NO;    //按钮是否高亮
    button.target = self;
//    button.action = @selector(addNewCellInTableView:);//addNewCellInTableView
    button.action = @selector(buttonClick:);
    
    //标题的富文本
    NSMutableAttributedString *nameAttribute = [[NSMutableAttributedString alloc] initWithString:@"hello world"];
    NSRange range = NSMakeRange(0, 5);
    [nameAttribute addAttribute:NSForegroundColorAttributeName value:[NSColor redColor] range:range];
    [nameAttribute addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:18] range:range];
    [nameAttribute fixAttributesInRange:range];
    [button setAttributedTitle:nameAttribute];
    
    [self.window.contentView addSubview:button];
    
    //输入框和标签用的都是同一个控件
    NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(button.frame.origin.x + button.frame.size.width + marginX, button.frame.origin.y, 100, 100)];
    textField.wantsLayer = YES;//设置背景色，必须要有，不然无效
    textField.layer.backgroundColor = [NSColor redColor].CGColor;//背景色
    textField.stringValue = @"NSTextField hello,world";
    textField.textColor = [NSColor blueColor];
    textField.bezeled = NO ;
    textField.drawsBackground = NO ;
    textField.alignment = NSTextAlignmentCenter;
    textField.editable = NO ; // 是否可编辑,  YES,相当于UITextView ,  NO ,相当于 UILabel
    [self.window.contentView addSubview:textField];
    
    //图片
    NSImageView *imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(textField.frame.origin.x + textField.frame.size.width + marginX, button.frame.origin.y, 100, 100)];
    imageView.image = [NSImage imageNamed:@"safari_icon"];
    //imageView.image = [NSImage imageNamed:NSImageNamePathTemplate];//系统图
    imageView.imageAlignment = NSImageAlignCenter;
    imageView.imageScaling = NSImageScaleProportionallyDown;//填充模式
    imageView.editable = YES ; // 可以拖放图片上去, 想要知道图片被替换的事件,需要继承 NSImageView 然后重写 setImage 就可以了
    //设置圆角
    imageView.wantsLayer = YES;//必须要有，不然无效
    imageView.layer.cornerRadius = 50.0f;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 5;
    imageView.layer.borderColor = [NSColor orangeColor].CGColor;
    [self.window.contentView addSubview:imageView];
    
    //动图
    NSImageView *imageView2 = [[NSImageView alloc]initWithFrame:NSMakeRect(imageView.frame.origin.x + imageView.frame.size.width + marginX, button.frame.origin.y, 100, 100)];
    imageView2.wantsLayer = YES;//设置背景色，必须要有，不然无效
    imageView2.layer.backgroundColor = [NSColor yellowColor].CGColor;//背景色
    imageView2.imageFrameStyle = NSImageFrameNone; //图片边框的样式
    
    imageView2.imageScaling = NSImageScaleNone;
    imageView2.animates = YES;
    imageView2.image = [NSImage imageNamed:@"rabbit.gif"];//动图图片资源放在Assets.xcassets下无效的哦，要放在外面
    imageView2.canDrawSubviewsIntoLayer = YES;     //动图必备
    [self.window.contentView addSubview:imageView2];
    
    
    //ScrollView
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y + button.frame.size.height + marginY, 400, 300)];
    scrollView.hasVerticalScroller = YES;  // 1.1.有(显示)垂直滚动条
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.window.contentView addSubview:scrollView];
    
    TestModel *model = [[TestModel alloc] initWithTitle:@"model 1" rowIndex:0];
    TestModel *model2 = [[TestModel alloc] initWithTitle:@"model 2" rowIndex:1];
    TestModel *model3 = [[TestModel alloc] initWithTitle:@"model 3" rowIndex:2];
    TestModel *model4 = [[TestModel alloc] initWithTitle:@"model 4" rowIndex:3];
    TestModel *model5 = [[TestModel alloc] initWithTitle:@"model 5" rowIndex:4];
    [self.dataArr addObjectsFromArray:@[model, model2, model3, model4, model5]];
    
    
    //TableView
    _tableView = [[NSTableView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    _tableView.delegate = self;//代理 NSTableViewDelegate,NSTableViewDataSource
    _tableView.dataSource = self;
    [_tableView setAutosaveName:@"downloadTableView"];
    //[_tableView setAutoresizesSubviews:FULLSIZE];
    [_tableView setBackgroundColor:[NSColor whiteColor]];
    [_tableView setGridColor:[NSColor lightGrayColor]];
    [_tableView setGridStyleMask: NSTableViewSolidHorizontalGridLineMask];
//    [_tableView setUsesAlternatingRowBackgroundColors:YES];//行与行之间蓝白交替显示的背景，YES 显示，NO 不显示
    [_tableView setAutosaveTableColumns:YES];
    [_tableView setAllowsEmptySelection:YES];
    [_tableView setAllowsColumnSelection:YES];
    _tableView.usesAlternatingRowBackgroundColors = YES;//灰白相间效果
    [_tableView setGridStyleMask:(NSTableViewGridNone | NSTableViewGridNone)];//设置分隔线风格
    scrollView.contentView.documentView = _tableView;
//    [self.window.contentView addSubview:_tableView];
    
    //设置表头
    NSTableHeaderView *tableHeadView = [[NSTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 40)];
    tableHeadView.layer.backgroundColor = [NSColor orangeColor].CGColor;
    [_tableView setHeaderView:tableHeadView];
    
    //设定列，可以设定几列，而且可调
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"column"];
    [[column headerCell] setStringValue:@"column"];
    [[column headerCell] setAlignment:NSTextAlignmentCenter];
    [column setWidth:_tableView.frame.size.width];
    [column setMinWidth:50];
    [column setEditable:YES];
    [column setResizingMask:NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask];//拉大拉小窗口时会自动布局
    [_tableView addTableColumn:column];
    
    scrollView.contentView.documentView = _tableView;
}


- (void)buttonClick:(NSButton *)sender{
    NSLog(@"点我干嘛");
    self.nextVC  = [[SecondWindowController alloc] initWithWindowNibName:@"SecondWindowController"];
    
    //显示下一个接口
    [self.nextVC.window orderFront:nil];
    
    //关闭当前窗口
    [self.window orderOut:nil];
}


//- (void)drawRect:(NSRect)dirtyRect{
//    [super drawRect:dirtyRect];
//
//    [D_GrayColor3 setFill];
//    NSRectFill(dirtyRect);
//}


//行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataArr.count;
}


//行高
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60;
}


//每行的信息
-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    TestModel *model = self.dataArr[row];
    
    NSView *cellView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];

    NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 60)];
//    textField.wantsLayer = YES;//设置背景色，必须要有，不然无效
//    textField.layer.backgroundColor = [NSColor redColor].CGColor;//背景色
    textField.stringValue = model.title;
    textField.textColor = [NSColor blueColor];
    textField.bezeled = NO ;
    textField.drawsBackground = NO ;
    textField.alignment = NSTextAlignmentLeft;
    textField.editable = NO ;
    
    [cellView addSubview:textField];
    
    return cellView;
}


// table view 选中一行的时候，会调用这个方法
- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSInteger selectedRow = [_tableView selectedRow]; // 获取table view 的选中行号
    if (selectedRow >= 0) {
        TestModel *model = self.dataArr[selectedRow];
        NSLog(@"did selected cell title = %@", model.title);
        
        // 1. 删除数据模型
        [self.dataArr removeObject:model];
        
        // 2.删除选中的行
        [_tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:_tableView.selectedRow] withAnimation:NSTableViewAnimationSlideRight];
    }
}


- (void)addNewCellInTableView:(NSButton *)sender{
    TestModel *newModel = [[TestModel alloc] initWithTitle:@"model new" rowIndex:0];
    [self.dataArr addObject:newModel];
    
//    NSInteger newRowIndex = self.dataArr.count - 1;
    
    // 4. 在table view 中插入新行
//    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] withAnimation:NSTableViewAnimationEffectGap];
//
//    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:newRowIndex] byExtendingSelection:NO];
//    [self.tableView scrollRowToVisible:newRowIndex];
    
    [self.tableView reloadData];
}


@end
