//
//  History.h
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Scan_history.h"
@class Scan_history;
//@class Scan_history_store;

@interface History : UITableViewController
<UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate, MFMailComposeViewControllerDelegate>
{
  //  NSArray *scan_history;

}


//@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSArray *scan_history;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@end
