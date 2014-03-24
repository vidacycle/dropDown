//
//  InputMenus.m
//  DropDownTable
//
//  Created by Abby Schlageter on 24/03/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import "InputMenus.h"
#import "Sections.h"

@implementation InputMenus

-(NSDictionary*)setUpMenus
{
    NSArray *sect0 = [[NSArray alloc] initWithObjects:@"Scan", @"Scan Now", nil];
    NSArray *sect1 = [[NSArray alloc] initWithObjects:@"Sync", @"Sync Now", @"funtimes", nil];
    NSArray *sect2 = [[NSArray alloc] initWithObjects:@"Settings", @"Write", @"Update", nil];
    NSArray *sect3 = [[NSArray alloc] initWithObjects:@"Ses", @"Wrte", @"Updte", nil];
    NSArray *sect4 = [[NSArray alloc] initWithObjects:@"Setdds", @"Wite", @"Uate", nil];

    
    self.sections = [[NSMutableArray alloc] initWithCapacity:10];
    NSArray *sectionsArray =[[NSArray alloc] initWithObjects:sect0, sect1, sect2, sect3, sect4, nil];

    NSDictionary *theDictionary = [self createArraysForEachSection:[sectionsArray count] fromSectionRowTitles:sectionsArray];
    
    return theDictionary;
}


-(NSDictionary*)createArraysForEachSection:(NSInteger)numberOfSections fromSectionRowTitles:(NSArray*)arrayOfSectionArrays
{
    for(int i=0; i<numberOfSections; i++)
    {
        Sections *sections = [[Sections alloc] initSectionWithTitles:[arrayOfSectionArrays objectAtIndex:i]];
        [self.sections addObject:sections];
    }
    NSLog(@"Section arrays all filled");
    
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i < [self.sections count]; i++)
    {
        [keys addObject:[NSString stringWithFormat:@"%i", i]];
    }
    
    NSDictionary *theDictionary = [[NSDictionary alloc] initWithObjects:self.sections forKeys:keys];
    
    return theDictionary;
}

@end
