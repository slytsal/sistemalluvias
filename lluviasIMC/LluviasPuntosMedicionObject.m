//
//  LluviasPuntosMedicionObject.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasPuntosMedicionObject.h"

@implementation LluviasPuntosMedicionObject

-(id)initWithPunto:(NSString*)puntoMedicionName medicion:(NSString*)medicion {
    self = [super init];
    if (self)
    {
        _puntoMedicionName = puntoMedicionName;
        _medicion = medicion;
    }
    return self;
}

@end
