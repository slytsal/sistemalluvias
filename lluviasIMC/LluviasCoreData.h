//
//  LluviasCoreData.h
//  lluviasIMC
//
//  Created by imc developer 01 on 27/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <GoogleMaps/GoogleMaps.h>
#import <UIKit/UIKit.h>

@interface LluviasCoreData : NSObject

// recuperar objetos
+(NSArray*)searchObjectForEntity:(NSString *)entityName withContext:(NSManagedObjectContext *)managedObjectContext;

// eliminar ultimo objeto insertado en la entidad
+(BOOL)deleteLastObjectInEntity:(NSString *)entityName withContext:(NSManagedObjectContext *)managedObjectContext;

// buscar mediante predicados
+(CLLocationCoordinate2D)getLocation:(NSString *)namePoint withEntityName:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext;

+(NSArray *)getMeditionPointObjects:(NSNumber *)typePointMedition withEntityName:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext;


+(NSInteger)getTypeLocationPoint:(NSString *)namePointLocation withEntityName:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext;
@end
