//
//  LluviasInformationViewController.m
//  lluviasIMC
//
//  Created by imc developer 01 on 19/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasInformationViewController.h"
#import "LluviasAppDelegate.h"
#import "CAT_PUNTO_MEDICION.h"
#import "LluviasCoreData.h"


@interface LluviasInformationViewController ()

@property NSMutableArray *arrayInfoLumbreras;
@property NSMutableArray *arrayDetailLumbreras;

@property NSMutableArray *arrayInfoStation;
@property NSMutableArray *arrayDetailStation;

@property NSMutableArray *arrayInfoStructures;
@property NSMutableArray *arrayDetailStructures;

// Metodo para inicializar los arreglos.
-(void)loadData;
-(UIColor*)colorWithHexString:(NSString*)hex;

@end

@implementation LluviasInformationViewController
@synthesize tableViewLumbreras, tableViewStation, tableViewStructure;
@synthesize arrayInfoLumbreras, arrayDetailLumbreras;
@synthesize arrayInfoStation, arrayDetailStation;
@synthesize arrayDetailStructures, arrayInfoStructures;
@synthesize managedObjectContext, appLluviasDelegate, lluviasDetailViewController;

/*- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}*/

-(void)loadData {
    
    NSString *cat_punto_medicion = @"CAT_PUNTO_MEDICION";
    NSArray *arrayPuntosMedicion = [LluviasCoreData searchObjectForEntity:cat_punto_medicion withContext:managedObjectContext];
    
    NSString *detailString;
    NSString *detailStation;
    NSString *detailStructure;
    
    if (arrayInfoLumbreras == nil) {
        arrayInfoLumbreras = [[NSMutableArray alloc] init];
        arrayDetailLumbreras = [[NSMutableArray alloc] init];
        
        arrayInfoStructures = [[NSMutableArray alloc] init];
        arrayDetailStructures = [[NSMutableArray alloc] init];
        
        arrayInfoStation = [[NSMutableArray alloc]init];
        arrayDetailStation = [[NSMutableArray alloc]init];
        
        if (arrayPuntosMedicion != nil) {
            
            // for each
            NSInteger counter = 1;
            for (CAT_PUNTO_MEDICION *thisPuntoMedicion in arrayPuntosMedicion) {

                NSString *aux = [[NSString alloc]initWithFormat:@"%@", thisPuntoMedicion.puntoMedicionName];
                
                switch (thisPuntoMedicion.idTipoPuntoMedicion.intValue) {
                    case 1:
                        detailString = [[NSString alloc]initWithFormat:@"%dmn", counter];
                        [arrayInfoLumbreras addObject:aux];
                        [arrayDetailLumbreras addObject:detailString];
                        break;
                    case 2:
                        detailStation = [[NSString alloc]initWithFormat:@"%dmn", counter];
                        [arrayInfoStation addObject:aux];
                        [arrayDetailStation addObject:detailStation];
                        break;
                    case 3:
                        detailStructure = [[NSString alloc]initWithFormat:@"%dmn", counter];
                        [arrayInfoStructures addObject:aux];
                        [arrayDetailStructures addObject:detailStructure];
                        break;
                    default:
                        break;
                }
                
                aux = nil;
                detailString = nil;
                detailStation = nil;
                detailStructure = nil;
                
                counter++;
            }
        } else {
            NSLog(@"El arreglo que llena los tipos de medicion en table view no tiene elementos.");
        } // FIN if
        
    } // FIN if
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [self colorWithHexString:@"585858"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.opaque = NO;
    
    // DATOS: conectamos el managedObjectContext al objeto actual -----
    appLluviasDelegate = [UIApplication sharedApplication].delegate;
    managedObjectContext = appLluviasDelegate.managedObjectContext;
    // ----------------------------------------------------------------
    
    self.lluviasDetailViewController = (LluviasDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.delegate = lluviasDetailViewController;
    
    LluviasLumbrerasTableView *lumbrerasTableView = [LluviasLumbrerasTableView new];
    lumbrerasTableView.tag = 101;
    self.tableView = lumbrerasTableView;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView reloadData];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger auxInteger = 0;
    
    switch (tableView.tag) {
        case 101:
            auxInteger = 1;
        case 102:
            auxInteger = 1;
        case 103:
            auxInteger = 1;
        default:
            break;
    }
    
    // Return the number of sections.
    return auxInteger;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger auxInteger = 0;
    
    switch (tableView.tag) {
        case 101:
            auxInteger = arrayInfoLumbreras.count;
        case 102:
            auxInteger = arrayInfoStation.count;
        case 103:
            auxInteger = arrayInfoStructures.count;
        default:
            break;
    }
    
    // Return the number of rows in the section.
    return auxInteger;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier_lumbre = @"Cell_Lumbre";
    static NSString *CellIdentifier_station = @"Cell_Station";
    static NSString *CellIdentifier_structures = @"Cell_Structures";
    
    LluviasLumbrerasViewCell *cell_lumbre;
    LluviasStationViewCell *cell_station;
    LluviasStructuresViewCell *cell_structures;
    
    UIView * selectedBackgroundView;
    
    switch (tableView.tag) {
        
        case 101:
            cell_lumbre = [[LluviasLumbrerasViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier_lumbre];
            
            cell_lumbre.textLabel.text = [arrayInfoLumbreras objectAtIndex:indexPath.row];
            cell_lumbre.detailTextLabel.text = [arrayDetailLumbreras objectAtIndex:indexPath.row];
            
            cell_lumbre.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            // Color de fondo al seleccionar la celda ---------------------------------
            selectedBackgroundView = [[UIView alloc] initWithFrame:cell_lumbre.frame];
            [selectedBackgroundView setBackgroundColor:[self colorWithHexString:@"58ACFA"]];
            [cell_lumbre setSelectedBackgroundView:selectedBackgroundView];
            // ------------------------------------------------------------------------
            
            return  cell_lumbre;
            
        case 102:
            cell_station = [[LluviasStationViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier_station];
            
            cell_station.textLabel.text = [arrayInfoStation objectAtIndex:indexPath.row];
            cell_station.detailTextLabel.text = [arrayDetailStation objectAtIndex:indexPath.row];
            
            cell_station.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            // Color de fondo al seleccionar la celda ---------------------------------
            selectedBackgroundView = [[UIView alloc] initWithFrame:cell_station.frame];
            [selectedBackgroundView setBackgroundColor:[self colorWithHexString:@"58ACFA"]];
            [cell_station setSelectedBackgroundView:selectedBackgroundView];
            // ------------------------------------------------------------------------

            
            return  cell_station;
            
        case 103:
            cell_structures = [[LluviasStructuresViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier_structures];
            
            cell_structures.textLabel.text = [arrayInfoStructures objectAtIndex:indexPath.row];
            cell_structures.detailTextLabel.text = [arrayDetailStructures objectAtIndex:indexPath.row];
            
            cell_structures.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            // Color de fondo al seleccionar la celda ---------------------------------
            selectedBackgroundView = [[UIView alloc] initWithFrame:cell_structures.frame];
            [selectedBackgroundView setBackgroundColor:[self colorWithHexString:@"58ACFA"]];
            [cell_structures setSelectedBackgroundView:selectedBackgroundView];
            // ------------------------------------------------------------------------
            
            return  cell_structures;
            
        default:
            break;
    }
    
    return nil;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLLocationCoordinate2D pointLocation;
    NSString *cat_punto_medicion = @"CAT_PUNTO_MEDICION";
    NSString *cellValue;
    
    switch (tableView.tag) {
        case 101:
            cellValue = [arrayInfoLumbreras objectAtIndex:indexPath.row];
            pointLocation = [LluviasCoreData getLocation:cellValue withEntityName:cat_punto_medicion andContext:managedObjectContext];
            break;
        case 102:
            cellValue = [arrayInfoStation objectAtIndex:indexPath.row];
            pointLocation = [LluviasCoreData getLocation:cellValue withEntityName:cat_punto_medicion andContext:managedObjectContext];
            break;
        case 103:
            cellValue = [arrayInfoStructures objectAtIndex:indexPath.row];
            pointLocation = [LluviasCoreData getLocation:cellValue withEntityName:cat_punto_medicion andContext:managedObjectContext];            break;
        default:
            break;
    }
    
    //NSString *cellValue = [arrayInfoLumbreras objectAtIndex:indexPath.row];
    
    //UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Informacion Lumbreras" message:cellValue delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    //[alertView show];
    //CLLocationCoordinate2D hola = CLLocationCoordinate2DMake(19.346487, -99.187499);
    
    [_delegate moveToMapDetailView:pointLocation andNamePoint:cellValue];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string = @"";
    
    /* Section header is in 0th index... */
    switch (tableView.tag) {
        case 101:
            string = @"LUMBRERAS";
            break;
        case 102:
            string = @"ESTACIONES";
            break;
        case 103:
            string = @"ESTRUCTURAS";
            break;
        default:
            break;
    }
    
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:0.05]]; //your background color...
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}


-(IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    
    LluviasLumbrerasTableView *lumbrerasTableView = [LluviasLumbrerasTableView new];
    lumbrerasTableView.tag = 101;

    LluviasStationTableView *stationTableView = [LluviasStationTableView new];
    stationTableView.tag = 102;
    
    LluviasStructuresTableView *structuresTableView = [LluviasStructuresTableView new];
    structuresTableView.tag = 103;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.tableView = lumbrerasTableView;
            self.tableView.separatorColor = [UIColor clearColor];
            [self.tableView reloadData];
            break;
        case 1:
            self.tableView = stationTableView;
            self.tableView.separatorColor = [UIColor clearColor];
            [self.tableView reloadData];
            break;
        case 2:
            self.tableView = structuresTableView;
            self.tableView.separatorColor = [UIColor clearColor];
            [self.tableView reloadData];
            break;
        default:
            break;
    }

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
