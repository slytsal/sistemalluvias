//
//  CAT_SESION.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APP_USUARIO;

@interface CAT_SESION : NSManagedObject

@property (nonatomic, retain) NSNumber * idSesion;
@property (nonatomic, retain) NSNumber * idUsuario;
@property (nonatomic, retain) NSNumber * isSaveSesion;
@property (nonatomic, retain) APP_USUARIO *app_usuario;

@end
