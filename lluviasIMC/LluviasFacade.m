//
//  LluviasFacade.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//


#import "LluviasFacade.h"
#import "LluviasCoreData.h"
#import "CAT_PUNTO_MEDICION.h"

@implementation LluviasFacade
@synthesize managedObjectContext, appLluviasDelegate;

-(id)init {
    self = [super init];
    if (self) {
        // DATOS: conectamos el managedObjectContext al objeto actual -----
        appLluviasDelegate = [UIApplication sharedApplication].delegate;
        managedObjectContext = appLluviasDelegate.managedObjectContext;
        // ----------------------------------------------------------------
    }
    return self;
}

-(void)insertCATPUNTOMEDICION:(NSArray*)arrayObjects; //withEntityName:(NSString*)entityName {
{
    NSString *catPuntoMedicion = @"CAT_PUNTO_MEDICION";
    NSArray *arrayLastObject = [LluviasCoreData searchObjectForEntity:catPuntoMedicion withContext:managedObjectContext];
    
    if (arrayLastObject != nil) {
        CAT_PUNTO_MEDICION *puntoMedicion = [NSEntityDescription insertNewObjectForEntityForName:@"CAT_PUNTO_MEDICION" inManagedObjectContext:managedObjectContext];
    
        if (puntoMedicion != nil) {
            
            puntoMedicion.idPuntoMedicion = [NSNumber numberWithInteger:[arrayObjects[0] integerValue]];
            puntoMedicion.puntoMedicionName = arrayObjects[1];
            puntoMedicion.idUnidadMedida = [NSNumber numberWithInteger:[arrayObjects[2] integerValue]];
            puntoMedicion.idTipoPuntoMedicion = [NSNumber numberWithInteger:[arrayObjects[3] integerValue]];
            puntoMedicion.valorReferencia = [NSNumber numberWithFloat:[arrayObjects[4] floatValue]];
             puntoMedicion.parametroReferencia = arrayObjects[5];
            puntoMedicion.isActive = [NSNumber numberWithInteger:[arrayObjects[6] integerValue]];
            puntoMedicion.isModified = [NSNumber numberWithInteger:[arrayObjects[7] integerValue]];
            puntoMedicion.lastModifiedDate = [NSNumber numberWithInteger:[arrayObjects[8] integerValue]];
            puntoMedicion.latitud = [NSNumber numberWithFloat:[arrayObjects[9] floatValue]];
            puntoMedicion.longitud = [NSNumber numberWithFloat:[arrayObjects[10] floatValue]];

        
             NSError *savingError = nil;
             if ([self.managedObjectContext save:&savingError]) {
                NSLog(@"Salvado con exito");
             } else
                NSLog(@"Fallo para salvar el contexto. Error = %@", savingError);
        
        } else {
            NSLog(@"Fallo al crear nuevo punto de medicion.");
        } // FIN else
    } else {
        NSLog(@"Ya existe informacion en CAT_PUNTO_MEDICION.");
    } // FIN else

}

@end
