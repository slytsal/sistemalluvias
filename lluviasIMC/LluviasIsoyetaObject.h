//
//  LluviasIsoyetaObject.h
//  lluviasIMC
//
//  Created by imc developer 01 on 20/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LluviasIsoyetaObject : NSObject

@property (nonatomic, copy, readonly) NSString *color;
@property (nonatomic, copy, readonly) NSString *grade;

- (id)initWithColor:(NSString*)color grade:(NSString*)grade;

@end
