//
//  EmbedReaderViewController.m
//  EmbedReader
//
//  Created by John Raesly on 4/6/15.
//
//

#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVFoundation.h>

#import "EmbedReaderViewController.h"
#import "Scan_history.h"
#import "Result.h"
#import "Settings_DB.h"



@implementation EmbedReaderViewController

//@synthesize historyController;
//@synthesize flashButton;
@synthesize window = _window;
@synthesize scanData, scanTime, scanType, data1;
@synthesize readerView, resultText;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (void) cleanup
{
    [cameraSim release];
    cameraSim = nil;
    readerView.readerDelegate = nil;
    [readerView release];
    readerView = nil;
    [resultText release];
    resultText = nil;
}

- (void) dealloc
{
  
    [self cleanup];
    [super dealloc];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"scanner", nill);
    readerView.readerDelegate = self;
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(showGenerate)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(selectPhoto)];

    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc] initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}

-(void)showGenerate {
    
    //NSLog(@"Eh up, someone just pressed the button!");
    [self performSegueWithIdentifier:@"showGenerate" sender:self];
}



- (void) viewDidUnload
{
    working = false;
    [self cleanup];
    [super viewDidUnload];
}

- (void)viewWillLayoutSubviews{
    
    /*
    float X_Co = (self.view.frame.size.width - 160)/2;
    float Y_Co = self.view.frame.size.height - 150;
    float Y_Co2 = self.view.frame.size.height - 230;
    float Y_Co3 = self.view.frame.size.height - 150;
    [buttonFlash setFrame:CGRectMake(X_Co, Y_Co3, 160, 40)];
    [res setFrame:CGRectMake(X_Co, Y_Co3, 160, 40)];
    [hint setFrame:CGRectMake(X_Co, Y_Co2, 160, 40)];
    */
    
    [hint setTag:1000];
    [hint setTitle:@"" forState:UIControlStateNormal];
    //button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:buttonFlash];
    [self.view addSubview:hint];
    [self.view addSubview:img];
    [self.view addSubview:res];
    res.text = @"";
    
    double delayInSeconds = 15.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if(!working){
            [hint setTitle:NSLocalizedString(@"set24", nill) forState:UIControlStateNormal];
        }
        
    });
    double delayInSeconds2 = 30.0;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds2 * NSEC_PER_SEC);
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        
        [hint setTitle:@"" forState:UIControlStateNormal];
    });
}

- (IBAction)buttonHint{
    
    [self performSegueWithIdentifier:@"scanHints" sender:self];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient duration: duration];
 /*
    
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"OK"
                                                         message:[NSString stringWithFormat:@"%lf", duration]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    
    [errorAlert show];
// */
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)orient{
    
    
    [readerView willRotateToInterfaceOrientation: orient duration: 0.300000];
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [readerView start];
    //[self performSelector:@selector(ori) withObject:self afterDelay:1.0 ];
    Settings_DB *settings = [Settings_DB getInstance];
    if([settings.torch  isEqual: @1]){
        
        readerView.torchMode = 1;
        [buttonFlash setImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
    }else{
        readerView.torchMode = 0;
        [buttonFlash setImage:[UIImage imageNamed:@"sun_inverse.png"] forState:UIControlStateNormal];
    }
    
    

}

- (void) ori{

    [readerView willRotateToInterfaceOrientation: self.interfaceOrientation
                                        duration: 0.300000];
}

- (void) viewWillDisappear: (BOOL) animated
{
    working = false;
    [readerView stop];
}

-(void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Image Picker Controller delegate methods


- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    ZBarReaderController *imageReader = [ZBarReaderController new];
    [imageReader.scanner setSymbology: ZBAR_I25
                               config: ZBAR_CFG_ENABLE
                                   to: 0];
    
    //SAVE IMAGE TO IBOUTLET
    //img.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    CGImageRef imgRef = [[info objectForKey: UIImagePickerControllerOriginalImage] CGImage];
    id <NSFastEnumeration> results = [imageReader scanImage:imgRef];  
    scanData = @"";
    //ADD: get the decode results
    //id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results) {
     
        scanData = symbol.data;
        //NSLog(@"Pick Loop %@, %i",scanData, scanData.length);
        //break;
    }
    
    if((scanData.length==0)) {

        NSLog(@"Pick UP %@, %lu",scanData, (unsigned long)scanData.length);
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"attention", nill)
                                                         message:NSLocalizedString(@"clp_msg4", nill)
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"cancel", nill)
                                               otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }else{
    
        //UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self finalizeScan];
        //NSLog(@"Pick UP %@",scanData);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        //resultText.text = sym.data;
 
        scanData = sym.data;
        break;
    }
    
    [self finalizeScan];
  
}


