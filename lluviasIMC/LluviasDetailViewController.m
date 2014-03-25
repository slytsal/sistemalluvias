//
//  LluviasDetailViewController.m
//  lluviasIMC
//
//  Created by imc developer 01 on 19/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasDetailViewController.h"
#import "CAT_PUNTO_MEDICION.h"
#import "CAT_TIPO_PUNTO_MEDICION.h"
#import "LluviasCoreData.h"
#import "LluviasDetailViewDelegate.h"
#import <MapKit/MapKit.h>
#import "LluviasLumbreraAnnotation.h"
#import "LluviasEstructuraAnnotation.h"
#import "LluviasEstacionAnnotation.h"
#import "LluviasFacade.h"

//#import <GoogleMaps/GoogleMaps.h>
// esta es una prueba para gitHub
@interface LluviasDetailViewController ()

// valores para las etiquetas personalizadas de navigationBar.
@property (retain, nonatomic) UIView *btn;
@property (retain, nonatomic) UILabel *label_1;
@property (retain, nonatomic) UILabel *label_2;
@property (retain, nonatomic) UILabel *label_3;
@property (retain, nonatomic) UILabel *label_4;
// -----------------------------------------------------------

//@property (nonatomic, retain) NSMutableArray *markersArray;
@property (nonatomic, retain) NSMutableArray *markersArrayLumbreras;
@property (nonatomic, retain) NSMutableArray *markersArrayEstructuras;
@property (nonatomic, retain) NSMutableArray *markersArrayEstaciones;
@property (nonatomic, retain) NSMutableArray *pendingViewsForAnimation;
@property (strong, nonatomic) UITabBarController *tabBar;

@property (nonatomic,weak) UIBarButtonItem *barButtonItem_1;

// arreglos para kml.
@property (nonatomic, retain) NSArray *overlays;
@property (nonatomic, retain) NSArray *annotations;

// Isoyeta
-(void)drawPolygon;
-(void)loadKML;
-(void)drawMarkersInViewDetail:(NSString *)namePointLocation;
-(UIColor *)colorWithHex:(UInt32)col;
-(UIColor*)colorWithHexString:(NSString*)hex;

// Inicializar mapa
-(void)initilalizeiOSMaps;
//-(NSArray *)readExistPuntosMedicion;
@end

@implementation LluviasDetailViewController
//@synthesize mapView_; //markersArray;
@synthesize markersArrayLumbreras, markersArrayEstructuras, markersArrayEstaciones, pendingViewsForAnimation;
@synthesize managedObjectContext, appLluviasDelegate;
@synthesize  mapView_;
@synthesize overlays, annotations;
// valores para las isoyetas, desapareceran
//@synthesize polygon, polygon1, polygon2, polygon3, polygon4;
// ------------------------------------------------
// valores para las etiquetas personalizadas de navigationBar.
@synthesize btn, label_1, label_2, label_3;
//-------------------------------------------------------------
@synthesize lluviasGraphicsViewController, tabBar;

@synthesize splitViewButton = _splitViewButton;

/*-(void)readFileCSV {
    LluviasFacade *facade = [[LluviasFacade alloc] init];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"cat_punto_medicion" ofType:@"csv"];
    NSString *entireFileInString = [NSString stringWithContentsOfFile:path ]; // reads file into memory as an NSString
    NSArray *lines = [entireFileInString componentsSeparatedByString:@"\r"]; // each line, adjust character for line endings
    for (NSString *line in lines) {
        NSArray *array = [line componentsSeparatedByString:@","];
        [facade insertCATPUNTOMEDICION:array];
        array = nil;
    }
}*/

