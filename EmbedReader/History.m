//
//  History.m
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import "History.h"
#import "Scan_history.h"
#import "Result.h"

@interface History ()

@end

@implementation History

- (id)initWithStyle:(UITableViewStyle)style
{
    //self = [super initWithStyle:style];
    //if (self) {
        // Custom initialization
    //}
    return self;
}
//@synthesize window = _window;
@synthesize scan_history;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"history", nill);
    /*
    UIButton *button1 = [[UIButton alloc] init];
    button1.frame=CGRectMake(0,0,30,30);
    [button1 setBackgroundImage:[UIImage imageNamed: @"upload.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(uploadHistory) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    */
    
    if ([MFMailComposeViewController canSendMail]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(uploadHistory)];
    
    }
    //  [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"more.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"sun.png"]];
  
}

- (void)uploadHistory{
    
    
    NSString *temp = @"";
    int i = 0;
    for(i=0;i<[scan_history count];i++){
        
       Scan_history *data = [scan_history objectAtIndex:i];
        
       temp = [temp stringByAppendingString:@"\""];
       temp = [temp stringByAppendingString:[data.scan_data_clean stringByReplacingOccurrencesOfString:@"\"" withString:@"'"]];
       temp = [temp stringByAppendingString:@"\",\""];
       temp = [temp stringByAppendingString:[data.time stringValue]];
       temp = [temp stringByAppendingString:@"\"\n"];
    }
  

    MFMailComposeViewController *mcv = [[MFMailComposeViewController alloc] init];
    mcv.mailComposeDelegate = self;
    
    [mcv setSubject:@"Data Export"];
    [mcv setToRecipients:[NSArray arrayWithObject:@""]];
    NSData* dtemp = [temp dataUsingEncoding:NSUTF8StringEncoding];
    
    [mcv setMessageBody:NSLocalizedString(@"raloco_qr_scan", nill) isHTML:NO];
    [mcv addAttachmentData:dtemp mimeType:@"txt/csv" fileName:@"data.csv"];
   
    [self presentViewController:mcv animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    //[self presentModalViewController:mcv animated:YES];
    //[mcv release];
}

#pragma mark - MFMailComposeViewControllerDelegate
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showResult"]) {
        
        Result *detailVC = segue.destinationViewController;
        
        NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        Scan_history *temp = [scan_history objectAtIndex:selectedPath.row];
        detailVC.scan_data = temp.scan_data;
        detailVC.data1 = temp.data1;
        detailVC.idl = temp.idl;
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    
    

}
- (void)viewWillAppear:(BOOL)animated{
    
    self.scan_history = nil;
    self.tabBarItem.image = [UIImage imageNamed:@"settings"];
    
    /*
     UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"OK"
                                                         message:@"OK"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
    */
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Scan_history" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *ids = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO selector:nil];
    //NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES selector:nil];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:ids, nil, nil];
    [fetchRequest setFetchLimit:1000];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSError *error;
    self.scan_history = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    [ids release];
    [self.tableView reloadData];
    
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    return NO;
}

- (void) dealloc {
    [super dealloc];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
}

- (void)viewDidUnLoad
{
     //  [self cleanup];
    
     self.scan_history = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.scan_history count];
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
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //HISTORY QR CODE IMAGE
    NSArray *imagesArr = [[NSMutableArray alloc] initWithObjects: @"info.png",@"info.png",@"global.png",@"keypad.png",@"mail.png",@"mail.png",@"mail.png",@"map.png", @"contact.png", @"contact.png", @"info.png", @"info.png", nil];
    /*
    if([temp hasPrefix:@"http://"]){
        scan_history.data1 = @2;
    }else if([temp hasPrefix:@"tel:"]){
        scan_history.data1 = @3;
    }else if([temp hasPrefix:@"smsto:"]){
        scan_history.data1 = @4;
    }else if([temp hasPrefix:@"mailto:"]){
        scan_history.data1 = @5;
    }else if([temp hasPrefix:@"matmsg:"]){
        scan_history.data1 = @6;
    }else if([temp hasPrefix:@"geo:"]){
        scan_history.data1 = @7;
    }else if([temp hasPrefix:@"begin:vcard"]){
        scan_history.data1 = @8;
    }else if([temp hasPrefix:@"begin:mecard"]){
        scan_history.data1 = @9;
    }else if([temp hasPrefix:@"wifi:"]){
        scan_history.data1 = @10;
    }else{
        
        scan_history.data1 = @1;
    }
    */
    //get scan data from array
    Scan_history *info = [scan_history objectAtIndex:indexPath.row];
    UIImage *cellImage = [UIImage imageNamed:[imagesArr objectAtIndex:[info.data1 integerValue]]];
    //get time from array
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[info.time doubleValue]];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    //organize cells          NSLog(@"%@", date);
    cell.imageView.image = cellImage;
    cell.textLabel.text = [self CleanOutput:info.scan_data_clean];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",date];
    cell.detailTextLabel.text = formattedDateString;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [dateFormatter release];
    //[*date release];
    return cell;
    
}

- (NSString*) CleanOutput:(NSString*)value{
    
    //EXTRA CLEANING
/*
    value = [value stringByReplacingOccurrencesOfString:@"smsto:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"SMSTO:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"matmsg:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"MATMSG:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"MECARD:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"mecard:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"BEGIN:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"BEGIN:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"FN:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"begin:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"VCARD" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"CHARSET" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"VERSION:2.1" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"VERSION:1.0" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"VERSION:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"UTF-8" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"utf-8" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"geo:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"to:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"TO:" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"N:" withString:@""];

    value = [value stringByReplacingOccurrencesOfString:@"," withString:@" "];
    value = [value stringByReplacingOccurrencesOfString:@"=" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@";" withString:@" "];
    value = [value stringByReplacingOccurrencesOfString:@":" withString:@" "];
 */
    value = [value stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    value = [value stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return value;
}

#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    [self performSegueWithIdentifier:@"showResult" sender:self];
}


// 1
- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}

//2
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"PhoneBook.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
@end
