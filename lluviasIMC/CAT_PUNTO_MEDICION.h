//
//  CAT_PUNTO_MEDICION.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_PUNTO_MEDICION_MAX_MIN, CAT_TIPO_PUNTO_MEDICION, CAT_UNIDAD_MEDIDA, CI_REGISTRO, REL_EST_PUNTOMED;

@interface CAT_PUNTO_MEDICION : NSManagedObject

@property (nonatomic, retain) NSNumber * idPuntoMedicion;
@property (nonatomic, retain) NSNumber * idTipoPuntoMedicion;
@property (nonatomic, retain) NSNumber * idUnidadMedida;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSNumber * latitud;
@property (nonatomic, retain) NSNumber * longitud;
@property (nonatomic, retain) NSString * parametroReferencia;
@property (nonatomic, retain) NSString * puntoMedicionName;
@property (nonatomic, retain) NSNumber * valorReferencia;
@property (nonatomic, retain) CAT_TIPO_PUNTO_MEDICION *cat_tipo_punto_medicion;
@property (nonatomic, retain) CAT_UNIDAD_MEDIDA *cat_unidad_medida;
@property (nonatomic, retain) NSSet *ci_registro;
@property (nonatomic, retain) NSSet *cat_punto_medicion_max_min;
@property (nonatomic, retain) NSSet *rel_est_puntomed;
@end

@interface CAT_PUNTO_MEDICION (CoreDataGeneratedAccessors)

- (void)addCi_registroObject:(CI_REGISTRO *)value;
- (void)removeCi_registroObject:(CI_REGISTRO *)value;
- (void)addCi_registro:(NSSet *)values;
- (void)removeCi_registro:(NSSet *)values;

- (void)addCat_punto_medicion_max_minObject:(CAT_PUNTO_MEDICION_MAX_MIN *)value;
- (void)removeCat_punto_medicion_max_minObject:(CAT_PUNTO_MEDICION_MAX_MIN *)value;
- (void)addCat_punto_medicion_max_min:(NSSet *)values;
- (void)removeCat_punto_medicion_max_min:(NSSet *)values;

- (void)addRel_est_puntomedObject:(REL_EST_PUNTOMED *)value;
- (void)removeRel_est_puntomedObject:(REL_EST_PUNTOMED *)value;
- (void)addRel_est_puntomed:(NSSet *)values;
- (void)removeRel_est_puntomed:(NSSet *)values;

@end
