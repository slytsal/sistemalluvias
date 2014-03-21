//
//  CI_REGISTRO.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_CONDPRO, CAT_PUNTO_MEDICION;

@interface CI_REGISTRO : NSManagedObject

@property (nonatomic, retain) NSString * accionActual;
@property (nonatomic, retain) NSNumber * diaRegistro;
@property (nonatomic, retain) NSDate * fechaCaptura;
@property (nonatomic, retain) NSNumber * fechaNumerica;
@property (nonatomic, retain) NSNumber * horaRegistro;
@property (nonatomic, retain) NSNumber * idCondicion;
@property (nonatomic, retain) NSNumber * idPuntoMedicion;
@property (nonatomic, retain) NSNumber * idRegistro;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSNumber * serverLastModifiedDate;
@property (nonatomic, retain) NSNumber * valor;
@property (nonatomic, retain) CAT_PUNTO_MEDICION *cat_punto_medicion;
@property (nonatomic, retain) NSSet *cat_condpro;
@end

@interface CI_REGISTRO (CoreDataGeneratedAccessors)

- (void)addCat_condproObject:(CAT_CONDPRO *)value;
- (void)removeCat_condproObject:(CAT_CONDPRO *)value;
- (void)addCat_condpro:(NSSet *)values;
- (void)removeCat_condpro:(NSSet *)values;

@end
