//
//  REL_EST_PUNTOMED.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_ESTRUCTURA, CAT_PUNTO_MEDICION;

@interface REL_EST_PUNTOMED : NSManagedObject

@property (nonatomic, retain) NSNumber * idEstPuntoMed;
@property (nonatomic, retain) NSNumber * idEstructura;
@property (nonatomic, retain) NSNumber * idPuntoMedicion;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) CAT_PUNTO_MEDICION *cat_punto_medicion;
@property (nonatomic, retain) CAT_ESTRUCTURA *cat_estructura;

@end
