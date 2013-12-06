//
//  dropDownTableVC.m
//  DropDownTable
//
//  Created by Abby Schlageter on 20/11/2013.
//  Copyright (c) 2013 Abby Schlageter. All rights reserved.
//

#import "dropDownTableVC.h"
#import "Sections.h"

@interface dropDownTableVC ()

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) Sections *section_0;
@property (nonatomic, retain) Sections *section_1;
@property (nonatomic) NSInteger numberOfSections;
@property (nonatomic, retain) NSDictionary *dictionary;
@property (nonatomic, retain) Sections *theSection;

@end

@implementation dropDownTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *sect0 = [[NSArray alloc] initWithObjects:@"Scan", @"Scan Now", nil];
    NSArray *sect1 = [[NSArray alloc] initWithObjects:@"Sync", @"Sync Now", nil];
    
    self.section_0 = [[Sections alloc] initSectionWithTitles:sect0];
    self.section_1 = [[Sections alloc] initSectionWithTitles:sect1];
    
    self.sections = [[NSArray alloc] initWithObjects:self.section_0, self.section_1, nil];
    

    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i < [self.sections count]; i++) {
        [keys addObject:[NSString stringWithFormat:@"%i", i]];
       // [self.dictionary setObject:[self.sections objectAtIndex:i] forKey:[keys objectAtIndex:i]];
    }
        //NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithObjects:[self.sections objectAtIndex:i] forKeys:[keys objectAtIndex:i]];
    self.dictionary = [[NSDictionary alloc] initWithObjects:self.sections forKeys:keys];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%i",section]];
    self.theSection.numberOfRows = [self.theSection.currentTitles count];
    rows = self.theSection.numberOfRows;
    /*switch (section) {
        case 0:
            self.section_0.numberOfRows = [self.section_0.currentTitles count];
            rows = self.section_0.numberOfRows;
            break;
        case 1:
            self.section_1.numberOfRows = [self.section_1.currentTitles count];
            rows = self.section_1.numberOfRows;
            break;
        default:
            break;
    }*/
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.table setSeparatorColor:[UIColor clearColor]];
    static NSString *CellIdentifier = @"Main";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
    
    [[cell textLabel] setFont:[UIFont fontWithName:@"Lato Light" size:16.0]];
    [cell setBackgroundColor:[UIColor colorWithRed:0 green:0.573 blue:0.271 alpha:1]];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    
    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%i",[indexPath section]]];
    [[cell textLabel] setText:[self.theSection.currentTitles objectAtIndex:[indexPath row]]];
    /*
    switch ([indexPath section]) {
        case 0:
            [[cell textLabel] setText:[self.section_0.currentTitles objectAtIndex:[indexPath row]]];
            break;
        case 1:
            [[cell textLabel] setText:[self.section_1.currentTitles objectAtIndex:[indexPath row]]];
            break;
        default:
            break;
    }
    */
    //for all drop down parts of table change color of background so it's obvious
     if ([indexPath row] == 1) {
         //[cell setBackgroundColor:[UIColor whiteColor]];
         [[cell textLabel] setTextColor:[UIColor grayColor]];
         [[cell textLabel] setFont:[UIFont fontWithName:@"Arial" size:16.0]];
     }
    
    if ([indexPath row] > 0) {
        cell.accessoryView = Nil;
    }
    
    return cell;
}

//custom accessory view
-(UIView*)customAccessoryViewFor:(UIImage*)theAccessory
{
    UIImageView *accImageView = [[UIImageView alloc] initWithImage:theAccessory];
    accImageView.userInteractionEnabled = YES;
    [accImageView setFrame:CGRectMake(0, 0, 28.0, 28.0)];

    return accImageView;
}
         
         
         
         
- (IBAction)insertRows:(id)sender forIndexPathRow:(NSInteger)row andSection:(NSInteger)section
{
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:section], nil];

   self.table = (UITableView *)self.view;
    
    [self.table beginUpdates];
    [self.table insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.table endUpdates];

}


- (IBAction)deleteRows:(id)sender forIndexPathRow:(NSInteger)row andSection:(NSInteger)section
{
    NSArray *deleteIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:section], nil];
    
    self.table = (UITableView *)self.view;
    
    [self.table beginUpdates];
    [self.table deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    //self.theSection.numberOfRows = [self.theSection.currentTitles count];
    //THIS IS CAUSING THE BUG!!!!!!!!!!!!!
    [self.table endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%i",[indexPath section]]];
    NSLog(@"down 1? = %hhd", self.theSection.down);
    NSLog(@"objectForKey: %@",[NSString stringWithFormat:@"%i",[indexPath section]]);
    //section0
    if ([indexPath row] == 0 && self.theSection.down == NO)
    {
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"minus_button.png"]];
        [self.theSection.currentTitles insertObject:[self.theSection.titles objectAtIndex:1] atIndex:1];
        [self insertRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.theSection.down = YES;
        NSLog(@"down 2a? = %hhd", self.theSection.down);


    }
    
    else if ([indexPath row] == 0 && self.theSection.down == YES && [self.theSection.currentTitles count] >1)
    {
        //
        [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
                self.theSection.down = NO;
        [self.theSection.currentTitles removeObjectAtIndex:1];
        [self deleteRows:self forIndexPathRow:1 andSection:[indexPath section]];
        
        
        //why does this above change self.theSection.down == YES for that one particular sequence only??
        //self.theSection.down = NO;
        NSLog(@"down 2b? = %hhd", self.theSection.down);

    }
   
/*
    //section1
    if ([indexPath section]== 1 && [indexPath row] == 0 && self.section_1.down == NO)
    {
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"minus_button.png"]];
        [self.section_1.currentTitles insertObject:@"Sync Now" atIndex:1];
        [self insertRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.section_1.down = YES;

    }
    
    else if ([indexPath section]== 1 && [indexPath row] == 0 && self.section_1.down == YES && [self.section_1.currentTitles count] >1)
    {
        [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
        [self.section_1.currentTitles removeObjectAtIndex:1];
        [self deleteRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.section_1.down = NO;


    }*/
    
     else return;
    
}


@end
