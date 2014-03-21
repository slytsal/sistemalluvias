//
//  CAT_ESTRUCTURA.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_SISTEMA, REL_ESTRUCTURA_DEPENDENCIA, REL_EST_PUNTOMED;

@interface CAT_ESTRUCTURA : NSManagedObject

@property (nonatomic, retain) NSString * estructuraName;
@property (nonatomic, retain) NSNumber * idEstructura;
@property (nonatomic, retain) NSNumber * idSistema;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSSet *rel_est_puntomed;
@property (nonatomic, retain) NSSet *rel_estructura_dependencia;
@property (nonatomic, retain) CAT_SISTEMA *cat_sistema;
@end

@interface CAT_ESTRUCTURA (CoreDataGeneratedAccessors)

- (void)addRel_est_puntomedObject:(REL_EST_PUNTOMED *)value;
- (void)removeRel_est_puntomedObject:(REL_EST_PUNTOMED *)value;
- (void)addRel_est_puntomed:(NSSet *)values;
- (void)removeRel_est_puntomed:(NSSet *)values;

- (void)addRel_estructura_dependenciaObject:(REL_ESTRUCTURA_DEPENDENCIA *)value;
- (void)removeRel_estructura_dependenciaObject:(REL_ESTRUCTURA_DEPENDENCIA *)value;
- (void)addRel_estructura_dependencia:(NSSet *)values;
- (void)removeRel_estructura_dependencia:(NSSet *)values;

@end
