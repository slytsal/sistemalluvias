//
//  LluviasEstacionAnnotation.m
//  lluviasIMC
//
//  Created by imc developer 01 on 13/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasEstacionAnnotation.h"

@implementation LluviasEstacionAnnotation

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString*)paramTitle subTitle:(NSString*)paramSubTitle typePoint:(NSInteger)paramTypePoint {
    self = [super init];
    
    if (self != nil){
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
        _typePoint = paramTypePoint;
    }
    
    return self;
}

@end
