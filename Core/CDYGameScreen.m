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
#import <CDYGameKit/CDYGameButton.h>
#import <CDYGameKit/CDYLoadingView.h>
#import "CDYGameScreen.h"
#import "CDYGameKitConstants.h"

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

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:recognizer];
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
    SKNode *topNode = [self.children lastObject];
    if ([self isLoadingView:topNode]) {
        CDYGKLog(@"Loading view presented. Ignore tap");
        return;
    }

    CGPoint tapLocation = [self convertPointFromView:[recognizer locationInView:self.view]];
    NSArray *nodes = [self nodesAtPoint:tapLocation];

    CDYGameButton *button = [self findTopNodeOfType:[CDYGameButton class] fromNodes:nodes];
    if (button) {
        [self handleTapOnButton:button];
    } else {
        [self handleTapAtScreenLocation:tapLocation];
    }
}

- (BOOL)isLoadingView:(SKNode *)node {
    return [node isKindOfClass:[CDYLoadingView class]];
}

- (CDYGameButton *)findTopNodeOfType:(Class)nodeClass fromNodes:(NSArray *)nodes {
    NSEnumerator *enumerator = [nodes reverseObjectEnumerator];
    id next;
    while ((next = [enumerator nextObject]) != nil) {
        if ([next isKindOfClass:nodeClass]) {
            return next;
        }
    }

    return nil;
}

- (void)handleTapOnButton:(CDYGameButton *)node {
    if (node.tapHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            node.tapHandler(node);
        });
    } else {
        CDYGKLog(@"No tap handler on %@", node);
    }
}

- (void)handleTapAtScreenLocation:(CGPoint)screenLocation {
    CDYGKLog(@"handleTapAtScreenLocation:%@", NSStringFromCGPoint(screenLocation));
}

@end
