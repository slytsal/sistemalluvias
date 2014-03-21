//
//  REL_ESTRUCTURA_DEPENDENCIA.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_DEPENDENCIA, CAT_ESTRUCTURA;

@interface REL_ESTRUCTURA_DEPENDENCIA : NSManagedObject

@property (nonatomic, retain) NSNumber * idDependencia;
@property (nonatomic, retain) NSNumber * idEstructura;
@property (nonatomic, retain) NSNumber * idEstructuraDependencia;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) CAT_ESTRUCTURA *cat_estructura;
@property (nonatomic, retain) CAT_DEPENDENCIA *cat_dependencia;

@end
