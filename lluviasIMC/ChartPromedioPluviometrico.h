//
//  ChartPromedioPluviometrico.h
//  lluviasIMC
//
//  Created by imc developer 01 on 05/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>

@interface ChartPromedioPluviometrico : NSObject

-(id) initWithRect:(CGRect)pRect andYAxisTitle:(NSString*)pYAxisTitle andXAxisTitle:(NSString*)pXAxisTitle;
-(id) getChart;

@property ShinobiChart *chart;

@end
