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
    //enter the different main menu items as the initial string in each array, with subsequent strings in that array being the drop down menus for that item
    NSArray *sect0 = [[NSArray alloc] initWithObjects:@"Code", @"iOS", @"html & CSS", nil];
    NSArray *sect1 = [[NSArray alloc] initWithObjects:@"Write", @"AnOther", @"Protein", @"Stylus", nil];
    NSArray *sect2 = [[NSArray alloc] initWithObjects:@"Sites", @"vidacycle", @"Poplin", @"polymathine", nil];
    NSArray *sect3 = [[NSArray alloc] initWithObjects:@"Collab", @"TransitOfVenus", @"FeynmanPrinting", nil];
    NSArray *sect4 = [[NSArray alloc] initWithObjects:@"Teach", @"Maths", @"Physics", @"General", nil];

    
    //add all arrays to this array
    NSArray *sectionsArray =[[NSArray alloc] initWithObjects:sect0, sect1, sect2, sect3, sect4, nil];
    
    
    
    self.sections = [[NSMutableArray alloc] initWithCapacity:10];
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
