//
//  SWBufferedToast.h
//  LoginTest
//
//  Created by Stephen Walsh on 30/03/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWToast.h"

@protocol SWBufferedToastDelegate <NSObject>

- (void)didTapActionButton;
- (void)didAttemptLoginWithUsername:(NSString*)username
                        andPassword:(NSString*)password;
- (void)didDismissToastView;

@end

@interface SWBufferedToast : UIView <SWPlainToastDelegate>

@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, weak) id <SWBufferedToastDelegate> delegate;

- (instancetype)initPlainToastWithTitle:(NSString*)title
                               subtitle:(NSString*)subtitle
                       actionButtonText:(NSString*)dismissButtonText
                        backgroundColor:(UIColor*)backgroundColor
                             toastColor:(UIColor*)toastColor
                    animationImageNames:(NSArray*)animationImageNames
                            andDelegate:(id)delegate
                                 onView:(UIView*)parentView;

- (instancetype)initLoginToastWithTitle:(NSString*)title
                          usernameTitle:(NSString*)usernameTitle
                          passwordTitle:(NSString*)passwordTitle
                              doneTitle:(NSString*)doneTitle
                       backgroundColour:(UIColor*)backgroundColor
                             toastColor:(UIColor*)toastColor
                    animationImageNames:(NSArray*)animationImageNames
                            andDelegate:(id)delegate
                                 onView:(UIView*)parentView;

- (instancetype)initNoticeToastWithTitle:(NSString*)title
                                subtitle:(NSString*)subtitle
                           timeToDisplay:(NSInteger)timeToDisplay
                        backgroundColour:(UIColor*)backgroundColor
                              toastColor:(UIColor*)toastColor
                     animationImageNames:(NSArray*)animationImageNames
                                  onView:(UIView*)parentView;

- (void)appear;
- (void)dismiss;
- (void)beginLoading;
- (void)endLoading;

@end
