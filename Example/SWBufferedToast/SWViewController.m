//
//  SWViewController.m
//  SWBufferedToast
//
//  Created by Stephen Walsh on 04/02/2015.
//  Copyright (c) 2014 Stephen Walsh. All rights reserved.
//

#import "SWViewController.h"

@interface SWViewController ()

@property (nonatomic, strong) SWBufferedToast *plainToast;

@property (nonatomic, readonly) UIColor *eggshellGreen;
@property (nonatomic, readonly) UIColor *ectoplasmGreen;
@property (nonatomic, readonly) UIColor *candyCaneRed;
@property (nonatomic, readonly) UIColor *jarringBlue;

@property (nonatomic, readonly) NSString *longRamble;
@property (nonatomic, readonly) NSString *sheepleResponse;
@property (nonatomic, readonly) NSString *jam;

@end

@implementation SWViewController


#pragma mark - setup
- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - nice colours.
- (UIColor *)eggshellGreen
{
    return [UIColor colorWithRed:114.0f/255.0f green:209.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
}

- (UIColor *)ectoplasmGreen
{
    //Mmmmmm, tastes like spooks.
    return [UIColor colorWithRed:114.0f/255.0f green:209.0f/255.0f blue:192.0f/255.0f alpha:0.75f];
}

- (UIColor *)candyCaneRed
{
    return [UIColor colorWithRed:211.0f/255.0f green:59.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
}

- (UIColor *)jarringBlue
{
    return [UIColor colorWithRed:0.0f/255.0f green:176.0f/255.0f blue:193.0f/255.0f alpha:0.75f];
}


#pragma mark - strings
- (NSString *)longRamble
{
    return @"Did you know that breakfast is the most important meal of the day? Why don't you go to your kitchen right now and have some breakfast.";
}

- (NSString *)sheepleResponse
{
    return @"Okay, I'll do that.";
}

- (NSString *)jam
{
    return @"Waiting for user to apply jam...";
}


#pragma mark - lethargic loaders
- (SWBufferedToast *)plainToast
{
    if (!_plainToast) {
        //Create a plain toast type. This toast is dismissable by swiping up and has an action button.
        //Implement the SWBufferedToastDelegate protocol to be notified of when the user taps the action button.
        _plainToast = [[SWBufferedToast alloc] initPlainToastWithTitle:@"Hello"
                                                              subtitle:self.longRamble
                                                      actionButtonText:self.sheepleResponse
                                                       backgroundColor:self.ectoplasmGreen
                                                            toastColor:self.eggshellGreen
                                                   animationImageNames:nil
                                                           andDelegate:self
                                                                onView:self.view];
    }
    
    return _plainToast;
}


#pragma mark - SWBufferedToastDelegate implementation
- (void)didTapActionButton
{
    [self.plainToast dismiss];
    
    /**
     Display a notice toast type. This toast cannot be dismissed by the user and can either be dismissed when a task
     is completed (by calling [toast dismiss]) or after a timer has completed.
     **/
    
    SWBufferedToast *noticeToast = [[SWBufferedToast alloc] initNoticeToastWithTitle:@"Get Your Toast"
                                                                            subtitle:self.jam
                                                                       timeToDisplay:10.0
                                                                    backgroundColour:self.jarringBlue
                                                                          toastColor:self.candyCaneRed
                                                                 animationImageNames:nil
                                                                              onView:self.view];
    [noticeToast appear];
    
    //Show the buffering state. You can supply your own images for the animation; if you don't a default animation will be used.
    [noticeToast beginLoading];
}

- (void)didAttemptLoginWithUsername:(NSString *)username
                        andPassword:(NSString *)password
{
    //Returns the values the user entered for their username and password. You should probably attempt a login at this point.
}

- (void)didDismissToastView
{
    //Called when a toast has been dismissed.
}


#pragma mark - actions
- (IBAction)exampleButtonTapped:(id)sender
{
    [self.plainToast appear];
}

@end
