//
//  ViewController.m
//  getPDFdemo
//
//  Created by 施永辉 on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


/**
 *  另外一种从网络获取pdf 或者 pps 等格式的文件并展示
 *     联系方式 ： QQ 316643741
 *     请关注CSDN  http://blog.csdn.net/github_33362155
 *     简书 ：http://www.jianshu.com/users/d7047924cb9c/latest_articles
 */
//下载保存到沙盒
- (IBAction)down:(id)sender {
    //设置下载文件保存的目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* _filePath = [paths objectAtIndex:0];
    
    //这里是网上的一个pdf连接
    NSString* fileUrl = @"http://bmob-cdn-342.b0.upaiyun.com/2016/05/20/f1a18cb2445642dc922de1702e36f23f.pdf";
    
    //Encode Url 如果Url 中含有空格，一定要先 Encode
    fileUrl = [fileUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //创建 Request
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    NSString* fileName = @"down.pdf";
    NSString* filePath = [_filePath stringByAppendingPathComponent:fileName];
    
    //下载进行中的事件
    AFURLConnectionOperation *operation =   [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载的进度，如 0.53，就是 53%
        //        float progress =   (float)totalBytesRead / totalBytesExpectedToRead;
        
        //下载完成
        //该方法会在下载完成后立即执行
        //        if (progress == 1.0) {
        //            [downloadsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationAutomatic];
        //        }
    }];
    
    //下载完成的事件
    //该方法会在下载完成后 延迟 2秒左右执行
    //根据完成后需要处理的及时性不高，可以采用该方法
    [operation setCompletionBlock:^{
        
    }];
    
    [operation start];
    
    
}
//方法一查看
- (IBAction)one:(id)sender {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* filePath = [paths objectAtIndex:0];
    
    NSString* fileName = @"down.pdf";
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    
    NSString * ss = [path stringByRemovingPercentEncoding];
    NSURL *URL = [NSURL fileURLWithPath:ss];
    
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    
    // Configure Document Interaction Controller
    [self.documentInteractionController setDelegate:self];
    
    // Preview PDF
    [self.documentInteractionController presentPreviewAnimated:YES];
}
//方法二查看
- (IBAction)two:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* filePath = [paths objectAtIndex:0];
    
    NSString* fileName = @"down.pdf";
    NSString *path = [filePath stringByAppendingPathComponent:fileName];
    
    NSString * ss = [path stringByRemovingPercentEncoding];
    NSURL *URL = [NSURL fileURLWithPath:ss];
    
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    
    // Configure Document Interaction Controller
    [self.documentInteractionController setDelegate:self];
    
    // Preview PDF
    // Present Open In Menu
    [self.documentInteractionController presentOpenInMenuFromRect:[button frame] inView:self.view animated:YES];
}
#pragma mark Document Interaction Controller Delegate Methods
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}












@end
