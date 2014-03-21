//
//  APP_ROL.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APP_USUARIO_ROL;

@interface APP_ROL : NSManagedObject

@property (nonatomic, retain) NSNumber * idRol;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSString * rolName;
@property (nonatomic, retain) NSSet *app_usuario_rol;
@end

@interface APP_ROL (CoreDataGeneratedAccessors)

- (void)addApp_usuario_rolObject:(APP_USUARIO_ROL *)value;
- (void)removeApp_usuario_rolObject:(APP_USUARIO_ROL *)value;
- (void)addApp_usuario_rol:(NSSet *)values;
- (void)removeApp_usuario_rol:(NSSet *)values;

@end
