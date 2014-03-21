//
//  LluviasAnnotationPointMedition.m
//  lluviasIMC
//
//  Created by imc developer 01 on 12/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasAnnotationPointMedition.h"

NSString *const kReusablePinLumbrera = @"Lumbrera";
NSString *const kReusablePinStructure = @"Estructura";
NSString *const kReusablePinStation = @"Estacion";

@implementation LluviasAnnotationPointMedition

//- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString*)paramTitle
                            //subTitle:(NSString*)paramSubTitle;
+ (NSString *) reusableIdentifierforPinColor:(NSString*)paramPoint {
    NSString *result = nil;
    
    if ([paramPoint isEqual: @"Lumbrera"]) {
        result = kReusablePinLumbrera;
    } else if ([paramPoint isEqualToString:@"Estructura"]) {
        result = kReusablePinStructure;
    } else if ([paramPoint isEqualToString:@"Estacion"]) {
        result = kReusablePinStation;
    }
    
    return result;
}

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString*)paramTitle subTitle:(NSString*)paramSubTitle {
 
    self = [super init];
    
    if (self != nil) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
    }
    
    return self;
}

@end
