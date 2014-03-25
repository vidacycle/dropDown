//
//  Sections.h
//  DropDownTable
//
//  Created by Abby Schlageter on 29/11/2013.
//  Copyright (c) 2013 Abby Schlageter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sections : NSObject

- (id)initSectionWithTitles:(NSArray*)theTitles;


@property (nonatomic, retain) NSArray *titles;
@property (nonatomic, retain) NSMutableArray *currentTitles;
@property (nonatomic) BOOL down;
@property (nonatomic) NSInteger numberOfRows;

@end
