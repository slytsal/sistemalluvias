//
//  LluviasAccionesSobreEstObject.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasAccionesSobreEstObject.h"

@implementation LluviasAccionesSobreEstObject

- (id)initWithAction:(NSString*)accionActual report:(NSString*)reporte {
    self = [super init];
    if (self)
    {
        _accionActual = accionActual;
        _reporte = reporte;
    }
    return self;

}

@end
