//
//  LluviasResumenObject.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LluviasResumenObject : NSObject

@property (nonatomic, copy, readonly) NSString *dependenciaEncargada;
@property (nonatomic, readonly) NSInteger ultimaActualizacion;
@property (nonatomic, copy, readonly) NSString *ultimaCondicion;
@property (nonatomic, copy, readonly) NSString *puntoMedicion;
@property (nonatomic, copy, readonly) NSString *escala;
@property (nonatomic, copy, readonly) NSString *parametroMedicion;
@property (nonatomic, copy, readonly) NSString *estacionConMasLluvia;
@property (nonatomic, copy, readonly) NSString *estructura;

- (id)initWithDependencia:(NSString*)dependenciaEncargada
      ultimaActualizacion:(NSInteger)ultimaActualizacion
          ultimaCondicion:(NSString*)ultimaCondicion
            puntoMedicion:(NSString*)puntoMedicion
                   escala:(NSString*)escala
        parametroMedicion:(NSString*)parametroMedicion
     estacionConMasLluvia:(NSString*)estacionConMasLluvia
               estructura:(NSString*)estructura;

@end
