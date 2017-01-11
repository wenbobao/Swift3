//
//  BlogViewController.m
//  LearnSwiftLanguage
//
//  Created by bob on 16/12/12.
//  Copyright © 2016年 __company__. All rights reserved.
//

#import "BlogViewController.h"
#import "UITableViewController+DataHandle.h"
#import "UIWebView+JS.h"
#import "NSMutableArray+DataHandle.h"
#import <SafariServices/SafariServices.h>
#import "FakeSafariViewController.h"
#import "CellDataModel.h"
#import "BookTitleCell.h"

@interface BlogViewController ()

@property(nonatomic, strong) UIWebView *webview;
@property(nonatomic, strong) NSMutableArray *tableData;
@property(nonatomic, strong) NSString *key;

@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"知乎精选";
    self.key = @"Main";
    
    self.tableData = [[NSMutableArray alloc] init];
    
    self.webview = [[UIWebView alloc] init];
    self.webview.delegate = self;
    
    // 导航栏加入刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(requestContent)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTitleCell" bundle:nil] forCellReuseIdentifier:@"BookTitleCell"];
    
    // 加载本地数据
    self.tableData = [[NSMutableArray alloc] initWithArray: [self getContentFromDeviceWithKey:self.key]];
    [self.tableView reloadData];
    
    // 加载网页
    [self requestContent];
}

- (void)requestContent {
    NSURL* url = [[NSURL alloc] initWithString:@"http://www.zhihufans.com/history.php"];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [self.webview loadRequest:request];
}


#pragma mark - Web View
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // title 提示
    self.title = @"内容刷新中";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // title 提示
    self.title = @"知乎";
    // 从 webview 抓取内容
    NSArray *titles = [webView getZhiHuArticleTitles];
    NSArray *links = [webView getZhihuArticleLinks];
    // 处理抓取到的内容
    [self.tableData setByDataWithTitles:titles links:links];
    // 根据内容刷新页面
    [self reloadbyComparingDataWithTableView:self.tableView
                                     oldData:[self getContentFromDeviceWithKey:_key]
                                     newData:self.tableData
                                         key:self.key];
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTitleCell" forIndexPath:indexPath];
    cell.name.text = ((CellDataModel*)self.tableData[indexPath.row]).title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *urlString = ((CellDataModel*) self.tableData[indexPath.row]).link;
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    //https://www.zhihu.com/question/19943830
//    * 问题页面 `zhihu://questions/{id}`
//    * 回答 `zhihu://answers/{id}`
//    * 用户页 `zhihu://people/{id}`
    
    NSString *openString = [NSString stringWithFormat:@"zhihu://questions/%@",[urlString lastPathComponent]];
    NSURL *openURL = [[NSURL alloc] initWithString:openString];
    //先判断是否能打开该url
    if ([[UIApplication sharedApplication] canOpenURL:openURL]) {
        //打开url
        [[UIApplication sharedApplication] openURL:openURL];
    }else {
        if ([SFSafariViewController class]) {
            SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:url];
            [self presentViewController:safari animated:YES completion:nil];
        } else {
            FakeSafariViewController *safari = [[FakeSafariViewController alloc] initWithUrl:url];
            [self.navigationController pushViewController:safari animated:YES];
        }
    }
    
    // deselect
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
