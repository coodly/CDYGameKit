/*
 * Copyright 2014 Coodly LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "SKNode+CDYResizing.h"

NSString *const CDYGameKitNodeAutoresizingMaskKey = @"CDYGameKitNodeAutoresizingMaskKey";

@implementation SKNode (CDYResizing)

- (void)cdySetAutoreizingMask:(UIViewAutoresizing)autoresizing {
    [self cdyUserData][CDYGameKitNodeAutoresizingMaskKey] = @(autoresizing);
}

- (UIViewAutoresizing)cdyAutoreizingMask {
    if (!self.userData) {
        return UIViewAutoresizingNone;
    }

    NSNumber *value = self.userData[CDYGameKitNodeAutoresizingMaskKey];
    if (!value) {
        return UIViewAutoresizingNone;
    }

    return (UIViewAutoresizing) [value integerValue];
}

- (NSMutableDictionary *)cdyUserData {
    if (!self.userData) {
        [self setUserData:[NSMutableDictionary dictionary]];
    }

    return self.userData;
}

@end
