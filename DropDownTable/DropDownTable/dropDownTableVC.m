//
//  dropDownTableVC.m
//  DropDownTable
//
//  Created by Abby Schlageter on 20/11/2013.
//  Copyright (c) 2013 Abby Schlageter. All rights reserved.
//

#import "dropDownTableVC.h"

@interface dropDownTableVC ()

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *section0;
@property (nonatomic) NSInteger numberOfRows0;
@property (nonatomic) BOOL down0;
@property (nonatomic, retain) NSMutableArray *section1;
@property (nonatomic) NSInteger numberOfRows1;
@property (nonatomic) BOOL down1;

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
    
    //fill section arrays
    self.section0 = [[NSMutableArray alloc] init];
    [self.section0 addObject:@"Scan"];
    self.down0 = NO;
    
    
    self.section1 = [[NSMutableArray alloc] init];
    [self.section1 addObject:@"Sync"];
    self.down1 = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            self.numberOfRows0 = [self.section0 count];
            rows = self.numberOfRows0;
            break;
        case 1:
            self.numberOfRows1 = [self.section1 count];
            rows = self.numberOfRows1;
            break;
        default:
            break;
    }
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
    
    [[cell textLabel] setFont:[UIFont fontWithName:@"Lato-Light" size:16.0]];
    [cell setBackgroundColor:[UIColor colorWithRed:0 green:0.573 blue:0.271 alpha:1]];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    
    switch ([indexPath section]) {
        case 0:
            [[cell textLabel] setText:[self.section0 objectAtIndex:[indexPath row]]];
            break;
        case 1:
            [[cell textLabel] setText:[self.section1 objectAtIndex:[indexPath row]]];
            break;
        default:
            break;
    }
    
    //for all drop down parts of table change color of background so it's obvious
     if ([indexPath row] == 1) {
         [cell setBackgroundColor:[UIColor whiteColor]];
         [[cell textLabel] setTextColor:[UIColor grayColor]];
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

    //section0
    if ([indexPath section]== 0 && [indexPath row] == 0 && self.down0 == NO)
    {
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"minus_button.png"]];
        [self.section0 insertObject:@"Scan Now" atIndex:1];
        [self insertRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.down0 = YES;


    }
    
    else if ([indexPath section]== 0 && [indexPath row] == 0 && self.down0 == YES && [self.section0 count] >1)
    {
        
        [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
        [self.section0 removeObjectAtIndex:1];
        [self deleteRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.down0 = NO;

    }
    
    //section1
    if ([indexPath section]== 1 && [indexPath row] == 0 && self.down1 == NO)
    {
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"minus_button.png"]];
        [self.section1 insertObject:@"Sync Now" atIndex:1];
        [self insertRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.down1 = YES;

    }
    
    else if ([indexPath section]== 1 && [indexPath row] == 0 && self.down1 == YES && [self.section1 count] >1)
    {
        [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
        cell.accessoryView = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
        [self.section1 removeObjectAtIndex:1];
        [self deleteRows:self forIndexPathRow:1 andSection:[indexPath section]];
        self.down1 = NO;


    }
    
     else return;
}


@end