-(void)loadKML {
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Contornos_Isoyetas" ofType:@"kml"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"KML_Sample" ofType:@"kml"];
    
    // El archivo no muestra nada.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_15" ofType:@"kml"];
    // El archivo no muestra nada (LineString)
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_15b" ofType:@"kml"];
    
    // Estos archivos funcionan cuando los abro con google earth y despues los abro los ios maps.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_30" ofType:@"kml"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_30+" ofType:@"kml"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_30+b" ofType:@"kml"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_8b" ofType:@"kml"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_8" ofType:@"kml"];
    
    // Pinta bien los contornos de las isoyetas.
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"isop_200409262334_30b" ofType:@"kml"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"example1" ofType:@"kml"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_polygon_test2-4" ofType:@"kml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    kmlParser = [[KMLParser alloc] initWithURL:url];
    [kmlParser parseKML];
    
    overlays = [kmlParser overlays];
    [mapView_ addOverlays:overlays];
    
    annotations = [kmlParser points];
    [mapView_ addAnnotations:annotations];
    
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKOverlay> overlay in overlays) {
        if (MKMapRectIsNull(flyTo)) {
            flyTo = [overlay boundingMapRect];
        } else {
            flyTo = MKMapRectUnion(flyTo, [overlay boundingMapRect]);
        }
    } // FIN for
    
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    } // FIN for
    
    mapView_.visibleMapRect = flyTo;
}

-(void)initilalizeiOSMaps {
    
    
    //Set a few MKMapView Properties to allow pitch, building view, scroll and zooming.
    self.mapView_.pitchEnabled = YES;
    self.mapView_.showsBuildings = YES;
    self.mapView_.zoomEnabled = YES;
    self.mapView_.zoomEnabled = YES;
    self.mapView_.scrollEnabled = YES;
    
    self.view = mapView_;
    self.mapView_.delegate = self;
}

-(void)initializeCameraiOSMaps {
    // Coordenadas del centro de la ciudad de mexico.
    double latitude = 19.43345;
    double longitude = -99.134209;
    
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(latitude, longitude);
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(latitude, longitude);
    // La altitud de la camara esta en metros, por eso hacemos la conversion a km, recordar que 1000m equivale a 1km.
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye eyeAltitude: (1000 * 100)];
    self.mapView_.camera = camera;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initilalizeiOSMaps];
    [self loadKML];
    [self initializeCameraiOSMaps];
    //[self readFileCSV];
    
    [[UIApplication sharedApplication] setStatusBarStyle:[self preferredStatusBarStyle]];

    tabBar = [self.splitViewController.viewControllers objectAtIndex:0];
    //tabBar = [self.splitViewController.viewControllers objectAtIndex:0];
    UINavigationController *uiNav = (UINavigationController *)tabBar.viewControllers[0];
    self.lluviasGraphicsViewController = (LluviasGraphicsTableViewController *)[uiNav.viewControllers lastObject];
    self.delegateDetail = lluviasGraphicsViewController;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.opaque = NO;
    
    // DATOS: conectamos el managedObjectContext al objeto actual -----
    appLluviasDelegate = [UIApplication sharedApplication].delegate;
    managedObjectContext = appLluviasDelegate.managedObjectContext;
    // ----------------------------------------------------------------
    
    // Pintar marcadores desde la base de datos.
    [self drawMarkersInViewDetail:@""];
    // Pintar Isoyeta de acuerdo a las coordenadas.
    //[self drawPolygon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - GMSMapViewDelegate

// Evento googleMaps: da clic sobre el mapa y escribe la latitud y longitud de ese punto en el mapa.
/*-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    NSString *cat_punto_medicion = @"CAT_PUNTO_MEDICION";
    NSInteger tipoPunto = [LluviasCoreData getTypeLocationPoint:marker.title withEntityName:cat_punto_medicion andContext:managedObjectContext];
    
    [_delegateDetail loadValues:marker.title andPoint:tipoPunto];
    tabBar.selectedIndex = 0;
    
    if(orientation != UIInterfaceOrientationLandscapeLeft || orientation != UIInterfaceOrientationLandscapeRight){
        [self.barButtonItem_1.target performSelector:self.barButtonItem_1.action withObject:self.barButtonItem_1];
        //[self.barButtonItem_1.target performSelector:self.barButtonItem_1.action withObject:self.barButtonItem_1];
    }
    
    NSLog(@"Hola, haz dado clic en la informacion del marcador.");
}*/

