//
//  FakeSelectorEngineRegistry.m
//  2012 Olympics
//
//  Created by Pete Hodgson on 11/18/12.
//
//

#import "SelectorEngineRegistry.h"

@implementation SelectorEngineRegistry
+ (void) registerSelectorEngine:(id)registry WithName:(id)name{
    // dummy, do nothing;
}

+ (NSArray *) selectViewsWithEngineNamed:(NSString *)engineName usingSelector:(NSString *)selector{
    return nil;
}

@end