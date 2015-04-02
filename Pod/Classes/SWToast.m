//
//  SWToast.m
//  LoginTest
//
//  Created by Stephen Walsh on 30/03/2015.
//  Copyright (c) 2015 Stephen Walsh. All rights reserved.
//

#import "SWToast.h"
#import "SWToastConstraintManager.h"

static float const kToastCornerRadius               = 4.0f;
static float const kAnimationDurationDisappear      = 0.5f;
static float const kAnimationDurationAppear         = 1.0f;
static float const kAnimationDurationBuffer         = 2.0f;

static NSString * const kBufferImageMaskName        = @"BufferMask";
static NSString * const kBundlePath                 = @"SWBufferedToast";

@interface SWToast()

@property (nonatomic, weak) SWBufferedToast *parentView;

@property (nonatomic, readonly) NSArray *animationImageNames;
@property (nonatomic, strong) NSMutableArray *defaultAnimationImageNames;
@property (nonatomic, strong) NSMutableArray *userAnimationImageNames;

@property (nonatomic, strong) NSLayoutConstraint *constraintY;
@property (nonatomic, strong) UIImageView *bufferImage;
@property (nonatomic, strong) UIImageView *bufferImageMask;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation SWToast


#pragma mark - initializers
- (instancetype)initPlainToastWithColour:(UIColor *)color
                                   title:(NSString *)title
                                subtitle:(NSString *)subtitle
                             actionTitle:(NSString *)actionTitle
                     animationImageNames:(NSArray*)animationImageNames
                           plainDelegate:(id)delegate
                               andParent:(SWBufferedToast*)parentView
{
    self = [super init];
    
    if (self) {
        self.toastType = SWBufferedToastTypePlain;
        self.parentView = parentView;
        self.plainToastDelegate = delegate;
        
        self.backgroundColor = color;
        self.layer.cornerRadius = kToastCornerRadius;
        self.clipsToBounds = YES;
        
        
        self.userAnimationImageNames = [animationImageNames mutableCopy];
        self.titleLabel.text = title;
        self.subtitleLabel.text = subtitle;
        [self.actionButton setTitle:actionTitle forState:UIControlStateNormal];
    }
    
    return self;
}

- (instancetype)initLoginToastWithColour:(UIColor *)color
                                   title:(NSString *)title
                           usernameTitle:(NSString *)usernameTitle
                           passwordTitle:(NSString *)passwordTitle
                               doneTitle:(NSString *)doneTitle
                     animationImageNames:(NSArray *)animationImageNames
                           loginDelegate:(id)loginDelegate
                               andParent:(SWBufferedToast *)parentView
{
    self = [super init];
    
    if (self) {
        self.toastType = SWBufferedToastTypeLogin;
        self.parentView = parentView;
        self.loginToastDelegate = loginDelegate;
        
        self.backgroundColor = color;
        self.layer.cornerRadius = kToastCornerRadius;
        self.clipsToBounds = YES;
        
        self.userAnimationImageNames = [animationImageNames mutableCopy];
        self.titleLabel.text = title;
        self.usernameField.placeholder = usernameTitle;
        self.passwordField.placeholder = passwordTitle;
        [self.actionButton setTitle:doneTitle forState:UIControlStateNormal];
    }
    
    return self;
}

- (instancetype)initNoticeToastWithColour:(UIColor *)color
                                    title:(NSString *)title
                                 subtitle:(NSString*)subtitle
                      animationImageNames:(NSArray*)animationImageNames
                                andParent:(SWBufferedToast*)parentView
{
    self = [super init];
    
    if (self) {
        self.toastType = SWBufferedToastTypeNotice;
        self.parentView = parentView;
        
        self.backgroundColor = color;
        self.layer.cornerRadius = kToastCornerRadius;
        self.clipsToBounds = YES;
        
        self.userAnimationImageNames = [animationImageNames mutableCopy];
        self.titleLabel.text = title;
        self.subtitleLabel.text = subtitle;
    }
    
    return self;
}


#pragma mark - lazy loaders
- (NSBundle *)bundle
{
    if (!_bundle) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:kBundlePath ofType:@"bundle"];
        _bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return _bundle;
}

- (BOOL)loadingBlocksDismiss
{
    switch (self.toastType) {
        case SWBufferedToastTypeLogin:
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:24.0f];
    }
    
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.textColor = [UIColor whiteColor];
        _subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0f];
        _subtitleLabel.numberOfLines = -1;
    }
    
    return _subtitleLabel;
}

