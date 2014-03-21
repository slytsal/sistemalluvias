//
//  LluviasDetailViewDelegate.h
//  lluviasIMC
//
//  Created by imc developer 01 on 05/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

@protocol LluviasDetailViewDelegate <NSObject>

@required
-(void)loadValues:(NSString *)titlePoint andPoint:(NSInteger)typePoint;

@end
