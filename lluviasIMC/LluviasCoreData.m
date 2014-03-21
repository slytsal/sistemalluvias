//
//  LluviasCoreData.m
//  lluviasIMC
//
//  Created by imc developer 01 on 27/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasCoreData.h"
#import "CAT_PUNTO_MEDICION.h"
#import "CAT_UNIDAD_MEDIDA.h"
#import "CAT_TIPO_PUNTO_MEDICION.h"

@implementation LluviasCoreData

#pragma mark - Recuperar objetos

// Buscamos el ultimo objeto de la entidad y devolvemos la informacion en un arreglo.
+(NSArray *)searchObjectForEntity:(NSString *)entityName withContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *requestError = nil;
    NSArray *puntosMedicion = [managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([puntosMedicion count] > 0) {
        return puntosMedicion;
    }
    else {
        NSLog(@"No se pudo encontrar la entidad en el contexto.");
    }
    
    return puntosMedicion;
}

#pragma mark - Borrar objetos
// Borramos el ultimo punto de medicion ingresado, solo para tres tablas, CAT_TIPO_PUNTO_MEDICION, CAT_PUNTO_MEDICION y CAT_UNIDAD_MEDIDA.
+(BOOL)deleteLastObjectInEntity:(NSString *)entityName withContext:(NSManagedObjectContext *)managedObjectContext {
    
    BOOL boolReturn = NO;
    NSArray *arrayLastObject = [self searchObjectForEntity:entityName withContext:managedObjectContext];
    
    if ([arrayLastObject count] > 0) {
        
        if ([entityName isEqualToString:@"CAT_TIPO_PUNTO_MEDICION"] == 0) {
            CAT_TIPO_PUNTO_MEDICION *lastTipoPuntoMedicion = [arrayLastObject lastObject];
            [managedObjectContext deleteObject:lastTipoPuntoMedicion];
        } else if ([entityName isEqualToString:@"CAT_PUNTO_MEDICION"] == 0) {
            CAT_PUNTO_MEDICION *lastTipoPuntoMedicion = [arrayLastObject lastObject];
            [managedObjectContext deleteObject:lastTipoPuntoMedicion];
        } else if ([entityName isEqualToString:@"CAT_UNIDAD_MEDIDA"] == 0) {
            CAT_UNIDAD_MEDIDA *lastTipoPuntoMedicion = [arrayLastObject lastObject];
            [managedObjectContext deleteObject:lastTipoPuntoMedicion];
        }
        
        NSError *savingError = nil;
        
        if ([managedObjectContext save:&savingError]) {
            boolReturn = YES;
            NSLog(@"Elemento borrado.");
        } else {
            boolReturn = NO;
            NSLog(@"Fallo al borrar elemento.");
        }
    } else {
        NSLog(@"No se pudo encontrar a la entidad en el contexto.");
    }
    
    return boolReturn;
}

// Extraemos de la base de datos las coordenadas del punto de medicion por su nombre
+(CLLocationCoordinate2D)getLocation:(NSString *)namePoint withEntityName:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext {
    
    // Variable e la cual almacenaremos el resultado de la busqueda.
    CLLocationCoordinate2D pointLocation;
    
    // Validacion
    if ([namePoint isEqualToString:@""]) {
        return pointLocation = CLLocationCoordinate2DMake(-1000, -1000);
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puntoMedicionName = %@", namePoint];
    [fetchRequest setPredicate:predicate];
    
    NSError *requestError = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (!requestError && fetchedObjects.count > 0) {
        
        CAT_PUNTO_MEDICION *puntoMedicion = fetchedObjects[0];
        pointLocation = CLLocationCoordinate2DMake((double)puntoMedicion.latitud.floatValue, (double)puntoMedicion.longitud.floatValue);
    } // FIN if
    else {
        NSLog(@"Error: %@", requestError);
        pointLocation = CLLocationCoordinate2DMake(-1000, -1000);
    }
    
    return pointLocation;
}

// Obtenemos el tipo de punto de medicion por nombre.
+(NSInteger)getTypeLocationPoint:(NSString *)namePointLocation withEntityName:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext {
    
    // Variable e la cual almacenaremos el resultado de la busqueda.
    NSInteger typePoint = 0;
    
    // Validacion
    if ([namePointLocation isEqualToString:@""]) {
        return typePoint = -1;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"puntoMedicionName = %@", namePointLocation];
    [fetchRequest setPredicate:predicate];
    
    NSError *requestError = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (!requestError && fetchedObjects.count > 0) {
        
        CAT_PUNTO_MEDICION *puntoMedicion = fetchedObjects[0];
        typePoint = puntoMedicion.idTipoPuntoMedicion.integerValue;
    } // FIN if
    else {
        NSLog(@"Error: %@", requestError);
        typePoint = -1;
    }
    
    return typePoint;
}

// Este metodo aun no lo usamos.
+(NSArray *)getMeditionPointObjects:(NSNumber *)typePointMedition withEntityName:(NSString *)entityName andContext:(NSManagedObjectContext *)managedObjectContext {
    
    // Validacion
    if (typePointMedition <= 0) {
        return nil;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *requestError = nil;
    NSArray *puntosMedicion = [managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idTipoPuntoMedicion = %d", [typePointMedition intValue]];
    [fetchRequest setPredicate:predicate];
    
    if ([puntosMedicion count] > 0) {
        return puntosMedicion;
    }
    else {
        puntosMedicion = nil;
        NSLog(@"No se pudo encontrar la entidad en el contexto.");
    }
    
    return puntosMedicion;

}

@end
