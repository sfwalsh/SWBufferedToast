//
//  SWToastConstraintManager.m
//  LoginTest
//
//  Created by Stephen Walsh on 31/03/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import "SWToastConstraintManager.h"

#define IPAD        UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IPHONE      UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

#define kPlainToastMultiplierWidth  (IPAD ? 0.5f : 0.7f);
#define kPlainToastMultiplerHeight  (IPAD ? 0.3f : 0.55f);
#define kLoginToastMultiplierWidth  (IPAD ? 0.7f : 0.9f);
#define kLoginToastMultiplierHeight (IPAD ? 0.25f : 0.50f);
#define kNoticeToastHeight          180.0f;
#define KNoticeToastWidth           300.0f;
#define kMultiplierBufferHeight     0.8f;
#define kLabelHeightTitle           40.0f;
#define kButtonHeightAction         70.0f;
#define kTextfieldHeightUsername    70.0f;
#define kTextfieldHeightPassword    70.0f;
#define kTextfieldTitleDistance     -10.0f;
#define kLoginToastHeight           (IPAD ? 220.0f : 200.0f);


@implementation SWToastConstraintManager

+ (NSLayoutConstraint*)applyViewConstraintsForToast:(SWToast *)toast
                                      andParentView:(SWBufferedToast *)parentView
{
    switch (toast.toastType) {
        case SWBufferedToastTypeLogin:
        {
            [parentView addSubview:toast];
            toast.translatesAutoresizingMaskIntoConstraints = NO;
            //Add view's constraints
            float width = kLoginToastMultiplierWidth;
            float height = kLoginToastHeight;
            NSLayoutConstraint *widthConstraint;
            
            if (IPAD) {
                widthConstraint    = [NSLayoutConstraint constraintWithItem:toast
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:0
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0f
                                                                   constant:300];
            }
            else{
                widthConstraint     = [NSLayoutConstraint constraintWithItem:toast
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:0
                                                                      toItem:parentView
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:width
                                                                    constant:0];
            }
            
            
            NSLayoutConstraint *heightConstraint    = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:0
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0f
                                                                                    constant:height];
            
            NSLayoutConstraint *constraintX         = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                  multiplier:1.0f
                                                                                    constant:0];
            
            NSLayoutConstraint *constraintY         = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeCenterY
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeCenterY
                                                                                  multiplier:1.0f
                                                                                    constant:-height];
            
            
            [parentView addConstraints:@[widthConstraint, heightConstraint, constraintX, constraintY]];
            return constraintY;
        }
            break;
            
        case SWBufferedToastTypeNotice:
        {
            [parentView addSubview:toast];
            toast.translatesAutoresizingMaskIntoConstraints = NO;
            //Add view's constraints
            float width = KNoticeToastWidth;
            float height = kNoticeToastHeight;
            NSLayoutConstraint *widthConstraint     = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:0
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0f
                                                                                    constant:width];
            
            NSLayoutConstraint *heightConstraint    = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:0
                                                                                      toItem:nil
                                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                                  multiplier:1.0f
                                                                                    constant:height];
            
            NSLayoutConstraint *constraintX         = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                  multiplier:1.0f
                                                                                    constant:0];
            
            NSLayoutConstraint *constraintY         = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeCenterY
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeCenterY
                                                                                  multiplier:1.0f
                                                                                    constant:-(parentView.frame.size.height+height)];
            
            
            [parentView addConstraints:@[widthConstraint, heightConstraint, constraintX, constraintY]];
            return constraintY;
        }
            break;
            
        default:
        {
            [parentView addSubview:toast];
            toast.translatesAutoresizingMaskIntoConstraints = NO;
            
            float width = kPlainToastMultiplierWidth;
            float height = kPlainToastMultiplerHeight;
            NSLayoutConstraint *widthConstraint     = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                   relatedBy:0
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeWidth
                                                                                  multiplier:width
                                                                                    constant:0];
            
            NSLayoutConstraint *heightConstraint    = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                   relatedBy:0
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeHeight
                                                                                  multiplier:height
                                                                                    constant:0];
            
            NSLayoutConstraint *constraintX         = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeCenterX
                                                                                  multiplier:1.0f
                                                                                    constant:0];
            
            NSLayoutConstraint *constraintY         = [NSLayoutConstraint constraintWithItem:toast
                                                                                   attribute:NSLayoutAttributeCenterY
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:parentView
                                                                                   attribute:NSLayoutAttributeCenterY
                                                                                  multiplier:1.0f
                                                                                    constant:-(parentView.frame.size.height*height)];
            
            
            [parentView addConstraints:@[widthConstraint, heightConstraint, constraintX, constraintY]];
            return constraintY;
        }
            break;
    }
    
    return nil;
}

+ (void)applyBufferMaskConstraintsForImageView:(UIImageView *)imageView
                                       onToast:(SWToast *)toast
{
    [toast insertSubview:imageView atIndex:0];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.userInteractionEnabled = NO;
    float height = kMultiplierBufferHeight;
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:0];
    
    NSLayoutConstraint *heightConstraint        = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeHeight
                                                                              multiplier:height
                                                                                constant:0];
    
    NSLayoutConstraint *topConstraint           = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1.0f
                                                                                constant:0.f];
    
    NSLayoutConstraint *leadingConstraint       = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeLeading
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeLeading
                                                                              multiplier:1.0f
                                                                                constant:0.f];
    
    [toast addConstraints:@[widthConstraint, heightConstraint, topConstraint, leadingConstraint]];
}

