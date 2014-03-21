//
//  CAT_DEPENDENCIA.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class REL_ESTRUCTURA_DEPENDENCIA;

@interface CAT_DEPENDENCIA : NSManagedObject

@property (nonatomic, retain) NSString * dependenciaName;
@property (nonatomic, retain) NSNumber * idDependencia;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSSet *rel_estructura_dependencia;
@end

@interface CAT_DEPENDENCIA (CoreDataGeneratedAccessors)

- (void)addRel_estructura_dependenciaObject:(REL_ESTRUCTURA_DEPENDENCIA *)value;
- (void)removeRel_estructura_dependenciaObject:(REL_ESTRUCTURA_DEPENDENCIA *)value;
- (void)addRel_estructura_dependencia:(NSSet *)values;
- (void)removeRel_estructura_dependencia:(NSSet *)values;

@end
