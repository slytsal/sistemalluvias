//
//  CAT_TIPO_PUNTO_MEDICION.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_PUNTO_MEDICION;

@interface CAT_TIPO_PUNTO_MEDICION : NSManagedObject

@property (nonatomic, retain) NSNumber * idTipoPuntoMedicion;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSString * tipoPuntoMedicionName;
@property (nonatomic, retain) NSSet *cat_punto_medicion;
@end

@interface CAT_TIPO_PUNTO_MEDICION (CoreDataGeneratedAccessors)

- (void)addCat_punto_medicionObject:(CAT_PUNTO_MEDICION *)value;
- (void)removeCat_punto_medicionObject:(CAT_PUNTO_MEDICION *)value;
- (void)addCat_punto_medicion:(NSSet *)values;
- (void)removeCat_punto_medicion:(NSSet *)values;

@end
