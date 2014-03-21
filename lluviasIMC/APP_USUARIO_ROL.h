//
//  APP_USUARIO_ROL.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APP_ROL, APP_USUARIO;

@interface APP_USUARIO_ROL : NSManagedObject

@property (nonatomic, retain) NSNumber * idRol;
@property (nonatomic, retain) NSNumber * idUsuario;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) APP_ROL *app_rol;
@property (nonatomic, retain) APP_USUARIO *app_usuario;

@end
