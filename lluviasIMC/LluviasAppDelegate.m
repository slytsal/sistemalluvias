//
//  LluviasAppDelegate.m
//  lluviasIMC
//
//  Created by imc developer 01 on 19/02/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasAppDelegate.h"
#import "LluviasMasterDetailManager.h"
#import "CAT_PUNTO_MEDICION.h"
#import "CAT_TIPO_PUNTO_MEDICION.h"
#import "CAT_UNIDAD_MEDIDA.h"
#import "LluviasCoreData.h"
#import <GoogleMaps/GoogleMaps.h>

@interface LluviasAppDelegate ()

@property (strong, nonatomic)LluviasMasterDetailManager *masterDetailManager;

@end

@implementation LluviasAppDelegate

//@synthesize window = _window;
@synthesize masterDetailManager = __masterDetailManager;

// propiedades necesarias para CoreData, recordar que solo se agregan cuando creamos
// un emptyProject.
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
// --------------------------------------------------------------------------------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Verificamos si el dispositivo es un iPad.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        self.masterDetailManager = [[LluviasMasterDetailManager alloc] initWithSplitViewController:splitViewController];
        
        //UIImage *minImage = [[UIImage imageNamed:@"slider-track-fill.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
        //UIImage *maxImage = [UIImage imageNamed:@"slider-track.png"];
        UIImage *thumbImage = [UIImage imageNamed:@"slider-cap.png"];
        
        //[[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
        //[[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
        [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
        [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
    } // FIN if
    
    
    /*CAT_UNIDAD_MEDIDA *puntoMedicion = [NSEntityDescription insertNewObjectForEntityForName:@"CAT_UNIDAD_MEDIDA" inManagedObjectContext:self.managedObjectContext];
    
    if (puntoMedicion != nil) {
        
        puntoMedicion.idUnidadMedida = @4;
        puntoMedicion.unidadMedidaName = @"Bordo libre en metros";
        puntoMedicion.unidadMedidaShort = @"blm";
        puntoMedicion.isActive = @1;
        puntoMedicion.isModified = @1;
        puntoMedicion.lastModifiedDate = @20130510110600123;
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"Salvado con exito");
        } else
            NSLog(@"Fallo para salvar el contexto. Error = %@", savingError);
        
    } else {
        NSLog(@"Fallo al crear nuevo punto de medicion.");
    }*/
    
    /*CAT_PUNTO_MEDICION *puntoMedicion = [NSEntityDescription insertNewObjectForEntityForName:@"CAT_PUNTO_MEDICION" inManagedObjectContext:self.managedObjectContext];
    
    if (puntoMedicion != nil) {
        
        puntoMedicion.idPuntoMedicion = @22;
        puntoMedicion.puntoMedicionName = @"Lumbrera 1 taxqueña";
        puntoMedicion.idUnidadMedida = @1;
        puntoMedicion.idTipoPuntoMedicion = @3;
        puntoMedicion.valorReferencia = @0;
        puntoMedicion.parametroReferencia = @"";
        puntoMedicion.isActive = @1;
        puntoMedicion.isModified = @1;
        puntoMedicion.lastModifiedDate = @20130510110600123;
        puntoMedicion.latitud = @19.4949;
        puntoMedicion.longitud = @-99.090;
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"Salvado con exito");
        } else
            NSLog(@"Fallo para salvar el contexto. Error = %@", savingError);
        
    } else {
        NSLog(@"Fallo al crear nuevo punto de medicion.");
    }*/
    
    
    // API KEY para accesar a los mapas de google, este paso es necesario, ver la documentacion en
    // developers.google.com para mas información.
    [GMSServices provideAPIKey:@"AIzaSyB8AoDwGHHT19uZNyNpuk6rTTtteYF5POc"];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"lluviasIMC" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"lluviasIMC.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
