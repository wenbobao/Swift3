//
//  ViewController.m
//  LearnSwiftLanguage
//
//  Created by bob on 16/11/9.
//  Copyright © 2016年 __company__. All rights reserved.
//

#import "BookViewController.h"
#import "BookTitleCell.h"
#import <SafariServices/SafariServices.h>
#import "YDHTTPSessionManager.h"

@interface BookViewController ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"swift基础语法";
    [self.tableView registerNib:[UINib nibWithNibName:@"BookTitleCell" bundle:nil] forCellReuseIdentifier:@"BookTitleCell"];
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    self.dataSource = data[@"swift"];
    
//    [[YDHTTPSessionManager sharedManager]requestDataWithPath:@"https://www.cnswift.org/" andBlock:^(id data, NSError *error) {
//        NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"html = %@",retStr);
//    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTitleCell" forIndexPath:indexPath];
    cell.name.text = self.dataSource[indexPath.row][@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL *url = [NSURL URLWithString:self.dataSource[indexPath.row][@"url"]];
    
    [self presentViewController:[[SFSafariViewController alloc]initWithURL:url] animated:YES completion:NULL];
    
}

@end
