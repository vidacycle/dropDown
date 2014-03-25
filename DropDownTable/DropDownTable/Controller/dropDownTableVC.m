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
#import "AddDeleteRows.h"
#import "ImageViewController.h"

@interface dropDownTableVC ()

@property (nonatomic, retain) NSMutableArray *sections;
@property (nonatomic, retain) NSDictionary *dictionary;
@property (nonatomic, retain) Sections *theSection;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;
@property (nonatomic) NSInteger selectedSection;
@property (nonatomic, retain) Design *design;
@property (nonatomic, retain) InputMenus *menus;
@property (nonatomic, retain) NSString *theCellTitle;


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
    
    //get data from Model
    self.menus = [[InputMenus alloc] init];
    self.dictionary = [self.menus setUpMenus];
    self.sections = self.menus.sections;
    
    //large integer well outside of range of number of sections, allows to determine when no sections selected
    self.selectedSection = 1100;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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

#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    AddDeleteRows *handleRows = [[AddDeleteRows alloc] init];
    

    self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li",(long)[indexPath section]]];
    
    //if the main menu cell is selected
    if ([indexPath row] == 0 && self.theSection.down == NO)
    {
        self.selectedSection = indexPath.section;
        cell.accessoryView = [self.design deleteCellAccessory];
        
        //add all drop down cells for this section
        for (int i=1; i<[self.theSection.titles count]; i++) {
            [self.theSection.currentTitles insertObject:[self.theSection.titles objectAtIndex:i] atIndex:i];
            [handleRows insertRow:i andSection:[indexPath section] forTableView:self.tableView];
        }
        self.theSection.down = YES;

    }
    
    //if the main menu cell is de-selected
    else if ([indexPath row] == 0 && self.theSection.down == YES && [self.theSection.currentTitles count] >1)
    {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self.design addCellAccessory];
        self.theSection.down = NO;

        //remove all drop down cells for this section
        for (int i=([self.theSection.currentTitles count]-1); i>0; i--)
        {
            [self.theSection.currentTitles removeObjectAtIndex:i];

            [handleRows deleteRow:i andSection:[indexPath section] forTableView:self.tableView];
            
            //must re-assign self.theSection here as for some reason self.theSection changes when deleteRowsAtIndexPaths... is called
            //??????
            self.theSection = [self.dictionary objectForKey:[NSString stringWithFormat:@"%li", (long)[indexPath section]]];
        }
        
        self.selectedSection = 1100; //set to a number far outside the bounds of the number of sections that actually exist

    }
    //for all dropDown cells
    else if ([indexPath row] > 0)
    {

        self.theCellTitle = [self.theSection.currentTitles objectAtIndex:[indexPath row]];
        [self performSegueWithIdentifier:@"1" sender:self];
    }
     else return;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageViewController *destViewController = segue.destinationViewController;

    //set block for different images displayed in ImageVC depending on cellTitle
    void (^selectedDropDown)() = @{
                                   @"iOS" : ^{
                                    
                                       destViewController.image = [UIImage imageNamed:@"HygroSkin.jpg"];
                                   },
                                   @"html & CSS" : ^{

                                       destViewController.image = [UIImage imageNamed:@"Wonderpus.jpg"];
                                   },
                                   }[self.theCellTitle];
    
    //call block
    if (selectedDropDown != nil)
        selectedDropDown();

}


//if only want to be able to select one drop-down main menu cell at a time
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rows in selectedSection should be selectable, or if selectedSection = 1100 (i.e none of the sections are currently selected)
    if(self.selectedSection == 1100 || indexPath.section == self.selectedSection)
    {
        return indexPath;
    }
    //else all other sections/rows should not be selectable
    else return nil;
}


//optional progress bar functionality on same view - if one of the menu options calls a sync-like process then call these methods
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


-(IBAction)onCancelTapped:(id)sender
{
    //when cancel button tapped
    MyLog(@"cancel button called");
    self.tableView.userInteractionEnabled = YES;
    self.progressView.hidden = YES;
    self.navigationController.toolbarHidden = YES;
    
}


@end
