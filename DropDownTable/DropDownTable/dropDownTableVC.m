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
@property (nonatomic, retain) NSMutableArray *sections;
@property (nonatomic, retain) NSDictionary *dictionary;
@property (nonatomic, retain) Sections *theSection;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;



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

    self.progressView.hidden = YES;
    NSArray *sect0 = [[NSArray alloc] initWithObjects:@"Scan", @"Scan Now", nil];
    NSArray *sect1 = [[NSArray alloc] initWithObjects:@"Sync", @"Sync Now", nil];
    NSArray *sect2 = [[NSArray alloc] initWithObjects:@"Settings", @"Write", nil];
    
    self.sections = [[NSMutableArray alloc] initWithCapacity:10];
    NSArray *sectionsArray =[[NSArray alloc] initWithObjects:sect0, sect1, sect2, nil];
    
    [self createArraysForEachSection:[sectionsArray count] fromSectionRowTitles:sectionsArray];

    
}

-(void)createArraysForEachSection:(NSInteger)numberOfSections fromSectionRowTitles:(NSArray*)arrayOfSectionArrays
{
    for(int i=0; i<numberOfSections; i++)
    {
        Sections *sections = [[Sections alloc] initSectionWithTitles:[arrayOfSectionArrays objectAtIndex:i]];
        [self.sections addObject:sections];
    }
    
    NSLog(@"Section arrays all filled");
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i < [self.sections count]; i++) {
        [keys addObject:[NSString stringWithFormat:@"%i", i]];
    }
    
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
    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li",(long)section]];
    self.theSection.numberOfRows = [self.theSection.currentTitles count];
    rows = self.theSection.numberOfRows;

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
    
    [[cell textLabel] setFont:[UIFont fontWithName:@"Lato Light" size:20.0]];
    [cell setBackgroundColor:[UIColor colorWithRed:0 green:0.573 blue:0.271 alpha:1]];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    
    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li",(long)[indexPath section]]];
    [[cell textLabel] setText:[self.theSection.currentTitles objectAtIndex:[indexPath row]]];

    //for all drop down parts of table change color of background so it's obvious
     if ([indexPath row] >0) {
         //[cell setBackgroundColor:[UIColor whiteColor]];
         [[cell textLabel] setTextColor:[UIColor whiteColor]];
         [[cell textLabel] setFont:[UIFont fontWithName:@"Arial" size:16.0]];
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
    [self.table endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li",(long)[indexPath section]]];
    NSLog(@"down 1? = %i", self.theSection.down);
    NSLog(@"objectForKey: %@",[NSString stringWithFormat:@"%li",(long)[indexPath section]]);
    //row0
    if ([indexPath row] == 0 && self.theSection.down == NO)
    {
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"minus_button.png"]];
        [self.theSection.currentTitles insertObject:[self.theSection.titles objectAtIndex:1] atIndex:1];
        [self insertRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.theSection.down = YES;
        NSLog(@"down 2a? = %i", self.theSection.down);

    }
    
    else if ([indexPath row] == 0 && self.theSection.down == YES && [self.theSection.currentTitles count] >1)
    {
        //
        [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
                self.theSection.down = NO;
        [self.theSection.currentTitles removeObjectAtIndex:1];
        [self deleteRows:self forIndexPathRow:1 andSection:[indexPath section]];
        NSLog(@"down 2b? = %i", self.theSection.down);

    }
    else if ([[self.theSection.currentTitles objectAtIndex:1] isEqual:@"Sync Now"])
    {
        [self showProgressBarAndToolbar];

    }
    
     else return;
    
}

-(IBAction)onCancelTapped:(id)sender
{
    //when cancel button tapped
    NSLog(@"cancel button called");
    self.tableView.userInteractionEnabled = YES;
    self.progressView.hidden = YES;
    self.navigationController.toolbarHidden = YES;
    
}

-(void)showProgressBarAndToolbar
{
    self.tableView.userInteractionEnabled = NO;
    self.navigationController.toolbarHidden = NO;
    self.progressView.hidden = NO;

    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.navigationController.toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain    target:self     action:@selector(onCancelTapped:)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:spaceItem, customItem, spaceItem, nil];
    
    [self setToolbarItems:toolbarItems animated:NO];
}

@end
