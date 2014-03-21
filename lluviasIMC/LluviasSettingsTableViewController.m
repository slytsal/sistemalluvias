//
//  LluviasSettingsTableViewController.m
//  lluviasIMC
//
//  Created by imc developer 01 on 03/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasSettingsTableViewController.h"
#import "LluviasPuntosMedicionTableViewCell.h"
#import "LluviasIsoyetasTableViewCell.h"

@interface LluviasSettingsTableViewController ()

@property NSArray *arrayPuntoMed;
@property NSArray *arrayIsoyetas;

-(IBAction)switchMeditionPoint:(id)sender;
-(IBAction)switchIso:(id)sender;
-(UIColor*)colorWithHexString:(NSString*)hex;

@end

@implementation LluviasSettingsTableViewController
@synthesize lluviasDetailViewController;
@synthesize arrayPuntoMed, arrayIsoyetas;
/*- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    arrayPuntoMed = @[@"Lumbreras", @"Estructuras", @"Estaciones pluviográficas"];
    arrayIsoyetas = @[@"0.5000", @"1.0000", @"2.0000", @"3.0000", @"5.0000"];
    
    //NSNumber *number = [[NSNumber alloc]initWithInteger:32];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.opaque = NO;
    
    self.lluviasDetailViewController = (LluviasDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.delegate = lluviasDetailViewController;

}
/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger aux = 0;
    
    switch (section) {
        case 0:
            return arrayPuntoMed.count;
        case 1:
            return arrayIsoyetas.count;
    }
    
    return aux;
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
            string = @"PUNTOS DE MEDICIÓN";
            break;
        case 1:
            string = @"ISOYETAS";
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
    
    CGFloat height = 0.0;
    
    switch (indexPath.section) {
        case 0:
            height = 60.0;
            break;
        case 1:
            height = 60.0;
            break;
        default:
            break;
    }
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell_PuntosMedicion = @"Cell_PuntosMedicion";
    static NSString *Cell_Isoyetas = @"Cell_Isoyetas";
    
    LluviasPuntosMedicionTableViewCell *puntoMedicionCell;
    LluviasIsoyetasTableViewCell *isoyetaCell;
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            puntoMedicionCell = [tableView dequeueReusableCellWithIdentifier:Cell_PuntosMedicion forIndexPath:indexPath];
            
            puntoMedicionCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            puntoMedicionCell.puntosMedicion.text = arrayPuntoMed[indexPath.row];
            puntoMedicionCell.switchPuntosMedicion.tag = indexPath.row;
            [puntoMedicionCell.switchPuntosMedicion addTarget:self action:@selector(switchMeditionPoint:) forControlEvents:UIControlEventValueChanged];
            
            cell = puntoMedicionCell;

            break;
        case 1:
            isoyetaCell = [tableView dequeueReusableCellWithIdentifier:Cell_Isoyetas forIndexPath:indexPath];
            
            isoyetaCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            isoyetaCell.Isoyetas.text = arrayIsoyetas[indexPath.row];
            isoyetaCell.switchIsoyetas.tag = indexPath.row;
            isoyetaCell.isoyetasView.tag = indexPath.row;
            [isoyetaCell.switchIsoyetas addTarget:self action:@selector(switchIso:) forControlEvents:UIControlEventValueChanged];
            
            switch (isoyetaCell.isoyetasView.tag) {
                case 0:
                    isoyetaCell.isoyetasView.backgroundColor = [self colorWithHexString:@"000000"];
                    break;
                case 1:
                    isoyetaCell.isoyetasView.backgroundColor = [self colorWithHexString:@"0404B4"];
                    break;
                case 2:
                    isoyetaCell.isoyetasView.backgroundColor = [self colorWithHexString:@"00FF40"];
                    break;
                case 3:
                    isoyetaCell.isoyetasView.backgroundColor = [self colorWithHexString:@"DF01D7"];
                    break;
                case 4:
                    isoyetaCell.isoyetasView.backgroundColor = [self colorWithHexString:@"00FFFF"];
                    break;
                default:
                    break;
            }
            
            cell = isoyetaCell;

            break;
        default:
            break;
    }
    
    return cell;
}

-(IBAction)switchMeditionPoint:(id)sender {
    
    UISwitch *switchControl = (UISwitch *)sender;
    BOOL auxValue = NO;
    
    if (!switchControl.on) {
        auxValue = NO;
        NSLog(@"Apagado");
    }
    else {
        auxValue = YES;
        NSLog(@"Prendido");
    }
    
    // 1-> Lumbreras, 2->Estructuras, 3->Estaciones, estos indices estan asociados al tag de switchControl.
    [_delegate deleteMarkersInMap:(switchControl.tag + 1) andOnOff:auxValue];
    
    NSLog(@"%d",switchControl.tag);
}

-(IBAction)switchIso:(id)sender {
    
    UISwitch *switchControl = (UISwitch *)sender;
    BOOL auxValue = NO;
    
    if (!switchControl.on) {
        auxValue = NO;
        NSLog(@"Apagado");
    }
    else {
        auxValue = YES;
        NSLog(@"Prendido");
    }
    
    [_delegate deletePolygonsInMap:(switchControl.tag + 10) andOnOff:auxValue];
    
    NSLog(@"%d",switchControl.tag);
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
