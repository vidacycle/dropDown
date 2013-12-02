//
//  Sections.m
//  DropDownTable
//
//  Created by Abby Schlageter on 29/11/2013.
//  Copyright (c) 2013 Abby Schlageter. All rights reserved.
//

#import "Sections.h"

@implementation Sections

- (id)initSectionWithTitles:(NSArray*)theTitles
{
    self = [super init];
    if (self) {
        _titles = [[NSArray alloc] initWithArray:theTitles];
        _down = NO;
        _numberOfRows = 1;
        _currentTitles = [[NSMutableArray alloc] initWithCapacity:5];
        [_currentTitles addObject:[_titles objectAtIndex:0]];
    }
    return self;
}

@end