- (UITextField *)usernameField
{
    if (!_usernameField) {
        _usernameField = [[UITextField alloc] init];
        _usernameField.textAlignment = NSTextAlignmentCenter;
        _usernameField.textColor = [UIColor whiteColor];
        _usernameField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0f];
        [_usernameField setTintColor:[UIColor whiteColor]];
        _usernameField.delegate = self;
    }
    
    return _usernameField;
}

- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.textAlignment = NSTextAlignmentCenter;
        _passwordField.textColor = [UIColor whiteColor];
        _passwordField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0f];
        [_passwordField setSecureTextEntry:YES];
        [_passwordField setTintColor:[UIColor whiteColor]];
        _passwordField.delegate = self;
    }
    
    return _passwordField;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIButton alloc] init];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionButton setTitleColor:[self darkerColorForColor:self.backgroundColor] forState:UIControlStateDisabled];
        _actionButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
        [_actionButton addTarget:self action:@selector(didTapActionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _actionButton;
}

- (NSMutableArray *)defaultAnimationImageNames
{
    if (!_defaultAnimationImageNames) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterNoStyle;
        [formatter setMinimumIntegerDigits:4];
        
        _defaultAnimationImageNames = [[NSMutableArray alloc] init];
        
        for (int i = 1; i<101; i++) {
            NSString *imageNumber = [formatter stringFromNumber:[NSNumber numberWithInteger:i]];
            NSString *imageName = [NSString stringWithFormat:@"Bufferlines%@", imageNumber];
            [_defaultAnimationImageNames addObject:imageName];
        }
    }
    
    return _defaultAnimationImageNames;
}

- (NSArray *)animationImageNames
{
    if (!self.userAnimationImageNames) {
        return self.defaultAnimationImageNames;
    }
    else{
        return self.userAnimationImageNames;
    }
}

- (UIImageView *)bufferImageMask
{
    if (!_bufferImageMask) {
        UIImage *biMask = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[self.bundle URLForResource:kBufferImageMaskName withExtension:@"png"]]]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _bufferImageMask = [[UIImageView alloc] initWithImage:biMask];
        _bufferImageMask.tintColor = self.backgroundColor;
        _bufferImage.clipsToBounds = YES;
    }
    
    return _bufferImageMask;
}

- (UIImageView *)bufferImage
{
    if (!_bufferImage) {
        
        _bufferImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.animationImageNames.count; i++) {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self.bundle URLForResource:[self.animationImageNames objectAtIndex:i] withExtension:@"png"]]];
            [images addObject:[self imageWithColour:[self darkerColorForColor:self.backgroundColor] andImage:image]];
        }
        
        _bufferImage.animationImages = images;
        _bufferImage.animationDuration = kAnimationDurationBuffer;
        _bufferImage.animationRepeatCount = -1;
        _bufferImage.contentMode = UIViewContentModeScaleAspectFill;
        _bufferImage.clipsToBounds = YES;
        _bufferImage.tintColor = [self darkerColorForColor:self.backgroundColor];
    }
    
    return _bufferImage;
}


#pragma mark - actions
- (void)appear
{
    switch (self.toastType) {
        case SWBufferedToastTypeNotice:{
            [self appearAnimationNotice];
        }
            break;
        case SWBufferedToastTypeLogin:
        {
            [self appearAnimationLogin];
        }
            break;
        default:
        {
            [self appearAnimationDefault];
        }
            break;
    }
}

- (void)disappear
{
    switch (self.toastType) {
        case SWBufferedToastTypeNotice:{
            [self disappearAnimationNotice];
        }
            break;
        default:
        {
            [self disappearAnimationDefault];
        }
            break;
    }
}

- (void)showBuffer
{
    self.isLoading = YES;
    if (self.toastType == SWBufferedToastTypeLogin) {
        [self.usernameField setEnabled:NO];
        [self.passwordField setEnabled:NO];
        [self.actionButton setEnabled:NO];
    }
    [self showBufferAnimation];
    
}

- (void)hideBuffer
{
    self.isLoading = NO;
    if (self.toastType == SWBufferedToastTypeLogin) {
        [self.usernameField setEnabled:YES];
        [self.passwordField setEnabled:YES];
        [self.actionButton setEnabled:YES];
    }
    [self hideBufferAnimation];
    
}

- (void)didTapActionButton:(id)sender
{
    if(self.toastType == SWBufferedToastTypePlain){
        [self performNoticeAction];
    }
    else if (self.toastType == SWBufferedToastTypeLogin){
        [self performLoginAction];
    }
}

- (void)performNoticeAction
{
    [self.plainToastDelegate actionButtonTapped];
}

- (void)performLoginAction
{
    [self.loginToastDelegate loginButtonTappedWithUsername:self.usernameField.text andPassword:self.passwordField.text];
    [self updateLoginConstraintsToCenter];
    [self endEditing:YES];
}


