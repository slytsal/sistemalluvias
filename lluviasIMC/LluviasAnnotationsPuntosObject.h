//
//  LluviasAnnotationsPuntosObject.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LluviasAnnotationsPuntosObject : NSObject

@property (nonatomic, readonly) double latitud;
@property (nonatomic, readonly) double longitud;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *medition;

- (id)initWithTitle:(NSString*)title medition:(NSString*)medition latitude:(double)latitud longitude:(double)longitud;

@end
