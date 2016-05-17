//
//  About.m
//  QRcode
//
//  Created by Pavels Lukasenko on 11/17/13.
//
//

#import "Help.h"

@interface Help ()

@end

@implementation Help
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
    self.navigationItem.title = NSLocalizedString(@"help", nill);
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
        cell.textLabel.text = NSLocalizedString(@"help3", nill);
        //cell.detailTextLabel.text = NSLocalizedString(@"help2", nill);
    }else if(indexPath.section==1){
        cell.textLabel.text = NSLocalizedString(@"help5", nill);
    }else if(indexPath.section==2){
        cell.textLabel.text = NSLocalizedString(@"help9", nill);
    }else if(indexPath.section==3){
        cell.textLabel.text = NSLocalizedString(@"help13", nill);
    }
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return NSLocalizedString(@"help4", nill);
    }else if (section == 1)
    {
        return NSLocalizedString(@"help6", nill);
    }else if (section == 2)
    {
        return NSLocalizedString(@"help10", nill);
    }else if (section == 3)
    {
        return NSLocalizedString(@"help14", nill);
    }
    
    return @"";
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

NSUInteger row = [indexPath section];
if (row == 0)
{
    [self performSegueWithIdentifier:@"scanHints" sender:self];
}else if (row == 1)
{
   // [self performSegueWithIdentifier:@"showHelp" sender:self];
}else if (row == 2)
{
  
}

}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