#pragma mark - animation types
- (void)appearAnimationNotice
{
    self.alpha = 0;
    
    [self applyAllConstraints];
    [self layoutIfNeeded];
    self.constraintY.constant = 0;
    self.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:kAnimationDurationAppear
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:15.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         self.alpha = 1;
                     } completion:nil];
}

- (void)appearAnimationLogin
{
    [self applyAllConstraints];
    [self.usernameField becomeFirstResponder];
}

- (void)appearAnimationDefault
{
    [self applyAllConstraints];
    [self layoutIfNeeded];
    self.constraintY.constant = 0;
    [UIView animateWithDuration:kAnimationDurationAppear
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:15.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:nil];
}

- (void)disappearAnimationNotice
{
    self.alpha = 1;
    [UIView animateWithDuration:kAnimationDurationDisappear
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:15.0f
                        options:0
                     animations:^{
                         [self layoutIfNeeded];
                         self.transform = CGAffineTransformMakeScale(0.4, 0.4);
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
    
}

- (void)disappearAnimationDefault
{
    self.constraintY.constant = -self.parentView.frame.size.height;
    
    [UIView animateWithDuration:kAnimationDurationDisappear animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)showBufferAnimation
{
    if(self.animationImageNames){
        self.bufferImage.alpha = 0.0f;
        [SWToastConstraintManager applyBufferMaskConstraintsForImageView:self.bufferImageMask onToast:self];
        [SWToastConstraintManager applyBufferMaskConstraintsForImageView:self.bufferImage onToast:self];
        
        [self layoutIfNeeded];
        
        [UIView animateWithDuration:kAnimationDurationAppear animations:^{
            self.bufferImage.alpha = 1.0f;
            [self.bufferImage startAnimating];
        } completion:nil];
    }
}

- (void)hideBufferAnimation
{
    [UIView animateWithDuration:kAnimationDurationDisappear animations:^{
        self.bufferImage.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.bufferImage stopAnimating];
            [self.bufferImage removeFromSuperview];
            [self.bufferImageMask removeFromSuperview];
        }
    }];
}


#pragma constraints
- (void)applyAllConstraints
{
    self.constraintY = [SWToastConstraintManager applyViewConstraintsForToast:self andParentView:self.parentView];
    [SWToastConstraintManager applyTitleConstraintsForLabel:self.titleLabel onToast:self];
    if (self.toastType == SWBufferedToastTypePlain) {
        [SWToastConstraintManager applyButtonConstraintsForButton:self.actionButton onToast:self];
        [SWToastConstraintManager applySubtitleConstraintsForLabel:self.subtitleLabel toTitleLabel:self.titleLabel andActionButton:self.actionButton onToast:self];
    }
    else if (self.toastType == SWBufferedToastTypeLogin){
        [SWToastConstraintManager applyTextfieldConstraintsForUsernameField:self.usernameField toTitleLabel:self.titleLabel onToast:self];
        [SWToastConstraintManager applyTextfieldConstraintsForPasswordField:self.passwordField toUsernameField:self.usernameField onToast:self];
        [SWToastConstraintManager applyButtonConstraintsForButton:self.actionButton onToast:self];
    }
    else{
        [SWToastConstraintManager applySubtitleConstraintsForLabel:self.subtitleLabel toTitleLabel:self.titleLabel onToast:self];
    }
}

- (void)updateLoginConstraintsToCenter
{
    self.constraintY.constant = 0;
    [UIView animateWithDuration:kAnimationDurationAppear
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:15.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:nil];
}

- (void)updateLoginConstraintsForUsername
{
    [self layoutIfNeeded];
    self.constraintY.constant = -75;
    [UIView animateWithDuration:kAnimationDurationAppear
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:15.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:nil];
}

- (void)updateLoginConstraintsForPassword
{
    [self layoutIfNeeded];
    self.constraintY.constant = -95;
    [UIView animateWithDuration:kAnimationDurationAppear
                          delay:0
         usingSpringWithDamping:0.7f
          initialSpringVelocity:15.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:nil];
}


#pragma mark - UITextField delegate impl
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.usernameField) {
        [self updateLoginConstraintsForUsername];
    }
    else if (textField == self.passwordField){
        [self updateLoginConstraintsForPassword];
    }
}


#pragma mark - helpers
- (UIImage *)imageWithColour:(UIColor *) color andImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.1, 0.0)
                               green:MAX(g - 0.1, 0.0)
                                blue:MAX(b - 0.1, 0.0)
                               alpha:a];
    return [UIColor blackColor];
}


#pragma mark - cleanup
- (void)dealloc
{
    self.plainToastDelegate = nil;
    self.loginToastDelegate = nil;
}

@end
