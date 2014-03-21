//
//  LluviasEstructuraAnnotation.h
//  lluviasIMC
//
//  Created by imc developer 01 on 13/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LluviasEstructuraAnnotation : NSObject <MKAnnotation>

/* unsafe_unretained since this is not an object. We can skip this and leave
 it to the compiler to decide. weak or strong won't work as this is not
 an object */
@property (nonatomic, unsafe_unretained, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readonly) NSInteger typePoint;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString*)paramTitle subTitle:(NSString*)paramSubTitle typePoint:(NSInteger)paramTypePoint;

@end
