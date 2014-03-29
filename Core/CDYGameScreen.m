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

#import <CDYGameKit/CDYGameView.h>
#import "CDYGameScreen.h"

@implementation CDYGameScreen

- (void)didChangeSize:(CGSize)oldSize {
    [self positionContent];
}

- (void)presentLoadingView:(CDYGameView *)view {
    [view setZPosition:2];
    [view setSize:self.size];
    [view setAnchorPoint:CGPointMake(0, 0)];
    [view loadContent];
    [view setSize:self.size];
    [view positionContent];
    [self addChild:view];
}

- (void)positionContent {
    for (SKNode *node in self.children) {
        if (![node isKindOfClass:[CDYGameView class]]) {
            continue;
        }

        CDYGameView *gameView = (CDYGameView *) node;
        [gameView setSize:self.size];
        [gameView positionContent];
    }
}

- (void)loadContent {

}

- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];

    for (SKNode *node in self.children) {
        if (![node isKindOfClass:[CDYGameView class]]) {
            continue;
        }

        CDYGameView *gameView = (CDYGameView *) node;
        [gameView update:currentTime];
    }
}

@end
