/*
 * WVWebView.h
 * 
 * Created by WindVane.
 * Copyright (c) 2017年 阿里巴巴-淘宝技术部. All rights reserved.
 */

#import <WindVaneCore/WVWebViewProtocol.h>
#import <WindVaneCore/WVWebViewDelegate.h>
#import <UIKit/UIKit.h>

@interface WVWebView : UIWebView <WVWebViewProtocol>

/*!
 * 挂载的归属源 UIViewController
 */
@property (nonatomic, weak) UIViewController * sourceViewController;

#pragma mark - Configuration

/**
 * 获取当前 WebView 加载页面的 title。
 */
@property (nonatomic, copy, readonly) NSString * title;

/**
 * 当前 WebView 是否启用 WebGL。
 *
 * @discussion 在应用切后台时自动关闭，切回前台后自动打开。
 * 关闭的话，会使 canvas.getContext('webgl') 返回 null，但是并不会停用已拿到的 WebGLRenderingContext 的功能。
 * 所以此开关仅能部分避免切后台后 JS 调用 WebGL 导致的 Crash，与 H5 的具体用法有关。
 */
@property (nonatomic, assign, getter=isWebGLEnabled) BOOL webGLEnabled;

#pragma mark - Delegate

/**
 * 当前 WebView 的委托。
 */
@property (nonatomic, weak) id<WVWebViewDelegate> windVaneDelegate;

#pragma mark - Life cycle

/**
 * [注意：必须在 ViewController 的 viewWillDisappear 中调用!!!] 释放 WebView 的服务。
 */
- (void)releaseWebViewService;

/**
 * [注意：必须在 ViewController 的 viewWillAppear 中调用!!!] 重新绑定 WebView 的服务。
 */
- (void)bindingWebViewService;

@end
