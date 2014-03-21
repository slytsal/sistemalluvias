//
//  LluviasDetailViewController.h
//  lluviasIMC
//
//  Created by imc developer 01 on 19/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "KMLParser.h"
#import "LluviasAppDelegate.h"
#import "LluviasGraphicsTableViewController.h"
#import "LluviasMasterDetailManagerDelegate.h"
//#import <GoogleMaps/GoogleMaps.h>

// El delegado es necesario por que el boton que muestra el split, esta en la navigationBar del detalle
@interface LluviasDetailViewController : UIViewController <UISplitViewControllerDelegate, LluviasMasterDetailManagerDelegate, MKMapViewDelegate> {
    KMLParser *kmlParser;
}

//@property GMSMapView *mapView_;
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property LluviasAppDelegate *appLluviasDelegate;
@property (strong, nonatomic) LluviasGraphicsTableViewController *lluviasGraphicsViewController;
@property (weak, nonatomic)id<LluviasDetailViewDelegate> delegateDetail;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) IBOutlet MKMapView *mapView_;


@end
