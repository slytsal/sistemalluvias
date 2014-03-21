//
//  LluviasSettingsTableViewController.h
//  lluviasIMC
//
//  Created by imc developer 01 on 03/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LluviasMasterDetailManagerDelegate.h"
#import "LluviasDetailViewController.h"
#import "LluviasMasterDetailManagerDelegate.h"
#import "LluviasAppDelegate.h"

@interface LluviasSettingsTableViewController : UITableViewController

@property(strong, nonatomic) LluviasDetailViewController *lluviasDetailViewController;
@property(weak, nonatomic)id<LluviasMasterDetailManagerDelegate> delegate;

@end
