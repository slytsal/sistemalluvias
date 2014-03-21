//
//  CAT_PUNTO_MEDICION_MAX_MIN.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_PUNTO_MEDICION;

@interface CAT_PUNTO_MEDICION_MAX_MIN : NSManagedObject

@property (nonatomic, retain) NSNumber * idPuntoMedicion;
@property (nonatomic, retain) NSNumber * idPuntoMedicionMaxMin;
@property (nonatomic, retain) NSNumber * max;
@property (nonatomic, retain) NSNumber * min;
@property (nonatomic, retain) CAT_PUNTO_MEDICION *cat_punto_medicion;

@end
