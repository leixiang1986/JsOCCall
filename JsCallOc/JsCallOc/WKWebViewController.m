//
//  WKWebViewController.m
//  JsCallOc
//
//  Created by mac on 2018/1/28.
//  Copyright © 2018年 leixiang. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WKWebView 调用原生";
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"removeNavigationBar"];
    [userContentController addScriptMessageHandler:self name:@"AddNavigationBar"];//添加导航栏
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    config.userContentController = [[WKUserContentController alloc] init];
//    [config.userContentController addScriptMessageHandler:self name:@"app"];
//    WKPreferences *preferences = [[WKPreferences alloc] init];
//    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    config.preferences = preferences;
//    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:config];
//    self.webView.UIDelegate = self;
//    self.webView.navigationDelegate = self;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
//    NSString *pageSource = @"<!DOCTYPE html><html><head><title>title</title></head><body><h1>My Mobile phone</h1><p>Please enter deatails</p><form name=\"feedback\" method=\"post\" action=\"mailto:you@site.com\"><!-- From elements will go in here --></form><form name=\"inputform\"> <input type=\"button\" onClick=\"submitButton('My Test Parameter')\" value=\"submit\"> </form></body></html>";
//    [self.webView loadHTMLString:pageSource baseURL:nil];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(20, 300, 50, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(runjs) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}


- (void)runjs {
    [self.webView evaluateJavaScript:@"alert('test')" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"执行结束");
    }];
    
    [self.webView evaluateJavaScript:@"haha" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"nihao");
    }];
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    //    URL = [NSURL URLWithString:@"mweeclient://menuOrderDetail?id=111"];
            decisionHandler(WKNavigationActionPolicyAllow);
    
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"js调用了:%@",message.name);
    
    
}



@end
