//
//  About.m
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import "Privacy.h"

@interface Privacy ()

@end

@implementation Privacy
@synthesize a1, a2, a3, a4, a5, a6, tableview;

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
    self.navigationItem.title = NSLocalizedString(@"help11", nill);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                    reuseIdentifier:CellIdentifier] autorelease];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    };
    //indexPath.section
    if(indexPath.section==0){
        cell.textLabel.text = NSLocalizedString(@"po1", nill);
        //cell.detailTextLabel.text = NSLocalizedString(@"help2", nill);
    }else if(indexPath.section==1){
        cell.textLabel.text = NSLocalizedString(@"po3", nill);
    }else if(indexPath.section==2){
        cell.textLabel.text = NSLocalizedString(@"po5", nill);
    }else if(indexPath.section==3){
        cell.textLabel.text = NSLocalizedString(@"po7", nill);
    }
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return NSLocalizedString(@"po2", nill);
    }else if (section == 1)
    {
        return NSLocalizedString(@"po4", nill);
    }else if (section == 2)
    {
        return NSLocalizedString(@"po6", nill);
    }else if (section == 3)
    {
        return NSLocalizedString(@"po8", nill);
    }
    
    return @"";
}

@end
