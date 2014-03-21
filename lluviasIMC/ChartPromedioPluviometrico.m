//
//  ChartPromedioPluviometrico.m
//  lluviasIMC
//
//  Created by imc developer 01 on 05/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "ChartPromedioPluviometrico.h"
#import <ShinobiCharts/ShinobiChart.h>

@interface ChartPromedioPluviometrico() <SChartDatasource>

@property NSString *title;
@property NSString *license;
@property CGRect rect;
@property CGFloat dx;
@property CGFloat dy;
@property NSString *yAxisTitle;
@property NSString *xAxisTitle;
@property NSInteger minutes;
@property NSDate *minDate;
@property NSDate *maxDate;

@end

@implementation ChartPromedioPluviometrico
@synthesize title,license,rect,dx,dy,chart;

-(id) initWithRect:(CGRect)pRect andYAxisTitle:(NSString*)pYAxisTitle andXAxisTitle:(NSString*)pXAxisTitle{
    self= [super init];
    
    //Variables de chart
    self.yAxisTitle=pYAxisTitle;
    self.xAxisTitle=pXAxisTitle;
    self.title=@"";
    self.dx=5.0;
    self.dy=5.0;
    //self.license=@"2ZBJG-FECLD-HDNSE-7S6J3";
    //self.license=@"DVV28uA7FXRiD+UMjAxNDAzMjRpbmZvQHNoaW5vYmljb250cm9scy5jb20=dBojhaYWgRWi56ysuwnVEVqU6zNFtZi5IGwx6DSxf/UUCepFZ68RECBCVtRODYWIOKFoc0WaXDfGKf+813zC5ipQ6SFSoyGWQGZCEtP4YMZyLbaEORdC5qx3Tqxd2i3DyCScq+TTvsgMjnZMtV5cZNgDNW1E=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+";
    
    
    
    //Init chart
    //pRect.origin.y=10;
    self.chart=[[ShinobiChart alloc] initWithFrame:CGRectInset(pRect, self.dx, self.dy)];
    self.chart.title=self.title;
    self.chart.licenseKey=self.license;
    self.chart.legend.hidden=YES;
    self.chart.legend.placement=SChartLegendPlacementOutsidePlotArea;
    
    [self setDeafultDates];
    
    //Set axes
    [self setAxes];
    
    //Define protocol implementation
    self.chart.datasource=self;
    
    
    //Set Style
    self.chart.backgroundColor=[UIColor clearColor];
    
    return self;
}

-(void) setDeafultDates{
    NSDate *tmp=[NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate:tmp];
    [components setHour: 7];
    [components setMinute: 00];
    [components setSecond: 00];
    [components setYear:2014];
    [components setMonth:2];
    [components setDay:10];
    self.minDate=[gregorian dateFromComponents:components];
    
    [components setHour: 17];
    [components setMinute: 59];
    [components setSecond: 00];
    self.maxDate=[gregorian dateFromComponents:components];
}

-(id) getChart{
    return self.chart;
}

-(void) setAxes{
    //Fuente por default para los dos ejes
    UIFont *font;
    font=[UIFont fontWithName:@"Helvetica Neue" size:8.0];
    
    //Grosor de linea para los ejes
    NSNumber *lineWidth= [[NSNumber alloc] initWithInt:2];
    
    self.minutes= [self differenceInMinutesFromDateOne:self.minDate andDateTwo:self.maxDate];
    
    
    SChartDateRange *dr= [[SChartDateRange alloc] initWithDateMinimum:self.minDate andDateMaximum:self.maxDate];
    
    SChartDateTimeAxis *xTimeAxis = [[SChartDateTimeAxis alloc] initWithRange:dr];
    xTimeAxis.labelFormatString=@"HH:mm";
    xTimeAxis.axisPositionValue=@0;
    xTimeAxis.style.lineWidth=lineWidth;
    xTimeAxis.style.majorTickStyle.labelFont=font;
    xTimeAxis.majorTickFrequency=[SChartDateFrequency dateFrequencyWithMinute:60];
    self.chart.xAxis = xTimeAxis;
    
    
    /*
     
     SChartNumberAxis *xAxis = [[SChartNumberAxis alloc] init];
     xAxis.title = self.xAxisTitle;
     xAxis.axisPositionValue=@0;
     xAxis.style.titleStyle.font=font;
     xAxis.style.majorTickStyle.labelFont=font;
     xAxis.style.lineWidth=lineWidth;
     chart.xAxis = xAxis;
     */
    
    SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] init];
    yAxis.title = self.yAxisTitle;
    yAxis.axisPositionValue=@0;
    yAxis.style.titleStyle.font=font;
    yAxis.style.majorTickStyle.labelFont=font;
    
    
    yAxis.style.lineWidth=lineWidth;
    
    yAxis.rangePaddingLow = @(1.0);
    yAxis.rangePaddingHigh = @(2.0);
    chart.yAxis = yAxis;
}