+ (void)applyTitleConstraintsForLabel:(UILabel *)label
                              onToast:(SWToast *)toast
{
    [toast addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.userInteractionEnabled = NO;
    float height = kLabelHeightTitle;
    
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:0];
    
    NSLayoutConstraint *heightConstraint        = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:0
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0f
                                                                                constant:height];
    
    NSLayoutConstraint *topConstraint           = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1.0f
                                                                                constant:10.f];
    
    NSLayoutConstraint *leadingConstraint       = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeLeading
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeLeading
                                                                              multiplier:1.0f
                                                                                constant:0.f];
    
    [toast addConstraints:@[widthConstraint, heightConstraint, topConstraint, leadingConstraint]];
}

+ (void)applySubtitleConstraintsForLabel:(UILabel *)label
                            toTitleLabel:(UILabel *)titleLabel
                                 onToast:(SWToast *)toast
{
    [toast addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:-20];
    
    NSLayoutConstraint *constraintX             = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0f
                                                                                constant:0];
    
    NSLayoutConstraint *topConstraint           = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:titleLabel
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:-30.f];
    
    NSLayoutConstraint *bottomConstraint        = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:-10.f];
    
    
    [toast addConstraints:@[widthConstraint, constraintX, topConstraint, bottomConstraint]];
}

+ (void)applySubtitleConstraintsForLabel:(UILabel *)label
                            toTitleLabel:(UILabel *)titleLabel
                         andActionButton:(UIButton *)actionButton
                                 onToast:(SWToast *)toast
{
    [toast addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.userInteractionEnabled = NO;
    
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:-20];
    
    NSLayoutConstraint *constraintX             = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0f
                                                                                constant:0];
    
    NSLayoutConstraint *topConstraint           = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:titleLabel
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:-30.f];
    
    NSLayoutConstraint *bottomConstraint        = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:actionButton
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:-20.f];
    
    
    [toast addConstraints:@[widthConstraint, constraintX, topConstraint, bottomConstraint]];
}

+ (void)applyTextfieldConstraintsForUsernameField:(UITextField *)usernameField
                                     toTitleLabel:(UILabel *)titleLabel
                                          onToast:(SWToast *)toast
{
    [toast addSubview:usernameField];
    usernameField.translatesAutoresizingMaskIntoConstraints = NO;
    usernameField.userInteractionEnabled = YES;
    float height = kTextfieldHeightUsername;
    float topDistance = kTextfieldTitleDistance;
    
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:usernameField
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:-20];
    
    NSLayoutConstraint *heightConstraint        = [NSLayoutConstraint constraintWithItem:usernameField
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:0
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0f
                                                                                constant:height];
    
    NSLayoutConstraint *constraintX             = [NSLayoutConstraint constraintWithItem:usernameField
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0f
                                                                                constant:0];
    
    NSLayoutConstraint *topConstraint           = [NSLayoutConstraint constraintWithItem:usernameField
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:titleLabel
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:topDistance];
    
    
    [toast addConstraints:@[widthConstraint, heightConstraint, constraintX, topConstraint]];
}

+ (void)applyTextfieldConstraintsForPasswordField:(UITextField *)passwordField
                                  toUsernameField:(UITextField *)usernameField
                                          onToast:(SWToast *)toast
{
    [toast addSubview:passwordField];
    passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    passwordField.userInteractionEnabled = YES;
    float height = kTextfieldHeightPassword;
    
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:passwordField
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:-20];
    
    NSLayoutConstraint *heightConstraint        = [NSLayoutConstraint constraintWithItem:passwordField
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:0
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0f
                                                                                constant:height];
    
    NSLayoutConstraint *constraintX             = [NSLayoutConstraint constraintWithItem:passwordField
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0f
                                                                                constant:0];
    
    NSLayoutConstraint *topConstraint           = [NSLayoutConstraint constraintWithItem:passwordField
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:usernameField
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:-30.f];
    
    
    [toast addConstraints:@[widthConstraint, heightConstraint, constraintX, topConstraint]];
}

+ (void)applyButtonConstraintsForButton:(UIButton *)button
                                onToast:(SWToast *)toast
{
    [toast addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.userInteractionEnabled = YES;
    float height = kButtonHeightAction;
    
    NSLayoutConstraint *widthConstraint         = [NSLayoutConstraint constraintWithItem:button
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:0
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1
                                                                                constant:-20];
    
    
    NSLayoutConstraint *heightConstraint        = [NSLayoutConstraint constraintWithItem:button
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:0
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0f
                                                                                constant:height];
    
    NSLayoutConstraint *constraintX             = [NSLayoutConstraint constraintWithItem:button
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1.0f
                                                                                constant:0];
    
    NSLayoutConstraint *bottomConstraint        = [NSLayoutConstraint constraintWithItem:button
                                                                               attribute:NSLayoutAttributeBottom
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:toast
                                                                               attribute:NSLayoutAttributeBottom
                                                                              multiplier:1.0f
                                                                                constant:0.0f];
    
    [toast addConstraints:@[widthConstraint, heightConstraint, constraintX, bottomConstraint]];
}


@end
