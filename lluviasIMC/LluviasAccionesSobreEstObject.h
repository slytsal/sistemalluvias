//
//  LluviasAccionesSobreEstObject.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LluviasAccionesSobreEstObject : NSObject

@property (nonatomic, copy, readonly) NSString *accionActual;
@property (nonatomic, copy, readonly) NSString *reporte;

- (id)initWithAction:(NSString*)accionActual report:(NSString*)reporte;
@end
