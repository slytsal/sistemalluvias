//
//  LluviasGraphicsTableViewController.m
//  lluviasIMC
//
//  Created by imc developer 01 on 19/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasGraphicsTableViewController.h"
#import "LluviasInterceptorViewCell.h"
#import "LluviasGraphAreaCell.h"
#import "LluviasGraphBarCell.h"
#import "LluviasGraphLineCell.h"
#import "LluviasActionStructureViewCell.h"
#import <ShinobiCharts/ShinobiChart.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ChartArea.h"
#import "ChartLine.h"
#import "ChartPromedioPluviometrico.h"

@interface LluviasGraphicsTableViewController () //<SChartDatasource>

@property NSArray *arrayText;
@property NSArray *arrayDetail;

@property NSArray *arrayTextPrimary;
@property NSArray *arrayTextSecunda;

@property ChartArea *chart;
@property ChartPromedioPluviometrico *chartPromPlu;
@property ChartLine *chartGraphLine;

@property LluviasInterceptorViewCell *intercepData;
@property LluviasGraphAreaCell *graphArea;
@property LluviasGraphBarCell *graphBar;
@property LluviasActionStructureViewCell *actionStruc;
@property LluviasGraphLineCell *graphLine;
@property UITableViewCell *cell;

@property NSString *tituloPuntoMedicion;

@end

@implementation LluviasGraphicsTableViewController
{
    NSDictionary* _sales[2];
}
@synthesize arrayDetail, arrayText, arrayTextPrimary, arrayTextSecunda;
@synthesize intercepData, graphArea, graphBar, actionStruc, graphLine;
@synthesize tituloPuntoMedicion;

