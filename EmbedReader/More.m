//
//  More.m
//  QRcode
//
//  Created by Pavels Lukasenko on 11/16/13.
//
//

#import "More.h"

@interface More ()

@end

@implementation More
@synthesize tableview, about, help, privacy, rate;

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
    //localization
    self.navigationItem.title = NSLocalizedString(@"more", nill);
    /*
    about.text = NSLocalizedString(@"about", nill);
    help.text = NSLocalizedString(@"help", nill);
    rate.text = NSLocalizedString(@"rate", nill);
    privacy.text = NSLocalizedString(@"help11", nill);
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    

    
   // if (tableView.tag==2)
   // {
        if (section == 0)
        {
            return [[NSLocalizedString(@"help2", nill) substringToIndex:64] stringByAppendingString:@".."];
        }else if (section == 1)
        {
            return [[NSLocalizedString(@"help4", nill) substringToIndex:64] stringByAppendingString:@".."];
        }else if (section == 2)
        {
            return NSLocalizedString(@"ratesub", nill);
        }else if (section == 3)
        {
            return [NSLocalizedString(@"po1", nill) stringByAppendingString:@".."];
        }
    //}
   
    //return cell;
    return @"";
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //nice Alert box
    /*    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%d", row]
     message:info.scan_data
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [errorAlert show];
     [errorAlert release];
     
     */
    
    NSUInteger row = [indexPath section];
    if (row == 0)
    {
        //[self performSegueWithIdentifier:@"showAbout" sender:self];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://kenzap.com/project/qr-code-scanner/"]];
        
    }else if (row == 1)
    {
       [self performSegueWithIdentifier:@"showHelp" sender:self];
    }else if (row == 2)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/ie/app/raloco-qr-scan/id762587481"]];
        
        //return NSLocalizedString(@"ratesub", nill);
    }else if (row == 3)
    {
       [self performSegueWithIdentifier:@"showPrivacy" sender:self];
    }
    //Scan_history *info = [scan_history objectAtIndex:indexPath.row];
    //   [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                    reuseIdentifier:CellIdentifier] autorelease];

    
    NSUInteger row = [indexPath section];
    NSString *txt = @"";
    if (row == 0)
    {
        txt = NSLocalizedString(@"about", nill);
    }else if (row == 1)
    {
        txt = NSLocalizedString(@"help", nill);
    }else if (row == 2)
    {
        txt = NSLocalizedString(@"rate", nill);
    }else if (row == 3)
    {
        txt = NSLocalizedString(@"help11", nill);
    }
  
    cell.textLabel.text = txt;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
*/
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