- (void)processPendingViewsForAnimation
{
    static BOOL runningAnimations = NO;
    // Nothing to animate, exit
    if ([self.pendingViewsForAnimation count]==0) return;
    // Already animating, exit
    if (runningAnimations)
        return;
    
    // We're animating
    runningAnimations = YES;
    
    MKAnnotationView* view = [self.pendingViewsForAnimation lastObject];
    
    /*CGRect endFrame = view.frame;
    view.frame = CGRectOffset(endFrame, 0, -500);
    [UIView animateWithDuration:(0.1/4)
                     animations:^{ view.frame = endFrame, view.alpha = 1;
                     
                     } completion:^(BOOL finished) {
                         [self.pendingViewsForAnimation removeObject:view];
                         runningAnimations = NO;
                         [self processPendingViewsForAnimation];
                     }];*/
    
    [UIView animateWithDuration:(0.1 / 16) animations:^(void) {
        view.alpha = 1;
        //NSLog(@"Show Annotation[%d] %@",[self.pendingViewsForAnimation count],view);
    } completion:^(BOOL finished) {
        [self.pendingViewsForAnimation removeObject:view];
        runningAnimations = NO;
        [self processPendingViewsForAnimation];
    }];
    
}

// This just demonstrates the animation logic, I've removed the "frame" animation for now
// to focus our attention on just the animation.
- (void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)annotationViews {
    pendingViewsForAnimation =  [[NSMutableArray alloc] init];
    
    for (MKAnnotationView *view in annotationViews) {
        view.alpha = 0;
        
        [self.pendingViewsForAnimation addObject:view];
    }
    [self processPendingViewsForAnimation];
}

/*
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)annotationViews
{
    for (MKAnnotationView *annView in annotationViews)
    {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -500);
        [UIView animateWithDuration:0.4
                         animations:^{ annView.frame = endFrame; }];
    }
}*/

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    NSString *cat_punto_medicion = @"CAT_PUNTO_MEDICION";
    NSInteger tipoPunto = 0;
    id <MKAnnotation> annotation = [view annotation];
    
    if ([annotation isKindOfClass:[LluviasLumbreraAnnotation class]]) {
        LluviasLumbreraAnnotation *auxLumbre = (LluviasLumbreraAnnotation *)annotation;
        tipoPunto = [LluviasCoreData getTypeLocationPoint:auxLumbre.title withEntityName:cat_punto_medicion andContext:managedObjectContext];
        [_delegateDetail loadValues:auxLumbre.title andPoint:tipoPunto];
        NSLog(@"Hola haz dado clic LluviasLumbrerasannotation!!!");
        
    } else if ([annotation isKindOfClass:[LluviasEstacionAnnotation class]]) {
        LluviasEstacionAnnotation *auxEstacion = (LluviasEstacionAnnotation *)annotation;
        tipoPunto = [LluviasCoreData getTypeLocationPoint:auxEstacion.title withEntityName:cat_punto_medicion andContext:managedObjectContext];
        [_delegateDetail loadValues:auxEstacion.title andPoint:tipoPunto];
        NSLog(@"Hola haz dado clic LluviasEstacionAnnotation!!!");
        
    } else if ([annotation isKindOfClass:[LluviasEstructuraAnnotation class]]) {
        LluviasEstructuraAnnotation *auxEstructura = (LluviasEstructuraAnnotation *)annotation;
        tipoPunto = [LluviasCoreData getTypeLocationPoint:auxEstructura.title withEntityName:cat_punto_medicion andContext:managedObjectContext];
        [_delegateDetail loadValues:auxEstructura.title andPoint:tipoPunto];
        NSLog(@"Hola haz dado clic LluviasEstructuraAnnotation!!!");
        
    }
    
    tabBar.selectedIndex = 0;
    
    if(orientation != UIInterfaceOrientationLandscapeLeft || orientation != UIInterfaceOrientationLandscapeRight){
        [self.barButtonItem_1.target performSelector:self.barButtonItem_1.action withObject:self.barButtonItem_1];
        //[self.barButtonItem_1.target performSelector:self.barButtonItem_1.action withObject:self.barButtonItem_1];
    }
}