/*- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.opaque = NO;
    
    // Datos del interceptor, primera sección, Graficas.
    //arrayText = @[@"Ultima captura", @"Medición actual", @"Condición actual", @"Acción actual"];
    //arrayDetail = @[@"01/01/2014 12:33", @"8.1 m", @"Condición 2", @"Acción actual"];
    arrayText = @[@"Dependencia encargada", @"Última actualización", @"Última condición", @"Punto de Medición", @"Escala", @"Parámetro de medición", @"Acción Actual 2"];
    arrayDetail = @[@"Organismo de Cuencas Aguas del Valle de México", @"10/06/2013 22:13:08", @"Condición 1 Lluvia Ligera A las 2013-10-06 22:00:00", @"01a. Vaso Cristo", @"Metros", @"3.19m en el Vaso de Cristo", @"."];

    // -----------------------------------------------------------------------------------------
    
    
    arrayTextPrimary = @[@"Compuertas abiertas del semiprofundo", @"Compuertas abiertas del semiprofundo", @"Compuertas abiertas del semiprofundo"];
    arrayTextSecunda = @[@"jgonzales @ 13:30", @"jgonzales @ 13:30", @"jgonzales @ 13:30"];
    
    
    _sales[0] = @{@"Br" : @5.65, @"Car" : @12.6, @"Mus" : @8.4};
    _sales[1] = @{@"Br" : @4.35, @"Car" : @13.2, @"Mus" : @4.6, @"Ok" : @0.6};
    
    //[self loadValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 1;
    
    switch (section) {
        case 0:
            numberOfRows = 7;
            break;
        case 1:
            numberOfRows = 1;
            break;
        case 2:
            numberOfRows = 1;
            break;
        case 3:
            numberOfRows = 1;
            break;
        case 4:
            numberOfRows = 3;
            break;
        default:
            break;
    }

    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell_data = @"Cell_intercep";
    static NSString *Cell_graph = @"Cell_graphArea";
    static NSString *Cell_graphBar = @"Cell_graphBar";
    static NSString *Cell_actionStruc = @"Cell_actionStruc";
    static NSString *Cell_graphLine = @"Cell_graphLine";
    
    //UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        self.intercepData = [tableView dequeueReusableCellWithIdentifier:Cell_data forIndexPath:indexPath];
        self.intercepData.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.intercepData.textLabel_1.text = arrayText[indexPath.row];
        self.intercepData.detailLabel_1.text = arrayDetail[indexPath.row];
        self.cell = self.intercepData;
        
    } else if (indexPath.section == 1) {
        
        self.graphArea = [tableView dequeueReusableCellWithIdentifier:Cell_graph forIndexPath:indexPath];
        self.graphArea.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.chart == nil) {
            self.chart= [[ChartArea alloc] initWithRect:self.graphArea.graphContainer.bounds andYAxisTitle:@"msnm" andXAxisTitle:@"horas"];
        
            [self.graphArea.graphContainer addSubview:self.chart.chart];
        } // FIN if
        
        self.cell = self.graphArea;
        
    } else if (indexPath.section == 2) {
        
        self.graphBar = [tableView dequeueReusableCellWithIdentifier:Cell_graphBar forIndexPath:indexPath];
        self.graphBar.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.chartPromPlu == nil) {
            
            self.chartPromPlu= [[ChartPromedioPluviometrico alloc] initWithRect:self.graphBar.graphBarContainer.bounds andYAxisTitle:@"mm" andXAxisTitle:@"horas"];
        
            [self.graphBar.graphBarContainer addSubview:self.chartPromPlu.chart];
        } // FIN if
        
        self.cell = self.graphBar;
        
    } else if (indexPath.section == 3) {
        self.graphLine = [tableView dequeueReusableCellWithIdentifier:Cell_graphLine forIndexPath:indexPath];
        self.graphLine.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.chartGraphLine == nil) {
            
            self.chartGraphLine = [[ChartLine alloc] initWithRect:self.graphLine.graphLineContainer.bounds andYAxisTitle:@"msnm" andXAxisTitle:@"horas"];
        
            [self.graphLine.graphLineContainer addSubview:self.chartGraphLine.chart];
        } // FIN if
        
        self.cell = self.graphLine;
        
    } else if (indexPath.section == 4) {
        
        self.actionStruc = [tableView dequeueReusableCellWithIdentifier:Cell_actionStruc forIndexPath:indexPath];
        self.actionStruc.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.actionStruc.textPrimary.text = arrayTextPrimary[indexPath.row];
        self.actionStruc.textSecunda.text = arrayTextSecunda[indexPath.row];
        
        self.cell = self.actionStruc;
    }
    
    
    return self.cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =@"";
    /* Section header is in 0th index... */

    switch (section) {
        case 0:
            string = tituloPuntoMedicion;
            break;
        case 1:
            string = @"MEDICIÓN REAL";
            break;
        case 2:
            string = @"ESTACIONES PLUVIOMÉTRICO";
            break;
        case 3:
            string = @"LUMBRERAS";
            break;
        case 4:
            string = @"ACCIONES SOBRE ESTRUCTURA";
            break;
        default:
            break;
    }
    
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 50.0;
    
    if(indexPath.section == 0){
        height = 50.0;
    } else if(indexPath.section == 1){
        height = 220.0;
    } else if(indexPath.section == 2){
        height = 220.0;
    } else if(indexPath.section == 3){
        height = 220.0;
    }
    
    return height;
}

# pragma mark - LluviasDetailViewDelegate methods
-(void)loadValues:(NSString *)titlePoint andPoint:(NSInteger)typePoint {
    
    switch (typePoint) {
        case 1:
            
            // Datos del interceptor, primera sección, Graficas.
            arrayDetail = @[@"01/20/2014 14:33", @"5.1 m", @"Condición 1", @"Acción actual"];
            arrayTextSecunda = @[@"jhernandez @ 10:30", @"jsantos @ 11:30", @"jzuñiga @ 12:30"];
            // -----------------------------------------------------------------------------------------
            
            break;
        case 2:
            
            // Datos del interceptor, primera sección, Graficas.
            arrayDetail = @[@"02/05/2014 18:33", @"7.1 m", @"Condición 3", @"Acción actual"];
            arrayTextSecunda = @[@"jperez @ 20:25", @"jlopez @ 11:22", @"jdominguez @ 09:11"];
            // -----------------------------------------------------------------------------------------
            
            break;
        case 3:
            
            // Datos del interceptor, primera sección, Graficas.
            arrayDetail = @[@"03/20/2014 08:01", @"3.1 m", @"Condición 4", @"Acción actual"];
            arrayTextSecunda = @[@"jmartinez @ 06:29", @"jceron @ 07:17", @"jcastillo @ 21:30"];
            // -----------------------------------------------------------------------------------------
            
            break;
        default:
            break;
    }
    
    tituloPuntoMedicion = titlePoint;
    
    [self.tableView reloadData];
    
    //NSLog(@"Hola, estas llamando al delegado en Graphics Table View Controller");
}


@end
