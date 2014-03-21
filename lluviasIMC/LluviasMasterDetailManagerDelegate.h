//
//  LluviasMasterDetailManagerDelegate.h
//  lluviasIMC
//
//  Created by imc developer 01 on 03/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

@protocol LluviasMasterDetailManagerDelegate <NSObject>

@property (nonatomic, strong) UIBarButtonItem *splitViewButton;

@required
-(BOOL)moveToMapDetailView:(CLLocationCoordinate2D)pointDetailViewMap andNamePoint:(NSString *)namePointLocation;
// Funcion que "borrara" o volvera a "pintar" los puntos indicados por el usuario (Lumbreras, Estructuras, Estaciones o Isoyetas).
-(void)deleteMarkersInMap:(NSInteger)typeMarker andOnOff:(BOOL)switchOnOff;
-(void)deletePolygonsInMap:(NSInteger)typePolygon andOnOff:(BOOL)switchOnOff;

// Delegado para establecer el boton y mostrarlo.
-(void)setSplitViewController:(UIBarButtonItem *)splitViewButton forPopoverController:(UIPopoverController *)popoverController;
@end
