//
//  CAT_CONDPRO.h
//  lluviasIMC
//
//  Created by imc developer 01 on 18/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CI_REGISTRO;

@interface CAT_CONDPRO : NSManagedObject

@property (nonatomic, retain) NSNumber * idCondicion;
@property (nonatomic, retain) NSNumber * isModified;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSString * pathCodicion;
@property (nonatomic, retain) NSString * condicionName;
@property (nonatomic, retain) NSNumber * lastModifiedDate;
@property (nonatomic, retain) CI_REGISTRO *ci_registro;

@end
