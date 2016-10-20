//
//  TodayViewController.m
//  WidgetTest
//
//  Created by yan on 16/10/20.
//  Copyright © 2016年 yan. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WGTableCell.h"
#import "WGHeaderView.h"
#import "WGTopic.h"

#define widgetCount 3
#define tableRowH 80
@interface TodayViewController () <NCWidgetProviding,WGHeaderViewDelegate,WGTableCellDelegate>


@property(nonatomic,weak) WGHeaderView *headerView;
@property(nonatomic,strong)NSArray *hotTopicArr;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableHeadView];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupTableCellJosn];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    }else{
        [self setupTableCellJosn];
        [self addTableViewFooter];
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, tableRowH * self.hotTopicArr.count + 110);
    }
    
    
}
- (void)addTableHeadView{
    
    WGHeaderView *headerView = [[WGHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 110)];
    headerView.delegate_ = self;
    [self.view addSubview: headerView];
    self.headerView = headerView;
}
- (void)setupTableCellJosn{
    
    @try {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
            [param setObject:@"gettopics" forKey:@"action"];
            [param setObject:@"135644452322" forKey:@"EchoToken"];
            [param setValue:@"data" forKeyPath:@"type"];
            [param setValue:[NSString stringWithFormat:@"%i",widgetCount] forKeyPath:@"pagesize"];
            [param setValue:@"1" forKeyPath:@"pageindex"];
            [param setValue:@"" forKeyPath:@"username"];
            [param setValue:@"cF54141DC1FA8E736B45244428874CE46==" forKeyPath:@"token"];
            
            NSDictionary *headers = @{@"Content-Type":@"application/json; charset=utf-8",
                                      @"Accept":@"application/json"
                                      };
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURL *url = [NSURL URLWithString:[@"http://s1.mydical.com/v1/api.ashx?action=" stringByAppendingString:@"gettopics"]];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
            request.HTTPBody = [[NSString stringWithFormat:@"type=data&pagesize=%i&pageindex=1",widgetCount ] dataUsingEncoding:NSUTF8StringEncoding];
            request.allHTTPHeaderFields = headers;
            request.HTTPMethod = @"POST";
            NSError *error = nil;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
            request.HTTPBody = jsonData;
            
            
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSError *jsonError = nil;
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                if (!jsonError) {
                    NSMutableArray *mutArr = [NSMutableArray array];
                    for (NSDictionary *dict in jsonDict[@"list"]) {
                        
                        WGTopic *topic = [[WGTopic alloc] initWithDict:dict];
                        [mutArr addObject:topic];
                    }
                    self.hotTopicArr = mutArr;
                }
            }];
            // 启动任务
            [dataTask resume];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view layoutIfNeeded];
            });
        });
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
//    NCUpdateResultNewData   新的内容需要重新绘制视图
//    NCUpdateResultNoData    部件不需要更新
//    NCUpdateResultFailed    更新过程中发生错误
    completionHandler(NCUpdateResultNewData);
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{

    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        
        [self setupTableCellJosn];
        [self addTableViewFooter];
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, tableRowH * self.hotTopicArr.count + 110);
        
    }else{
        
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    }
}
- (void)addTableViewFooter{
    
    for (int i = 0; i < self.hotTopicArr.count; i ++) {
        CGFloat cellX = 5;
        CGFloat cellY = CGRectGetMaxY(self.headerView.frame);
        CGFloat cellW = [UIScreen mainScreen].bounds.size.width - cellX * 3;
        CGFloat cellH = tableRowH;
        WGTableCell *cell = [[WGTableCell alloc] initWithFrame:CGRectMake(cellX, cellY + cellH * i, cellW, cellH)];
        cell.cellH = tableRowH;
        cell.topic = self.hotTopicArr[i];
        cell.delegate_ = self;
        [self.view addSubview:cell];
    }
}
#pragma mark - WGTableCellDelegate
- (void)WGTableCell:(WGTableCell *)cell topic:(WGTopic *)topic{
    
    
    NSString *url_Str = [NSString stringWithFormat:@"medicalWdget://%@",topic.url ];
    
    NSURL *url = [NSURL URLWithString:url_Str];
    
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
        
    }];
}
#pragma mark - WGHeaderViewDelegate
- (void)WGHeaderView:(WGHeaderView *)headerView clickTag:(NSInteger)index{
    
    NSString *urlStr = [NSString stringWithFormat:@"medicalWdget://%li",index];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
        
        
    }];
}
@end
