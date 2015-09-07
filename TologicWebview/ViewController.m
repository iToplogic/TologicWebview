//
//  ViewController.m
//  TologicWebview
//
//  Created by toplogic on 2015. 9. 7..
//  Copyright (c) 2015년 toplogic. All rights reserved.
//




#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *toplogicWebview;

@end





/*
 <script language="JavaScript">
 <!--
	function login(){
 var jsonParam = '{"type":"LOGIN","user_id":"itunes","token":"8QO4EuRml11CwJUV+lrK2uqIxrI50Wo2PHlmevc898P9WxvWQzLQ/Ff6dOD19MNKK9+iqK37qv/XpiBIM4zQTC+7VjvI/hcGMbt+vLpP0fDXQxHBWxCL65faV3iiL9M9","is_login":"TRUE"}';
 loginF(jsonParam);
 }
 
	function requestLoginCallback(){
 
 if(__ostype__ == "ios"){
 closeForcePopupActivity();
 
 }else{
 closePopupActivity('','Y');
 }
	}
 
 -->
 </script>

*/

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    NSURL *uri = [NSURL fileURLWithPath:[self getFilePath]];
    [_toplogicWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[[uri absoluteString] stringByAppendingString: @"?"] stringByAppendingString: [uri absoluteString]]]]];
    
    
    /*
    NSString *encodedString=[zzzz stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *myURL = [NSURL URLWithString:encodedString];
    NSURLRequest *myURLReq = [NSURLRequest requestWithURL:myURL];
    [_toplogicWebview loadRequest:myURLReq];
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *) getFilePath
{
    return [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    
}



- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"----------------------페이지변동끝----------------------");
    
    
}
 
 

#pragma mark -
#pragma mark UIWebviewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    NSURL    * url      = [request URL];
    NSString * host     = [url host];
    NSString * absoluteString = [url absoluteString];
    NSString * scheme   = [url scheme];
    
    NSString *urlString = [[request URL] absoluteString];
    
    NSLog(@"1. url = %@",url );
    
    NSLog(@"2. host = %@",host );
    
    NSLog(@"3. absoluteString = %@",absoluteString);
    
    NSLog(@"4. scheme = %@",scheme);
    
    NSLog(@"5. urlString = %@",urlString);
    
    
    NSString * json = [[absoluteString substringFromIndex:[scheme length] + 3] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     NSLog(@"6. 시즌1방법 = %@",json);
    
    
    if ([urlString rangeOfString:@"usedMarket://"].location != NSNotFound) {
         
         NSString *needle = [urlString componentsSeparatedByString:@"usedMarket://"][1];
        
         NSLog(@"needle : %@", needle);
         
         NSString *newNeedle = [needle stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
         NSLog(@"newNeedle : %@", newNeedle);
         
         NSData *data = [newNeedle dataUsingEncoding:NSUTF8StringEncoding];
         
         id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

         NSLog(@"3333333333333json : %@", json);
        
         return NO;
         
    }
    


   return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error %@", error);
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
}



@end
