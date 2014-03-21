//
//  LluviasMasterDetailManager.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasMasterDetailManager.h"
#import "LluviasDetailViewController.h"
#import "LluviasInformationViewController.h"

@interface LluviasMasterDetailManager ()

@property (weak, nonatomic)UISplitViewController* splitViewController;
@property (weak, nonatomic)UIViewController* currentDetailController;
@property (weak, nonatomic)LluviasDetailViewController* lluviasDetailViewController;
@property (weak, nonatomic)LluviasInformationViewController* lluviasInformationViewController;

@property (strong, nonatomic)UIBarButtonItem* masterBarButtonItem;
@property (strong, nonatomic)UIPopoverController* masterPopoverController;

@end

@implementation LluviasMasterDetailManager
@synthesize splitViewController = __splitViewController;
@synthesize masterBarButtonItem = __masterBarButtonItem;
@synthesize masterPopoverController = __masterPopoverController;
@synthesize currentDetailController = __currentDetailController;
@synthesize lluviasDetailViewController, lluviasInformationViewController;

-(id)initWithSplitViewController:(UISplitViewController*)splitViewController {
    
    self = [super init];
    if (self) {
        __splitViewController = splitViewController;
        splitViewController.presentsWithGesture = NO;
        splitViewController.delegate = self;
        
        UITabBarController *tabBar = [splitViewController.viewControllers objectAtIndex:0];
        tabBar.delegate = self;
    }
    
    return self;
}

#pragma mark - UISplitViewControllerDelegate

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {

    UINavigationController *navController = [[[self splitViewController ] viewControllers ] lastObject];
    lluviasDetailViewController = [[navController viewControllers]firstObject];
    
    [lluviasDetailViewController setSplitViewController:barButtonItem forPopoverController:pc];
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    UINavigationController *navController = [[[self splitViewController] viewControllers] lastObject];
    lluviasDetailViewController = [[navController viewControllers] firstObject];
    
    [lluviasDetailViewController setSplitViewController:nil forPopoverController:nil];
    
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    
    BOOL response=YES;
    
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
        response=NO;
    }
    
    return response;
}


#pragma mark - UITabBarControllerDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    //tabBarController = [self.splitViewController.viewControllers objectAtIndex:0];
    //self.splitViewController.viewControllers = [NSArray arrayWithObject:tabBarController];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.splitViewController.delegate = self;
}

@end


















