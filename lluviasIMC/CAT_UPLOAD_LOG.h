//
//  CAT_UPLOAD_LOG.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class APP_USUARIO;

@interface CAT_UPLOAD_LOG : NSManagedObject

@property (nonatomic, retain) NSNumber * idUploadLog;
@property (nonatomic, retain) NSNumber * idUsuario;
@property (nonatomic, retain) NSString * ipDir;
@property (nonatomic, retain) NSString * msg;
@property (nonatomic, retain) NSString * pcName;
@property (nonatomic, retain) APP_USUARIO *app_usuario;

@end
