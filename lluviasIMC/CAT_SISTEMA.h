//
//  CAT_SISTEMA.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAT_ESTRUCTURA;

@interface CAT_SISTEMA : NSManagedObject

@property (nonatomic, retain) NSNumber * idSistema;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSString * sistemaName;
@property (nonatomic, retain) NSSet *cat_estructura;
@end

@interface CAT_SISTEMA (CoreDataGeneratedAccessors)

- (void)addCat_estructuraObject:(CAT_ESTRUCTURA *)value;
- (void)removeCat_estructuraObject:(CAT_ESTRUCTURA *)value;
- (void)addCat_estructura:(NSSet *)values;
- (void)removeCat_estructura:(NSSet *)values;

@end
