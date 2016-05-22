//
//  EmbedReaderAppDelegate.m
//  EmbedReader
//
//  Created by John Raesly on 4/6/15.
//
//


#import "EmbedReaderAppDelegate.h"
#import "EmbedReaderViewController.h"
#import "History.h"
#import "Settings_DB.h"
#import "Settings_temp.h"

@implementation EmbedReaderAppDelegate
@synthesize window=_window;
@synthesize viewController=_viewController;
@synthesize navController;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)            application: (UIApplication*) application
  didFinishLaunchingWithOptions: (NSDictionary*) launchOptions
{
 
    
    //self.tabBarController.tabBarItem.image  = [UIImage imageNamed:@"settings.png"];
    //navController.tabBarItem.image = [UIImage imageNamed:@"settings.png"];
    

    Settings_DB *settings = [Settings_DB getInstance];

    //GET SETTINGS FROM DB
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Settings" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *ids = [[NSSortDescriptor alloc] initWithKey:@"sid" ascending:YES selector:nil];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:ids, nil, nil];
    [fetchRequest setFetchLimit:10];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSError *error;
    
    //CHECK IF SETTINGS NOT NULL
    NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
    if(count==0){
        NSManagedObjectContext *context = [self managedObjectContext];
        Settings_temp *settings_temp = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"Settings"
                                      inManagedObjectContext:context];
        settings_temp.sid = @1;settings.sid = settings_temp.sid;
        settings_temp.link = @1;settings.link = settings_temp.link;
        settings_temp.beep = @0;settings.beep = settings_temp.beep;
        settings_temp.vibrate = @1;settings.vibrate = settings_temp.vibrate;
        settings_temp.history = @1;settings.history = settings_temp.history;
        settings_temp.backlight = @1;settings.backlight = settings_temp.backlight;
        settings_temp.bulk = @0;settings.bulk = settings_temp.bulk;
        settings_temp.t1 = @1;settings.t1 = settings_temp.t1;
        settings_temp.t2 = @1;settings.t2 = settings_temp.t2;
        settings_temp.t3 = @1;settings.t3 = settings_temp.t3;
        settings_temp.t4 = @1;settings.t4 = settings_temp.t4;
        settings_temp.t5 = @1;settings.t5 = settings_temp.t5;
        settings_temp.t6 = @1;settings.t6 = settings_temp.t6;
        settings_temp.t7 = @1;settings.t7 = settings_temp.t7;
        settings_temp.t8 = @1;settings.t8 = settings_temp.t8;
        
        NSError *error;
        if (![context save:&error]) {
            //NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
    }else{
        Settings_temp *settings_temp = [[context executeFetchRequest:fetchRequest error:&error] objectAtIndex:0];
        settings.sid = settings_temp.sid;
        settings.link = settings_temp.link;
        settings.beep = settings_temp.beep;
        settings.vibrate = settings_temp.vibrate;
        settings.history = settings_temp.history;
        settings.backlight = settings_temp.backlight;
        settings.bulk = settings_temp.bulk;
        settings.t1 = settings_temp.t1;
    }

    //NSLog(@"%lu", (unsigned long)count);
    
    [fetchRequest release];
    [ids release];
    [ZBarReaderView class];
    return(YES);
}

- (void) dealloc
{
    [super dealloc];
    [_window release];
    [_viewController release];
    [navController release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    
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