#pragma mark MKMapViewDelegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    return [kmlParser viewForOverlay:overlay];
}
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    return [kmlParser viewForAnnotation:annotation];
}*/

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[LluviasLumbreraAnnotation class]]) {
        
        static NSString *lumbreraAnnotationIdentifier = @"Lumbrera";
        
        MKPinAnnotationView * pinView = (MKPinAnnotationView *)[self.mapView_ dequeueReusableAnnotationViewWithIdentifier:lumbreraAnnotationIdentifier];
        
        if (pinView == nil) {
            
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:lumbreraAnnotationIdentifier];
            
            //customPinView.animatesDrop = YES;
            customPinView.image = [UIImage imageNamed:@"lumbrera_marker_v01_25x34.png"];
            customPinView.canShowCallout = YES;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    } // FIN if lumbrera
    else if ([annotation isKindOfClass:[LluviasEstructuraAnnotation class]]) {
        static NSString *estructuraAnnotationIdentifier = @"Estructura";
        
        MKPinAnnotationView * pinView = (MKPinAnnotationView *)[self.mapView_ dequeueReusableAnnotationViewWithIdentifier:estructuraAnnotationIdentifier];
        
        if (pinView == nil) {
            
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:estructuraAnnotationIdentifier];
            
            //customPinView.image = [UIImage imageNamed:@"estacion_marker_V02-01.png"];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.canShowCallout = YES;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    } // Fin estructura
    else if ([annotation isKindOfClass:[LluviasEstacionAnnotation class]]) {
        static NSString *estacionAnnotationIdentifier = @"Estacion";
        
        MKPinAnnotationView * pinView = (MKPinAnnotationView *)[self.mapView_ dequeueReusableAnnotationViewWithIdentifier:estacionAnnotationIdentifier];
        
        if (pinView == nil) {
            
            MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:estacionAnnotationIdentifier];
            
            //customPinView.animatesDrop = YES;
            //customPinView.image = [UIImage imageNamed:@"lumbrera_marker_v01_25x36.png"];
            customPinView.image = [UIImage imageNamed:@"estacion_marker_V02-01.png"];
            //customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.canShowCallout = YES;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
            
            return customPinView;
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    } // Fin estacion
    
    return [kmlParser viewForAnnotation:annotation];
}

// Isoyeta
-(void)drawPolygon {

    
}

-(void)drawMarkersInViewDetail:(NSString *)namePointLocation {
    
    NSString *cat_punto_medicion = @"CAT_PUNTO_MEDICION";
    NSArray *puntosMedicion = [LluviasCoreData searchObjectForEntity:cat_punto_medicion withContext:managedObjectContext];
    //markersArray = [[NSMutableArray alloc] init];
    markersArrayLumbreras = [[NSMutableArray alloc] init];
    markersArrayEstructuras = [[NSMutableArray alloc] init];
    markersArrayEstaciones = [[NSMutableArray alloc] init];
    
    
    //[LluviasCoreData deleteLastObjectInEntity:@"CAT_PUNTO_MEDICION" withContext:managedObjectContext];
    
    if (puntosMedicion != nil) {
        
        for (CAT_PUNTO_MEDICION *thisPuntosMed in puntosMedicion) {
        
            // CLLocationDegrees are typedefed doubles.
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake((double) thisPuntosMed.latitud.floatValue, (double)thisPuntosMed.longitud.floatValue);
            LluviasLumbreraAnnotation *annotationLumbre = [LluviasLumbreraAnnotation new];
            LluviasEstructuraAnnotation *annotationEstruct = [LluviasEstructuraAnnotation new];
            LluviasEstacionAnnotation *annotationEstac = [LluviasEstacionAnnotation new];
            
            // Escogemos el icono de acuerdo al tipo de punto de medicion.
            switch (thisPuntosMed.idTipoPuntoMedicion.intValue) {
                case 1: // Lumbreras
                    annotationLumbre = [annotationLumbre initWithCoordinates:position title:thisPuntosMed.puntoMedicionName subTitle:@"" typePoint:thisPuntosMed.idTipoPuntoMedicion.intValue];
                    [markersArrayLumbreras addObject:annotationLumbre];
                    [mapView_ addAnnotation:annotationLumbre];
                    break;
                case 2: // Estructuras
                    annotationEstruct = [annotationEstruct initWithCoordinates:position title:thisPuntosMed.puntoMedicionName subTitle:@"" typePoint:thisPuntosMed.idTipoPuntoMedicion.intValue];
                    [markersArrayEstructuras addObject:annotationEstruct];
                    [mapView_ addAnnotation:annotationEstruct];
                    break;
                case 3: // Estaciones pluviograficas
                    annotationEstac = [annotationEstac initWithCoordinates:position title:thisPuntosMed.puntoMedicionName subTitle:@"" typePoint:thisPuntosMed.idTipoPuntoMedicion.intValue];
                    [markersArrayEstaciones addObject:annotationEstac];
                    [mapView_ addAnnotation:annotationEstac];
                    break;
                default:
                    break;
            } // FIN switch
            
            annotationLumbre = nil;
            annotationEstruct = nil;
            annotationEstac = nil;
            
        } // FIN for each
    } else {
        NSLog(@"EL arreglo con los puntos de medicion esta vacio.");
    }
}


