//
//  Settings.h
//  QRcode
//
//  Created by Pavels Lukasenko on 11/14/13.
//
//

#import <UIKit/UIKit.h>
@class Settings_DB;

@interface Settings : UITableViewController
<UITextFieldDelegate, UITableViewDelegate> {
 
    UILabel *label1, *label2, *label3, *label4, *label5, *label6;
    UISwitch *switch1, *switch2, *switch3, *switch4, *switch5, *switch6;
}
@property (nonatomic, retain) IBOutlet UILabel *label1, *label2, *label3, *label4, *label5, *label6;
@property (nonatomic, retain) IBOutlet UISwitch *switch1, *switch2, *switch3, *switch4, *switch5, *switch6;
@property (nonatomic, retain) Settings_DB *settings_db;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

- (IBAction) changeSwitch1: (id) sender;
- (IBAction) changeSwitch2: (id) sender;
- (IBAction) changeSwitch3: (id) sender;
- (IBAction) changeSwitch4: (id) sender;
- (IBAction) changeSwitch5: (id) sender;
- (IBAction) changeSwitch6: (id) sender;
@end
