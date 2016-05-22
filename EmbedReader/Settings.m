//
//  Settings.m
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import "Settings.h"
#import "Settings_DB.h"
#import "Settings_temp.h"
#import "Scan_history.h"


@interface Settings ()

@end

@implementation Settings
@synthesize label1, label2, label3, label4, label5, label6, settings_db;
@synthesize switch1, switch2, switch3, switch4, switch5, switch6;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

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
    Settings_DB *settings = [Settings_DB getInstance];
    [switch1 setOn:[settings.link integerValue] animated:NO];
    [switch2 setOn:[settings.vibrate integerValue] animated:NO];
    [switch3 setOn:[settings.beep integerValue] animated:NO];
    [switch4 setOn:[settings.history integerValue] animated:NO];
    [switch5 setOn:[settings.t1 integerValue] animated:NO];
    [switch6 setOn:[settings.bulk integerValue] animated:NO];
    
    self.navigationItem.title = NSLocalizedString(@"settings", nill);
    label1.text = NSLocalizedString(@"set1", nill);
    label2.text = NSLocalizedString(@"set3", nill);
    label3.text = NSLocalizedString(@"set5", nill);
    label4.text = NSLocalizedString(@"set7", nill);
    label5.text = NSLocalizedString(@"set17", nill);
    label6.text = NSLocalizedString(@"set25", nill);
    
    //label1.text = [NSString stringWithFormat:@"%i",[settings.beep intValue]];
    
    
  
/*
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"OK"
                                                         message:@"OK"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
*/
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction) changeSwitch1: (id) sender {
    
    Settings_DB *settings = [Settings_DB getInstance];
    UISwitch *onoff = (UISwitch *) sender;
    settings.link = ((onoff.on) ? @1:@0);
    [self updateDB];
}

- (IBAction) changeSwitch2: (id) sender {
    
    Settings_DB *settings = [Settings_DB getInstance];
    UISwitch *onoff = (UISwitch *) sender;
    settings.vibrate = ((onoff.on) ? @1:@0);
    [self updateDB];
}

- (IBAction) changeSwitch3: (id) sender {
    
    Settings_DB *settings = [Settings_DB getInstance];
    UISwitch *onoff = (UISwitch *) sender;
    settings.beep = ((onoff.on) ? @1:@0);
    [self updateDB];
}

- (IBAction) changeSwitch4: (id) sender {
    
    Settings_DB *settings = [Settings_DB getInstance];
    UISwitch *onoff = (UISwitch *) sender;
    settings.history = ((onoff.on) ? @1:@0);
    [self updateDB];
    
    if(!onoff.on){
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"set13",nil) message:NSLocalizedString(@"set14",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancel",nil) otherButtonTitles:NSLocalizedString(@"yes",nil), nil] autorelease];
        [alert setTag:0];
        [alert show];
        //[self updateDB];
         // [alert release];
    }else{
        //[self updateDB];
    }
}

- (IBAction) changeSwitch5: (id) sender {
    
    Settings_DB *settings = [Settings_DB getInstance];
    UISwitch *onoff = (UISwitch *) sender;
    settings.t1 = ((onoff.on) ? @1:@0);
    [self updateDB];
}

- (IBAction) changeSwitch6: (id) sender {
    
    Settings_DB *settings = [Settings_DB getInstance];
    UISwitch *onoff = (UISwitch *) sender;
    settings.bulk = ((onoff.on) ? @1:@0);
    [self updateDB];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //Settings_DB *settings = [Settings_DB getInstance];
    switch (buttonIndex) {
        case 0:
        {
            //[switch4 setOn:YES animated:YES];
            //settings.history = @1;
        }
        break;
        case 1:
        {
            NSManagedObjectContext *context2 = [self managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:@"Scan_history" inManagedObjectContext:context2]];
            //[request setIncludesPropertyValues:NO]; //only fetch the managedObjectID
            
            NSError *error = nil;
            NSArray *allObjects = [context2 executeFetchRequest:request error:&error];
            
            
            if(error){
                
                //NSLog(@"cdscdC");
            }else{
            
                for (NSManagedObject *object in allObjects) {
                    [context2 deleteObject:object];
                }
                
                NSError *saveError = nil;
                if (![context2 save:&saveError]) {
                    // [[NSApplication sharedApplication] presentError:error];
                }
            }
            //[allObjects release];
            //[request release];
            //[context2 release];
            [self updateDB];
        }
        break;
    }
}
- (void)updateDB{
    
    Settings_DB *settings = [Settings_DB getInstance];
    //SET SETTINGS TO DB
    NSError *error = nil;
    
    //This is your NSManagedObject subclass
    Settings_temp * settings_temp = nil;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Settings" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"sid=%@",@1]];
    
    //Ask for it
    settings_temp = [[context executeFetchRequest:request error:&error] lastObject];
    [request release];
    
    if (error) {
        //Handle any errors
    }
    
    if (!settings_temp) {
        //Nothing there to update
    }
    
    //Update the object
    settings_temp.link = settings.link;
    settings_temp.beep = settings.beep;
    settings_temp.vibrate = settings.vibrate;
    settings_temp.history = settings.history;
    settings_temp.backlight = settings.backlight;
    settings_temp.bulk = settings.bulk;
    settings_temp.t1 = settings.t1;
    
    //Save it
    error = nil;
    if (![context save:&error]) {
        //Handle any error with the saving of the context
    }
 
 
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
        return NSLocalizedString(@"set2", nill);
    }else if (section == 1)
    {
        return NSLocalizedString(@"set26", nill);
    }else if (section == 2)
    {
        return NSLocalizedString(@"set18", nill);
    }else if (section == 3)
    {
        return NSLocalizedString(@"set6", nill);
    }else if (section == 4)
    {
        return NSLocalizedString(@"set8", nill);
    }else if (section == 5)
    {
        return NSLocalizedString(@"set18", nill);
    }
    //}
    return @"";
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