-(void) turnSplitViewButtonOn:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController {
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    _splitViewButton = barButtonItem;
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
    self.barButtonItem_1 = barButtonItem;
    
}

-(void)turnSplitViewButtonOff {
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    _splitViewButton = nil;
    self.masterPopoverController = nil;
}

// metodo del delegado LluviasMasterDetailManagerDelegate.
-(void)setSplitViewController:(UIBarButtonItem *)splitViewButton forPopoverController:(UIPopoverController *)popoverController {
    
    if (splitViewButton != _splitViewButton) {
        if (splitViewButton) {
            [self turnSplitViewButtonOn:splitViewButton forPopoverController:popoverController];
        } else {
            [self turnSplitViewButtonOff];
        }
    }
}

-(BOOL)moveToMapDetailView:(CLLocationCoordinate2D)pointDetailViewMap andNamePoint:(NSString *)namePointLocation {
    
    BOOL aux = NO;
    NSString *cat_punto_medicion = @"CAT_PUNTO_MEDICION";
    NSInteger auxInteger = [LluviasCoreData getTypeLocationPoint:namePointLocation withEntityName:cat_punto_medicion andContext:managedObjectContext];
    LluviasLumbreraAnnotation *auxLumbrera;
    LluviasEstructuraAnnotation *auxEstructura;
    LluviasEstacionAnnotation *auxEstacion;
    
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:pointDetailViewMap fromEyeCoordinate:pointDetailViewMap eyeAltitude:mapView_.camera.altitude];
    
    // Lumbreras
    if (auxInteger == 1) {
        for(LluviasLumbreraAnnotation *annotation in self.markersArrayLumbreras) {
            if (annotation.coordinate.latitude == pointDetailViewMap.latitude &&
                annotation.coordinate.longitude == pointDetailViewMap.longitude) {
                auxLumbrera = annotation;
                
                break;
            }
        }
        
        mapView_.camera = camera;
        [mapView_ selectAnnotation:auxLumbrera animated:YES];
        
        return aux;
    }
    
    // Estructuras
    if (auxInteger == 2) {
        for(LluviasEstructuraAnnotation *annotation in self.markersArrayEstructuras) {
            if (annotation.coordinate.latitude == pointDetailViewMap.latitude &&
                annotation.coordinate.longitude == pointDetailViewMap.longitude) {
                auxEstructura = annotation;
                
                break;
            }
        }
        
        mapView_.camera = camera;
        [mapView_ selectAnnotation:auxEstructura animated:YES];
        
        return aux;
    }
    
    // Estaciones
    if (auxInteger == 3) {
        for(LluviasEstacionAnnotation *annotation in self.markersArrayEstaciones) {
            if (annotation.coordinate.latitude == pointDetailViewMap.latitude &&
                annotation.coordinate.longitude == pointDetailViewMap.longitude) {
                auxEstacion = annotation;
                
                break;
            }
        }
        
        mapView_.camera = camera;
        [mapView_ selectAnnotation:auxEstacion animated:YES];
        
        return aux;
    }
    
    return aux;
}

