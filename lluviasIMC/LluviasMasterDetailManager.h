//
//  LluviasMasterDetailManager.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LluviasMasterDetailManager : NSObject<UISplitViewControllerDelegate,UITabBarControllerDelegate>

-(id)initWithSplitViewController:(UISplitViewController*)splitViewController;

@end
