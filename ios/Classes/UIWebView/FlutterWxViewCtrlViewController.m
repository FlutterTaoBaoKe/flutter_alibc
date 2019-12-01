//
//  FlutterWxViewCtrlViewController.m
//  flutter_alibc
//
//  Created by 吴兴 on 2019/10/22.
//

#import "FlutterWxViewCtrlViewController.h"

@interface FlutterWxViewCtrlViewController ()
@property(nonatomic,assign)int num;
@end

@implementation FlutterWxViewCtrlViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.num = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUrl:) name:@"getUrl" object:nil];
//    跳转到别的页面
    [self.navigationController pushViewController:self.vc animated:YES];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    self.num = self.num + 1;
    if (self.num == 2) {
        NSLog(@"该关闭了");
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
               NSLog(@"执行dismiss回调");
        }];
    }
}
//- (void)getUrl:(NSNotification *) notification {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    NSLog(@"写入Url");
//    self.url = notification.object;
//}
- (void)dealloc{
    NSLog(@"dealloc执行");
//    self.urlBlock(self.url);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
