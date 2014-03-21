//
//  LluviasIsoyetaObject.m
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasIsoyetaObject.h"

@implementation LluviasIsoyetaObject

- (id)initWithColor:(NSString*)color grade:(NSString*)grade {
    self = [super init];
    if (self)
    {
        _color = color;
        _grade = grade;
    }
    return self;
}

@end
