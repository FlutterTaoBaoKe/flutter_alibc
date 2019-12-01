//
//  FlutterWxViewCtrlViewController.h
//  flutter_alibc
//
//  Created by 吴兴 on 2019/10/22.
//

#import <UIKit/UIKit.h>
#import "ALiTradeWebViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^UrlBlock) (NSString *url);
@interface FlutterWxViewCtrlViewController : UIViewController

@property(nonatomic,strong)ALiTradeWebViewController *vc;
//@property(nonatomic,copy) UrlBlock urlBlock;
//@property(nonatomic,copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