#pragma mark - Chart protocol implementation
- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 2;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    if(index==0){
        SChartLineSeries *lineSeries = [[SChartLineSeries alloc] init];
        lineSeries.crosshairEnabled=YES;
        return lineSeries;
    }else if(index==1){
        SChartColumnSeries *columnSerires = [[SChartColumnSeries alloc] init];
        columnSerires.crosshairEnabled = YES;
        return columnSerires;
    }
    
    return Nil;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    return [self getDataForColumnSeries].count;
}

/*
 - (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
 
 SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
 
 
 // both functions share the same x-values
 double xValue = dataIndex / 10.0;
 datapoint.xValue = [NSNumber numberWithDouble:xValue];
 
 // compute the y-value for each series
 if (seriesIndex == 0) {
 datapoint.yValue = [NSNumber numberWithDouble:cosf(xValue)];
 } else {
 datapoint.yValue = [NSNumber numberWithDouble:sinf(xValue)];
 }
 
 
 return datapoint;
 }
 */
///*
- (NSArray *)sChart:(ShinobiChart *)chart dataPointsForSeriesAtIndex:(int)seriesIndex
{
    NSArray *data;
    if(seriesIndex==0){
        data=[self getDataForLineSeries];
    }else if(seriesIndex==1){
        data=[self getDataForColumnSeries];
    }
    
    return data;
}
//*/

-(NSArray *)getDataForColumnSeries{
    NSMutableArray *datapointArray = [[NSMutableArray alloc] init];
    SChartDataPoint *dp = [[SChartDataPoint alloc] init];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 8:00"];
    dp.yValue = @(5.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 9:00"];
    dp.yValue = @(2.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 10:00"];
    dp.yValue = @(2.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 11:00"];
    dp.yValue = @(1.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 12:00"];
    dp.yValue = @(3.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 13:00"];
    dp.yValue = @(6.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 14:00"];
    dp.yValue = @(6.5);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 15:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 16:00"];
    dp.yValue = @(9.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 17:00"];
    dp.yValue = @(8.5);
    [datapointArray addObject:dp];
    
    return [NSArray arrayWithArray:datapointArray];
}

-(NSArray *)getDataForLineSeries{
    NSMutableArray *datapointArray = [[NSMutableArray alloc] init];
    SChartDataPoint *dp = [[SChartDataPoint alloc] init];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 7:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 8:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 9:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 10:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 11:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 12:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 13:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 14:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 15:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 16:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 17:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    dp = [[SChartDataPoint alloc] init];
    dp.xValue = [self getDateFromString:@"2014-02-10 18:00"];
    dp.yValue = @(7.0);
    [datapointArray addObject:dp];
    
    return [NSArray arrayWithArray:datapointArray];
}

-(NSDate *) getDateFromString:(NSString *)dateString{
    NSDate *date;
    
    //NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    date = [dateFormat dateFromString:dateString];
    
    return date;
}

-(NSInteger)differenceInMinutesFromDateOne:(NSDate *)dateOne andDateTwo:(NSDate *)dateTwo{
    NSInteger minDiff=0;
    
    NSTimeInterval secondsBetween = [dateTwo timeIntervalSinceDate:dateOne];
    
    minDiff = secondsBetween / 60;
    
    return minDiff;
}

@end
