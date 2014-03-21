//
//  LluviasResumenObject.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasResumenObject.h"

@implementation LluviasResumenObject

- (id)initWithDependencia:(NSString*)dependenciaEncargada
      ultimaActualizacion:(NSInteger)ultimaActualizacion
          ultimaCondicion:(NSString*)ultimaCondicion
            puntoMedicion:(NSString*)puntoMedicion
                   escala:(NSString*)escala
        parametroMedicion:(NSString*)parametroMedicion
     estacionConMasLluvia:(NSString*)estacionConMasLluvia
               estructura:(NSString*)estructura {
    self = [super init];
    if (self)
    {
        _dependenciaEncargada = dependenciaEncargada;
        _ultimaActualizacion = ultimaActualizacion;
        _ultimaCondicion = ultimaCondicion;
        _puntoMedicion = puntoMedicion;
        _escala = escala;
        _parametroMedicion = parametroMedicion;
        _estacionConMasLluvia = estacionConMasLluvia;
        _estructura = estructura;
    }
    return self;
}

@end
