//
//  LluviasFacade.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LluviasAppDelegate.h"
#import "LluviasCoreData.h"

@interface LluviasFacade : NSObject 

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property LluviasAppDelegate *appLluviasDelegate;

-(void)insertCATPUNTOMEDICION:(NSArray*)arrayObjects;// withEntityName:(NSString*)entityName;

@end