- (void)finalizeScan{
    
    
    
    
    
    
    
    working = true;
    int N=0;
    //PREPARE TIME
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter release];
    int startTime = [today timeIntervalSince1970];
    
    /*
    NSLog(@"TIME1%d", startTime);
    startTime = [today timeIntervalSince1970];
    double startTime2 = [today timeIntervalSince1970];
    NSLog(@"TIME2%f", startTime2);
    double startTime3 = [today timeIntervalSince1970];
    NSLog(@"TIME2%f", startTime3);
    */
    
    //INITIALIZE SETTINGS
    Settings_DB *settings = [Settings_DB getInstance];
    //INITIALIZE DB
    NSManagedObjectContext *context = [self managedObjectContext];
    //CHECK IF USER ALLOWS REPEATED SCANS
    if([settings.history isEqual:@1]){
        if(!([settings.t1 isEqual:@1])){
            
            //QUERY FOR MATCHING RECORDS
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"scan_data == %@", scanData];
            [request setEntity:[NSEntityDescription entityForName:@"Scan_history" inManagedObjectContext:context]];
            [request setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *results = [context executeFetchRequest:request error:&error];
            N = (int)results.count;
            if(N>0){
                
                Scan_history *scan_history_up = [results objectAtIndex:0];
                scan_history_up.time = [NSNumber numberWithInt:startTime];
                
                
                if (![context save:&error]) {
                    //NSLog(@"Error");
                }
            }
        }
    }
    
    NSString *temp = [scanData lowercaseString];
    
    if([temp hasPrefix:@"http://"] || [temp hasPrefix:@"https://"]){
        data1 = @2;
    }else if([temp hasPrefix:@"tel:"]){
        data1 = @3;
    }else if([temp hasPrefix:@"smsto:"]){
        data1 = @4;
    }else if([temp hasPrefix:@"mailto:"]){
        data1 = @5;
    }else if([temp hasPrefix:@"matmsg:"]){
        data1 = @6;
    }else if([temp hasPrefix:@"geo:"]){
        data1 = @7;
    }else if([temp hasPrefix:@"begin:vcard"]){
        data1 = @8;
    }else if([temp hasPrefix:@"begin:mecard"] || [temp hasPrefix:@"mecard:"]){
        data1 = @9;
    }else if([temp hasPrefix:@"wifi:"]){
        data1 = @10;
    }else{
        
        data1 = @1;
    }
    
    res.text = temp;
    if([settings.history isEqual:@1]){
        if(N==0){
            //GET Scan_history INSTANCE
            Scan_history *scan_history = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"Scan_history"
                                          inManagedObjectContext:context];
            //ADD RESULTS TO DATABASE
            idl = [NSString stringWithFormat:@"%lf", [today timeIntervalSince1970]];
            scan_history.idl = idl;
            scan_history.scan_data = scanData;
            scan_history.scan_data_clean = scanData;
            scan_history.data1 = [NSNumber numberWithInt: [data1 integerValue]];
            scan_history.time = [NSNumber numberWithInt:startTime];
            
            //if([settings.history isEqual:@1]){
            NSError *error;
            if (![context save:&error]) {
                //NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            //}
        }
    }
    if([settings.vibrate isEqual:@1]){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if([settings.beep isEqual:@1]){
        AudioServicesPlaySystemSound(1255);//1201//1307
    }
    if([settings.bulk isEqual:@0]){
        [self performSegueWithIdentifier:@"showResult2" sender:self];
    }
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showResult2"]) {
        
        Result *temp = segue.destinationViewController;
        temp.idl = idl;
        temp.scan_data = scanData;
        // temp.time = @"just now";
        temp.data1 = data1;
    }
}

- (IBAction)buttonPressed{

    EmbedReaderViewController *viewController = [[EmbedReaderViewController alloc] initWithNibName:@"Result" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)buttonFlashSwitch {
    
    
    // check if flashlight available
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        Settings_DB *settings = [Settings_DB getInstance];
        if ([device hasTorch] && [device hasFlash]){

            if (device.flashMode != AVCaptureFlashModeOff)
            {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [buttonFlash setImage:[UIImage imageNamed:@"sun_inverse.png"] forState:UIControlStateNormal];
                settings.torch = @0;
                
            }
            else
            {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [buttonFlash setImage:[UIImage imageNamed:@"sun.png"] forState:UIControlStateNormal];
                settings.torch = @1;
                
            }
            //[device unlockForConfiguration];
        }
    }
    
    
    //nice Alert box
    /*
     UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error1"
     message:@"You can't leave the textbox empty!"
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [errorAlert show];
     [errorAlert release];
     [device lockForConfiguration:nil];
     */
}

- (IBAction)showCurl:(id)sender {
}

-  (void)myButtonClick:(id)sender {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"You can't leave the textbox empty!"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
    [errorAlert release];
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
