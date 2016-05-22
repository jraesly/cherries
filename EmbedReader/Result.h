//
//  Result.h
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//



#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
//#import <MessageUI/MFMailComposeViewController.h>
//#import <AddressBookUI/AddressBookUI.h>

@class GADBannerView;
@class Scan_history;

@interface Result : UITableViewController
<UITextFieldDelegate, UITableViewDelegate> {
    NSArray *data1Arr, *actionsArr, *imagesArr;
    NSNumber *data1;
    NSString *idl;
    NSString *scan_data, *scan_data_clean, *action1, *action2, *action3;
    Scan_history *scan_history;
    UITextView *resultText1;
    UITextView *resultText2;
    //UIView *banner;
    UILabel *label1;
    
}




@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@property (nonatomic, strong) NSArray *actionsArr, *data1Arr, *imagesArr;
@property (nonatomic, retain) NSNumber *data1;
@property (nonatomic, retain) NSString *scan_data, *scan_data_clean, *action1, *action2, *action3, *idl;
@property (nonatomic, retain) Scan_history *scan_history;
@property (nonatomic, retain) IBOutlet UITextView *resultText1, *resultText2;
@property (nonatomic, retain) IBOutlet UILabel *label1;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
//@property (nonatomic, retain) IBOutlet UIView *banner;
@property (nonatomic, retain) IBOutlet GADBannerView *bannerView;
//@property(nonatomic, weak) IBOutlet GADBannerView *bannerView;


@end
