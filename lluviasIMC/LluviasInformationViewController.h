//
//  LluviasInformationViewController.h
//  lluviasIMC
//
//  Created by imc developer 01 on 19/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LluviasStationTableView.h"
#import "LluviasLumbrerasTableView.h"
#import "LluviasStructuresTableView.h"
#import "LluviasDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "LluviasLumbrerasViewCell.h"
#import "LluviasStationViewCell.h"
#import "LluviasStructuresViewCell.h"
#import "LluviasAppDelegate.h"

@interface LluviasInformationViewController : UITableViewController

@property (nonatomic, weak) IBOutlet LluviasStructuresTableView *tableViewStructure;
@property (nonatomic, weak) IBOutlet LluviasLumbrerasTableView *tableViewLumbreras;
@property (nonatomic, weak) IBOutlet LluviasStationTableView *tableViewStation;
@property (strong, nonatomic) LluviasDetailViewController *lluviasDetailViewController;
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property LluviasAppDelegate *appLluviasDelegate;
@property (weak, nonatomic)id<LluviasMasterDetailManagerDelegate> delegate;


- (IBAction)segmentValueChanged:(UISegmentedControl *)sender;


@end
