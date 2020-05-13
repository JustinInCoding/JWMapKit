//
//  CLLocationManager+QBExtension.m
//  JWMapKit
//
//  Created by 王晟骏 on 2020/5/11.
//  Copyright © 2020 u1city01. All rights reserved.
//

#import "CLLocationManager+JWExtension.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation CLLocationManager (JWExtension)

+ (void)load {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setAllowsBackgroundLocationUpdates:")), class_getInstanceMethod(self.class, @selector(swizzledSetAllowsBackgroundLocationUpdates:)));
    }
}

- (void)swizzledSetAllowsBackgroundLocationUpdates:(BOOL)allow {
    if (allow) {
        NSArray *backgroundModes = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIBackgroundModes"];
        if(backgroundModes && [backgroundModes containsObject:@"location"]) {
            [self swizzledSetAllowsBackgroundLocationUpdates:allow];
        } else {
            NSLog(@"APP想设置后台定位，但APP的info.plist里并没有申请后台定位");
        }
    } else {
        [self swizzledSetAllowsBackgroundLocationUpdates:allow];
    }
}

@end
