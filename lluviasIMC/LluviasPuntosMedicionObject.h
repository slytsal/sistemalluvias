//
//  LluviasPuntosMedicionObject.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LluviasPuntosMedicionObject : NSObject

@property (nonatomic, copy, readonly) NSString *puntoMedicionName;
@property (nonatomic, copy, readonly) NSString *medicion;

- (id)initWithPunto:(NSString*)puntoMedicionName medicion:(NSString*)medicion;
@end