// Valores para punto de medicion: 1-> Lumbreras, 2-> Estaciones, 3-> Estructuras, 4-> Isoyetas.
// Valores para switchOnOff: YES-> mostrar punto de medicion, NO-> no mostrar puntos de medicion.
-(void)deleteMarkersInMap:(NSInteger)typeMarker andOnOff:(BOOL)switchOnOff {
    
    // Si la condicion es falsa
    if (!switchOnOff) {
        
        // Lumbreras
        if (typeMarker == 1) {
            [mapView_ removeAnnotations:self.markersArrayLumbreras];        }
        
        // Estructuras
        if (typeMarker == 2) {
            [mapView_ removeAnnotations:self.markersArrayEstructuras];
        }
        
        // Estaciones
        if (typeMarker == 3) {
            [mapView_ removeAnnotations:self.markersArrayEstaciones];
        }

    } else { // Si la condicion es verdadera.
        // Lumbreras
        if (typeMarker == 1) {
            [mapView_ addAnnotations:self.markersArrayLumbreras];
        }
        
        // Estructuras
        if (typeMarker == 2) {
            [mapView_ addAnnotations:self.markersArrayEstructuras];
        }
        
        // Estaciones
        if (typeMarker == 3) {
            [mapView_ addAnnotations:self.markersArrayEstaciones];
        }

    }
    
    NSLog(@"Hola estas llamando a un delegado!!!");
}

-(void)deletePolygonsInMap:(NSInteger)typePolygon andOnOff:(BOOL)switchOnOff {
    
    if (!switchOnOff) {
        [mapView_ removeOverlays:overlays];
        /*switch (typePolygon) {
            case 10:
                auxPolygon = polygon;
                auxPolygon.map = mapView_;
                auxPolygon.map = nil;
                break;
            case 11:
                auxPolygon1 = polygon1;
                auxPolygon1.map = mapView_;
                auxPolygon1.map = nil;
                break;
            case 12:
                auxPolygon2 = polygon2;
                auxPolygon2.map = mapView_;
                auxPolygon2.map = nil;
                break;
            case 13:
                auxPolygon3 = polygon3;
                auxPolygon3.map = mapView_;
                auxPolygon3.map = nil;
                break;
            case 14:
                auxPolygon4 = polygon4;
                auxPolygon4.map = mapView_;
                auxPolygon4.map = nil;
                break;
                
            default:
                break;
        } // FIN switch*/
        
    } else {
        [mapView_ addOverlays:overlays];
        /*switch (typePolygon) {
            case 10:
                auxPolygon = polygon;
                auxPolygon.map = mapView_;
                break;
            case 11:
                auxPolygon1 = polygon1;
                auxPolygon1.map = mapView_;

                break;
            case 12:
                auxPolygon2 = polygon2;
                auxPolygon2.map = mapView_;
                break;
            case 13:
                auxPolygon3 = polygon3;
                auxPolygon3.map = mapView_;
                break;
            case 14:
                auxPolygon4 = polygon4;
                auxPolygon4.map = mapView_;
                break;
            default:
                break;
        }*/
    } // FIN else
}
// Funcion para iluminar la barra de estado.
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


/*-(NSArray *)readExistPuntosMedicion {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"CAT_PUNTO_MEDICION"];
    
    NSError *requestError = nil;
    NSArray *puntosMedicion = [contextLluvias executeFetchRequest:fetchRequest error:&requestError];
    
    if ([puntosMedicion count] > 0) {
        
        NSUInteger counter = 1;
        for (CAT_PUNTO_MEDICION *thisPuntosMed in puntosMedicion) {
            NSLog(@"%lu idPuntoMedicion = %@", (unsigned long)counter, thisPuntosMed.idPuntoMedicion);
            NSLog(@"%lu puntoMeidcionName = %@", (unsigned long)counter, thisPuntosMed.puntoMedicionName);
            NSLog(@"%lu idUnidadMedida = %@", (unsigned long)counter, thisPuntosMed.idUnidadMedida);
            NSLog(@"%lu idTipoPuntoMedicion = %@", (unsigned long)counter, thisPuntosMed.idTipoPuntoMedicion);
            NSLog(@"%lu valorReferencia = %@", (unsigned long)counter, thisPuntosMed.valorReferencia);
            NSLog(@"%lu parametroReferencia = %@", (unsigned long)counter, thisPuntosMed.parametroReferencia);
            NSLog(@"%lu isAcive = %@", (unsigned long)counter, thisPuntosMed.isActive);
            NSLog(@"%lu isModified = %@", (unsigned long)counter, thisPuntosMed.isModified);
            NSLog(@"%lu lastmodifiedDate = %@", (unsigned long)counter, thisPuntosMed.lastModifiedDate);
            NSLog(@"%lu latitud = %@", (unsigned long)counter, thisPuntosMed.latitud);
            NSLog(@"%lu longitud = %@", (unsigned long)counter, thisPuntosMed.longitud);
            
            counter++;
        }
    } else {
        NSLog(@"No se pudo encontrar ningun CAT_PUNTO_MEDICION en el contexto");
    }
    
    return puntosMedicion;
}*/


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
    }
    if (toInterfaceOrientation == UIInterfaceOrientationMaskPortrait) {
        

    }
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    //if (self.view.bounds.size.height < self.view.bounds.size.width) {
        //NSLog(@"ENTRE!!!");
    //}else{
    //}
}

