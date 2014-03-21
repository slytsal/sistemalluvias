//
//  APP_USUARIO.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APP_USUARIO_ROL, CAT_SESION, CAT_UPLOAD_LOG;

@interface APP_USUARIO : NSManagedObject

@property (nonatomic, retain) NSString * apellido;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSNumber * idUsuario;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isMailSent;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * isNewUser;
@property (nonatomic, retain) NSNumber * isVerified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * puesto;
@property (nonatomic, retain) NSString * usuarioCorreo;
@property (nonatomic, retain) NSString * usuarioPwd;
@property (nonatomic, retain) NSSet *app_usuario_rol;
@property (nonatomic, retain) NSSet *cat_sesion;
@property (nonatomic, retain) NSSet *cat_upload_log;
@end

@interface APP_USUARIO (CoreDataGeneratedAccessors)

- (void)addApp_usuario_rolObject:(APP_USUARIO_ROL *)value;
- (void)removeApp_usuario_rolObject:(APP_USUARIO_ROL *)value;
- (void)addApp_usuario_rol:(NSSet *)values;
- (void)removeApp_usuario_rol:(NSSet *)values;

- (void)addCat_sesionObject:(CAT_SESION *)value;
- (void)removeCat_sesionObject:(CAT_SESION *)value;
- (void)addCat_sesion:(NSSet *)values;
- (void)removeCat_sesion:(NSSet *)values;

- (void)addCat_upload_logObject:(CAT_UPLOAD_LOG *)value;
- (void)removeCat_upload_logObject:(CAT_UPLOAD_LOG *)value;
- (void)addCat_upload_log:(NSSet *)values;
- (void)removeCat_upload_log:(NSSet *)values;

@end
