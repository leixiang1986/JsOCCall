//
//  main.m
//  jstest
//
//  Created by mac on 2018/1/28.
//  Copyright © 2018年 leixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        NSString *str = @"http://www.baidu.com/img/美女#/123.png";
        //过期方法
        NSString *replace = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //替代上面方法
       NSString *remove = [str stringByRemovingPercentEncoding];
        //过期方法
        NSString *addcode_add = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //替代上面方法,对#,/等符号进行编码
        NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
        NSLog(@"replace:%@\n remove:%@\n addcode:%@\n result:%@",replace,remove,addcode_add,result);
        
        
        
    }
    return 0;
}

//+(NSString*)urlEncode:(NSString*)str {
//    //different library use slightly different escaped and unescaped set.
//    //below is copied from AFNetworking but still escaped [] as AF leave them for Rails array parameter which we don't use.
//    //https://github.com/AFNetworking/AFNetworking/pull/555
//    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, CFSTR("."), CFSTR(":/?#[]@!$&'()*+,;="), kCFStringEncodingUTF8);
//    return result;
//}