-(void)viewDidLayoutSubviews {
    
    // Inicializamos una vista, y cargamos etiquetas personalizadas a la barra de navegacion.
    btn = [[UIView alloc] initWithFrame:CGRectMake(1, 0, 320, 60)];
    
    //UILabel *label_1;
    label_1 = [[UILabel alloc]initWithFrame:CGRectMake(-140, 13, 300, 32)];
    label_1.tag = 2;
    label_1.backgroundColor = [UIColor clearColor];
    label_1.font = [UIFont boldSystemFontOfSize:14];
    label_1.adjustsFontSizeToFitWidth = YES;
    label_1.textColor = [UIColor whiteColor];
    label_1.text = @"Promedio Pluviometrico";
    label_1.highlightedTextColor = [UIColor blackColor];
    label_1.tag = 5;
    [btn addSubview:label_1];
    [label_1 reloadInputViews];
    // ---------------------------------------------------------------------
    
    //UILabel *label_3;
    label_3 = [[UILabel alloc]initWithFrame:CGRectMake(25, 13, 300, 32)];
    label_3.tag = 2;
    label_3.backgroundColor = [UIColor clearColor];
    label_3.font = [UIFont boldSystemFontOfSize:16];
    label_3.adjustsFontSizeToFitWidth = YES;
    label_3.textColor = [UIColor whiteColor];
    label_3.text = @"8.1";
    label_3.highlightedTextColor = [UIColor blackColor];
    label_3.tag = 5;
    [btn addSubview:label_3];
    [label_3 reloadInputViews];
    // ---------------------------------------------------------------------
    
    //UILabel *label_2;
    label_2 = [[UILabel alloc]initWithFrame:CGRectMake(170, 13, 300, 32)];
    label_2.tag = 2;
    label_2.backgroundColor = [UIColor clearColor];
    label_2.font = [UIFont boldSystemFontOfSize:14];
    label_2.adjustsFontSizeToFitWidth = YES;
    label_2.textColor = [UIColor whiteColor];
    label_2.text = @"Filtro de Tiempo";
    label_2.highlightedTextColor = [UIColor blackColor];
    label_2.tag = 6;
    [btn addSubview:label_2];
    [label_2 reloadInputViews];
    // ---------------------------------------------------------------------
    
    label_3 = [[UILabel alloc]initWithFrame:CGRectMake(285, 13, 300, 32)];
    label_3.tag = 2;
    label_3.backgroundColor = [UIColor clearColor];
    label_3.font = [UIFont boldSystemFontOfSize:14];
    label_3.adjustsFontSizeToFitWidth = YES;
    label_3.textColor = [UIColor whiteColor];
    label_3.text = @"(14:00)";
    label_3.highlightedTextColor = [UIColor blackColor];
    label_3.tag = 6;
    [btn addSubview:label_3];
    [label_3 reloadInputViews];
    
    self.navigationItem.titleView = btn;
    // FIN de etiquetas personalizadas en la barra de navegacion ------------------------------
}

// takes 0x123456
-(UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:0.5];
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end






















