//
//  SWBufferedToast.m
//  LoginTest
//
//  Created by Stephen Walsh on 30/03/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import "SWBufferedToast.h"

@interface SWBufferedToast()

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) SWToast *toastView;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) float firstY;
@property (nonatomic, assign) float firstX;
@property (nonatomic, assign) NSInteger timeToDisplay;

@property (nonatomic, strong) NSTimer *displayTimer;

@end


@implementation SWBufferedToast


#pragma mark - initializers
- (instancetype)initPlainToastWithTitle:(NSString *)title
                               subtitle:(NSString *)subtitle
                       actionButtonText:(NSString *)actionButtonText
                        backgroundColor:(UIColor *)backgroundColor
                             toastColor:(UIColor *)toastColor
                    animationImageNames:(NSArray *)animationImageNames
                            andDelegate:(id)delegate
                                 onView:(UIView *)parentView
{
    self = [super init];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.parentView = parentView;
        self.toastView = [[SWToast alloc] initPlainToastWithColour:toastColor
                                                             title:title
                                                          subtitle:subtitle
                                                       actionTitle:actionButtonText
                                               animationImageNames:animationImageNames
                                                     plainDelegate:self
                                                         andParent:self];
        
        self.delegate = delegate;
        [self.toastView addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (instancetype)initLoginToastWithTitle:(NSString *)title
                          usernameTitle:(NSString *)usernameTitle
                          passwordTitle:(NSString *)passwordTitle
                              doneTitle:(NSString *)doneTitle
                       backgroundColour:(UIColor *)backgroundColor
                             toastColor:(UIColor *)toastColor
                    animationImageNames:(NSArray *)animationImageNames
                            andDelegate:(id)delegate
                                 onView:(UIView *)parentView
{
    self = [super init];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.parentView = parentView;
        self.toastView = [[SWToast alloc] initLoginToastWithColour:toastColor
                                                             title:title
                                                     usernameTitle:usernameTitle
                                                     passwordTitle:passwordTitle
                                                         doneTitle:doneTitle
                                               animationImageNames:animationImageNames
                                                     loginDelegate:self
                                                         andParent:self];
        
        self.delegate = delegate;
        [self.toastView addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (instancetype)initNoticeToastWithTitle:(NSString *)title
                                subtitle:(NSString*)subtitle
                           timeToDisplay:(NSInteger)timeToDisplay
                        backgroundColour:(UIColor *)backgroundColor
                              toastColor:(UIColor *)toastColor
                     animationImageNames:(NSArray*)animationImageNames
                                  onView:(UIView *)parentView
{
    self = [super init];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.parentView = parentView;
        self.toastView = [[SWToast alloc] initNoticeToastWithColour:toastColor
                                                              title:title
                                                           subtitle:subtitle
                                                animationImageNames:nil
                                                          andParent:self];
        
        [self.toastView addGestureRecognizer:self.panGestureRecognizer];
        self.timeToDisplay = timeToDisplay;
    }
    return self;
}


#pragma mark - lazy loaders
- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
    }
    
    return _panGestureRecognizer;
}


#pragma mark - actions
- (void)appear
{
    self.alpha = 0;
    [self setupConstraints];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self.toastView appear];
            if (self.toastView.toastType == SWBufferedToastTypeNotice) {
                [self setupDismissTimer];
            }
        }
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        [self.toastView disappear];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [self.delegate didDismissToastView];
        }
    }];
}

- (void)setupDismissTimer
{
    if (self.timeToDisplay > 0) {
        self.displayTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeToDisplay
                                                             target:self
                                                           selector:@selector(dismissNoticeToast:)
                                                           userInfo:nil
                                                            repeats:NO];
    }
}

- (void)dismissNoticeToast:(id)sender
{
    [self.displayTimer invalidate];
    [self dismiss];
}

- (void)beginLoading
{
    [self.toastView showBuffer];
}

- (void)endLoading
{
    [self.toastView hideBuffer];
}

- (void)moveView:(id)sender
{
    if (!self.isLocked) {
        [self bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
        
        CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self];
        
        if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
            self.firstX = self.toastView.center.x;
            self.firstY = self.toastView.center.y;
        }
        
        translatedPoint = CGPointMake(self.firstX, self.firstY + translatedPoint.y);
        
        [self.toastView setCenter:translatedPoint];
        
        if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
            CGFloat velocityX = (0.2*[(UIPanGestureRecognizer*)sender velocityInView:self].x);
            
            CGFloat finalX = self.firstX;
            CGFloat finalY = self.firstY;
            
            if (self.toastView.isLoading && self.toastView.loadingBlocksDismiss) {
                CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;
                [UIView animateWithDuration:animationDuration+1
                                      delay:0
                     usingSpringWithDamping:0.25f
                      initialSpringVelocity:10.0f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     [[sender view] setCenter:CGPointMake(finalX, finalY)];
                                 } completion:nil];
            }
            else{
                if (self.toastView.center.y < (self.frame.size.height/2 - (self.frame.size.height/4))
                    && ((self.toastView.toastType == SWBufferedToastTypeLogin) || (self.toastView.toastType == SWBufferedToastTypePlain))) {
                    [self dismiss];
                }
                else{
                    CGFloat animationDuration = (ABS(velocityX)*.0002)+.2;
                    [UIView animateWithDuration:animationDuration+1
                                          delay:0
                         usingSpringWithDamping:0.25f
                          initialSpringVelocity:10.0f
                                        options:UIViewAnimationOptionCurveEaseOut
                                     animations:^{
                                         [[sender view] setCenter:CGPointMake(finalX, finalY)];
                                     } completion:nil];
                }
            }
        }
    }
    
}


#pragma mark - constraints
- (void)setupConstraints
{
    [self.parentView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint     = [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:0
                                                                              toItem:self.parentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.0
                                                                            constant:0];
    
    NSLayoutConstraint *heightConstraint    = [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:0
                                                                              toItem:self.parentView
                                                                           attribute:NSLayoutAttributeHeight
                                                                          multiplier:1.0
                                                                            constant:0];
    
    NSLayoutConstraint *leadingConstraint   = [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.parentView
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0f
                                                                            constant:0.f];
    
    NSLayoutConstraint *topConstraint       = [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.parentView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0f
                                                                            constant:0.f];
    
    
    [self.parentView addConstraints:@[widthConstraint, heightConstraint, topConstraint, leadingConstraint]];
}


#pragma mark - plain toast delegate impl
- (void)actionButtonTapped
{
    [self.delegate didTapActionButton];
}


#pragma mark - login toast delegate impl
- (void)loginButtonTappedWithUsername:(NSString *)username
                          andPassword:(NSString *)password
{
    [self.delegate didAttemptLoginWithUsername:username
                                         andPassword:password];
}


#pragma mark - cleanup
- (void)dealloc
{
    self.delegate = nil;
}

@end
