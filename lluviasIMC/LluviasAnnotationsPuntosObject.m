//
//  LluviasAnnotationsPuntosObject.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasAnnotationsPuntosObject.h"

@implementation LluviasAnnotationsPuntosObject

- (id)initWithTitle:(NSString*)title medition:(NSString*)medition latitude:(double)latitud longitude:(double)longitud {
    self = [super init];
    if (self)
    {
        _title = title;
        _medition = medition;
        _latitud = latitud;
        _longitud = longitud;
    }
    return self;

}

@end
