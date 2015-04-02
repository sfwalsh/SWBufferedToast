//
//  SWToastConstraintManager.h
//  LoginTest
//
//  Created by Stephen Walsh on 31/03/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWToast.h"
#import "SWBufferedToast.h"

@interface SWToastConstraintManager : NSObject

+ (NSLayoutConstraint*)applyViewConstraintsForToast:(SWToast *)toast
                                      andParentView:(SWBufferedToast *)parentView;

+ (void)applyBufferMaskConstraintsForImageView:(UIImageView *)imageView
                                       onToast:(SWToast *)toast;

+ (void)applyTitleConstraintsForLabel:(UILabel *)label
                              onToast:(SWToast *)toast;

+ (void)applySubtitleConstraintsForLabel:(UILabel *)label
                            toTitleLabel:(UILabel *)titleLabel
                                 onToast:(SWToast *)toast;

+ (void)applySubtitleConstraintsForLabel:(UILabel *)label
                            toTitleLabel:(UILabel *)titleLabel
                         andActionButton:(UIButton *)actionButton
                                 onToast:(SWToast *)toast;

+ (void)applyTextfieldConstraintsForUsernameField:(UITextField *)usernameField
                                     toTitleLabel:(UILabel *)titleLabel
                                          onToast:(SWToast *)toast;

+ (void)applyTextfieldConstraintsForPasswordField:(UITextField *)passwordField
                                  toUsernameField:(UITextField *)usernameField
                                          onToast:(SWToast *)toast;

+ (void)applyButtonConstraintsForButton:(UIButton *)button
                                onToast:(SWToast *)toast;

@end
