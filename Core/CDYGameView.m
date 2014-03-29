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

#import <CDYGameKit/CDYGameScreen.h>
#import "CDYGameView.h"
#import "SKNode+CDYResizing.h"
#import "CDYGameKitConstants.h"

@implementation CDYGameView

- (void)presentLoadingView:(CDYGameView *)view {
    CDYGameScreen *screen = (CDYGameScreen *) self.scene;
    [screen presentLoadingView:view];
}

- (void)positionContent {
    for (SKNode *node in self.children) {
        if (!node.userData) {
            continue;
        }

        UIViewAutoresizing autoresizing = node.cdyAutoreizingMask;
        if (autoresizing == UIViewAutoresizingNone) {
            continue;
        }

        [self positionNode:node usingAutoresizing:autoresizing];
    }
}

- (void)loadContent {

}

- (void)update:(NSTimeInterval)interval {

}

- (void)positionNode:(SKNode *)node usingAutoresizing:(UIViewAutoresizing)autoresizing {
    if ((autoresizing | CDYGKCenterNodeMask) == CDYGKCenterNodeMask) {
        [self centerNode:node];
    }
}

- (void)centerNode:(SKNode *)node {
    CGPoint position = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    [node setPosition:position];
}

@end
