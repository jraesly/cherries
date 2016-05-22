//
//  EmbedReaderAppDelegate.h
//  EmbedReader
//
//  Created by John Raesly on 4/6/15.
//
//


#import <UIKit/UIKit.h>

@class EmbedReaderViewController;

@interface EmbedReaderAppDelegate
    : NSObject
    < UIApplicationDelegate >
{
    UIWindow *window;
    UINavigationController *navController;
}
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EmbedReaderViewController *viewController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@end
