//
//  FlutterWxViewCtrlViewController.h
//  flutter_alibc
//
//  Created by 吴兴 on 2019/10/22.
//

#import <UIKit/UIKit.h>
#import "ALiTradeWebViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^AccessTokenBlock) (NSString *accessToken);
@interface FlutterWxViewCtrlViewController : UIViewController

@property(nonatomic,strong)ALiTradeWebViewController *vc;
@property(nonatomic,copy) AccessTokenBlock accessBlock;
@property(nonatomic,copy) NSString *accessToken;
@end

NS_ASSUME_NONNULL_END
