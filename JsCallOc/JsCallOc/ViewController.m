//
//  ViewController.m
//  JsCallOc
//
//  Created by mac on 2018/1/28.
//  Copyright © 2018年 leixiang. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "WKWebViewController.h"

@interface ViewController ()<UIWebViewDelegate,WKNavigationDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"UIWebView 调用原生";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.webView.delegate = self;
//    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *pageSource = @"<!DOCTYPE html><html><head><title>title</title></head><body><h1>My Mobile phone</h1><p>Please enter deatails</p><form name=\"feedback\" method=\"post\" action=\"mailto:you@site.com\"><!-- From elements will go in here --></form><form name=\"inputform\"> <input type=\"button\" onClick=\"submitButton('My Test Parameter')\" value=\"submit\"> </form></body></html>";
    [self.webView loadHTMLString:pageSource baseURL:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"WKWebView实现" style:(UIBarButtonItemStylePlain) target:self action:@selector(next)];
    
    [self ocCallJs];
}

//oc调用js
- (void)ocCallJs {
    
    //oc中执行js方法，自建的或者后台传入的
    JSContext *context = [[JSContext alloc] init];
    //创建js函数
    NSString *jsMethod = @"function add(a,b) {return a + b}";
    //将js函数代码加入context当中，以便oc调用
    [context evaluateScript:jsMethod];
    //通过context获取add函数，通过callWithArguments方法传递参数
    //执行后把结果存在JSValue中
    JSValue *result = [context[@"add"] callWithArguments:@[@3,@5]];
    NSLog(@"result:%d",result.toInt32);
    
}



- (void)next {
    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    if (!context) {
        NSLog(@"没有context=======");
    }
    
    context[@"submitButton"] = ^(NSString *param1){
        NSLog(@"User clicked submit. param1=%@",param1);
    };
}



//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"完成了");
//    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
