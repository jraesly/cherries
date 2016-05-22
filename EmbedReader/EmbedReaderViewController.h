//
//  EmbedReaderViewController.h
//  EmbedReader
//
//  Created by John Raesly on 4/6/15.
//
//



#import <UIKit/UIKit.h>
//#import "History.h"
//@class History;

@interface EmbedReaderViewController: UIViewController<UIImagePickerControllerDelegate, ZBarReaderViewDelegate,  UINavigationControllerDelegate, UINavigationBarDelegate>{
    
    ZBarReaderView *readerView;
    UITextView *resultText;
    ZBarCameraSimulator *cameraSim;
    NSString *scanData, *scanTime, *scanType;
    NSNumber *data1;
    NSString *idl;
    BOOL working;
    IBOutlet UIButton *buttonFlash, *buttonFlashSwitch, *hint;
    IBOutlet UIImageView *img;
    IBOutlet UILabel *res;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (strong, nonatomic) NSString *scanData, *scanTime, *scanType;
@property (nonatomic, retain) NSNumber *data1;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property (nonatomic, retain) IBOutlet UILabel *res2;


- (IBAction)buttonHint;
- (IBAction)buttonPressed;
- (IBAction)buttonFlashSwitch;

@end

