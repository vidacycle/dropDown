//
//  dropDownTableVC.m
//  DropDownTable
//
//  Created by Abby Schlageter on 20/11/2013.
//  Copyright (c) 2013 Abby Schlageter. All rights reserved.
//

#import "dropDownTableVC.h"
#import "Sections.h"
#import "Design.h"
#import "InputMenus.h"

@interface dropDownTableVC ()

@property (nonatomic, retain) NSMutableArray *sections;
@property (nonatomic, retain) NSDictionary *dictionary;
@property (nonatomic, retain) Sections *theSection;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;
@property (nonatomic) NSInteger selectedSection;
@property (nonatomic, retain) Design *design;
@property (nonatomic, retain) InputMenus *menus;


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
    
    //init design
    self.design = [[Design alloc] init];
    self.tableView.separatorColor= [UIColor clearColor];

    self.progressView.hidden = YES;
    self.menus = [[InputMenus alloc] init];
    self.dictionary = [self.menus setUpMenus];
    self.sections = self.menus.sections;
    
    //large integer well outside of range of number of sections, allows to determine when no sections selected
    self.selectedSection = 1100;
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
    static NSString *CellIdentifier = @"Main";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li",(long)[indexPath section]]];
    [[cell textLabel] setText:[self.theSection.currentTitles objectAtIndex:[indexPath row]]];
    
    //design for main cell
    [self.design designForMainCell:cell];

    //for all drop down parts of table alternative design style
     if ([indexPath row] >0) {
         [self.design designForDropDownCells:cell];
     }

    return cell;
}
         
- (IBAction)insertRows:(id)sender forIndexPathRow:(NSInteger)row andSection:(NSInteger)section
{
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:section], nil];

   self.tableView = (UITableView *)self.view;
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];

}


- (void)deleteRow:(NSInteger)row andSection:(NSInteger)section
{
    NSArray *deleteIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:section], nil];
    
    NSLog(@"deleteIndexPaths = %@", deleteIndexPaths);
    NSLog(@"row %ld, section %ld", (long)row, (long)section);
    
    self.tableView = (UITableView *)self.view;
     NSLog(@"the section %@", self.theSection);
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    NSLog(@"the section %@", self.theSection);
    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li", (long)section]];
        NSLog(@"the section %@", self.theSection);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li",(long)[indexPath section]]];
    NSLog(@"down 1? = %i", self.theSection.down);
    NSLog(@"objectForKey: %@",[NSString stringWithFormat:@"%li",(long)[indexPath section]]);
    NSLog(@"titles %@ and current titles %@", self.theSection.titles, self.theSection.currentTitles);
    //row0
    if ([indexPath row] == 0 && self.theSection.down == NO)
    {
        self.selectedSection = indexPath.section;
        cell.accessoryView = [self.design deleteCellAccessory];
        
        for (int i=1; i<[self.theSection.titles count]; i++) {
        [self.theSection.currentTitles insertObject:[self.theSection.titles objectAtIndex:i] atIndex:i];
        [self insertRows:self forIndexPathRow:i andSection:[indexPath section]];
        }
        self.theSection.down = YES;
        NSLog(@"down 2a? = %i", self.theSection.down);

    }
    
    else if ([indexPath row] == 0 && self.theSection.down == YES && [self.theSection.currentTitles count] >1)
    {
        //
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self.design addCellAccessory];
        self.theSection.down = NO;
        
        for (int i=([self.theSection.currentTitles count]-1); i>0; i--) {
        [self.theSection.currentTitles removeObjectAtIndex:i];
        [self deleteRow:i andSection:[indexPath section]];
        }
        NSLog(@"down 2b? = %i", self.theSection.down);
        self.selectedSection = 1100; //set to a number far outside the bounds of the number of sections that actually exist

    }
    else if ([[self.theSection.currentTitles objectAtIndex:1] isEqual:@"Sync Now"])
    {
        [self showProgressBarAndToolbar];

    }
    
     else return;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rows in selectedSection should be selectable, or if selectedSection = 1100 (i.e none of the sections are currently selected)
    if(self.selectedSection == 1100 || indexPath.section == self.selectedSection)
    {
        return indexPath;
    }
    //else all other sections/rows should not be selectable
    else return nil;

    
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
