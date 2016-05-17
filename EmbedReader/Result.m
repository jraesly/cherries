//
//  Result.m
//  QRcode
//
//  Created by Pavels Lukasenko on 11/11/13.
//
//


#import "Result.h"
#import "RawOutput.h"
#import "Settings_DB.h"
#import "Scan_history.h"

@interface Result ()

@end

@implementation Result
@synthesize data1, scan_data, scan_data_clean, action1, action2, action3;
@synthesize scan_history;
@synthesize label1;
@synthesize resultText1;
@synthesize resultText2;
@synthesize data1Arr, actionsArr, imagesArr, idl;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    Settings_DB *settings = [Settings_DB getInstance];
    [super viewDidLoad];
    NSInteger temp  = [data1 integerValue];
    NSString *scan_data_clean_in = scan_data;
    action1 = @"";action2 = @"";action3 = @"";
    data1Arr = [[NSMutableArray alloc] initWithObjects: @"text", @"text", @"link", @"phone", @"sms", @"email", @"email", @"geo", @"contact", @"contact", @"wifi", nil];
    
    
    NSArray *titles;
    NSMutableDictionary *temp3;
    NSMutableString *temp4;
    switch(temp){
        //TEXT
        case 1:
            
            //TRIM DATA
            scan_data_clean_in = [scan_data_clean_in stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            //SWITCH TO TEXT DATA
            if ([scan_data_clean_in rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
                
                actionsArr = [[NSMutableArray alloc] initWithObjects: @"google_search", @"share", @"text_copy", @"raw", nil];
                imagesArr = [[NSMutableArray alloc] initWithObjects: @"global.png", @"upload.png", @"copy.png", @"info.png", nil];
                
            //SWITCH TO NUMERIC BARCODE LIKE
            }else{
                
                actionsArr = [[NSMutableArray alloc] initWithObjects: @"google_search", @"google_product", @"share", @"text_copy", @"raw", nil];
                imagesArr = [[NSMutableArray alloc] initWithObjects: @"global.png", @"shopbag.png", @"upload.png", @"copy.png", @"info.png", nil];
                
            }
         
            NSString *url = @"http://www.google.com/search?q=";
            url = [url stringByAppendingString:scan_data_clean_in];
            action1 = [[NSString alloc] initWithString:url];
           
            url = @"http://www.google.com/m/products?q=";
            url = [url stringByAppendingString:scan_data_clean_in];
            url = [url stringByAppendingString:@"&tbm=shop"];
            action2 = [[NSString alloc] initWithString:url];
            [action2 retain];
            //action2 = [[NSString alloc] initWithString:@"http://www.google.com/m/products?q="];
            //action2 = [action2 stringByAppendingString:scan_data_clean_in];
            //AUTO REDIRECT
            if([settings.link isEqual:@1] && temp == 1){
                
                [[UIApplication sharedApplication] openURL: [NSURL URLWithString:action1]];
            }
        break;
        //HTTP:
        case 2:
        
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"link_open", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"global.png", @"upload.png", @"copy.png", @"info.png", nil];
            
            //AUTO REDIRECT
            if([settings.link isEqual:@1] && temp == 2){
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scan_data]];
            }
        break;
        //TEL
        case 3:
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"call_make", @"contact_add", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"keypad.png", @"contact.png", @"upload.png", @"copy.png", @"info.png", nil];
            titles = [[NSMutableArray alloc] initWithObjects: @"TEL:", nil];
            //PARSE DATA
            temp3 = [self QRparser:titles :[scan_data_clean_in stringByAppendingString:@";"] :';'];
            temp4 = [[NSMutableString alloc] init];
            //FROM ARRAY PARSE DATA PREPARE scan_data_clean_in FINAL VIEW key value new line
            for (NSString* key in [temp3 allKeys]) {
                //NSLog(@"key: %@, value: %@", key, [temp3 objectForKey:key]);
                [temp4 appendString:[temp3 objectForKey:key]];
                [temp4 appendString:@"\r"];
            }
            scan_data_clean_in = temp4;
            //SET ACTION1
            action1 = @"";action2 = @"";action3 = @"";
            if ([[temp3 allKeys] containsObject:@"TEL:"]) {
                action1 = [temp3 objectForKey:@"TEL:"];
                //CLEAN PHONE NUMBER
                action1 = [self cleanPhone:action1];
                [action1 retain];
            }

        break;
        //SMSTO
        case 4:
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"sms_send", @"call_make", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"mail.png", @"keypad.png", @"upload.png", @"copy.png", @"info.png", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"SMSTO:" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"smsto:" withString:@""];
            
            if ([scan_data_clean_in rangeOfString:@":"].location != NSNotFound){
                
                NSArray *temp2 = [scan_data_clean_in componentsSeparatedByString:@":"];
                action1 = [[NSString alloc] initWithString:[temp2 objectAtIndex:0]];
                action2 = [[NSString alloc] initWithString:[temp2 objectAtIndex:1]];
                //CLEAN PHONE NUMBER
                action1 = [self cleanPhone:action1];
                [action1 retain];
                [action2 retain];
                
                scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@":" withString:@"\r"];

                //NSLog(@"action %@", action1);
            }else{
                
                action1 = scan_data_clean_in;
                [action1 retain];
            }
        break;
        //EMAILTO
        case 5:
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"email_send", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"mail.png", @"upload.png", @"copy.png", @"info.png", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"MAILTO:" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
            
            if ([scan_data_clean_in rangeOfString:@"?body="].location != NSNotFound){
                
                NSArray *temp2 = [scan_data_clean_in componentsSeparatedByString:@"?body="];
                action1 = [[NSString alloc] initWithString:[temp2 objectAtIndex:0]];
                scan_data_clean_in = action1;
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:@"\r"];
                action2 = [[NSString alloc] initWithString:[temp2 objectAtIndex:1]];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:action2];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:@"\r"];
                action3 = [[NSString alloc] initWithString:@""];
             
                [action1 retain];
                [action2 retain];
                [action3 retain];
            }else{
                
                
                action1 = scan_data_clean_in;
                [action1 retain];
            }
        break;
        //MATMSG
        case 6:
            //SPECIAL ARRAYS
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"email_send", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"mail.png", @"upload.png", @"copy.png", @"info.png", nil];
            titles = [[NSMutableArray alloc] initWithObjects: @"TO:", @"SUB:", @"BODY:", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"matmsg:" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"MATMSG:" withString:@""];
            //PARSE DATA
            temp3 = [self QRparser:titles :[scan_data_clean_in stringByAppendingString:@";"] :';'];
            temp4 = [[NSMutableString alloc] init];
            //FROM ARRAY PARSE DATA PREPARE scan_data_clean_in FINAL VIEW key value new line
            for (NSString* key in [temp3 allKeys]) {
                
                [temp4 appendString:[temp3 objectForKey:key]];
                [temp4 appendString:@"\r"];
            }
            scan_data_clean_in = temp4;
            //SET ACTION1
            if ([[temp3 allKeys] containsObject:@"TO:"]) {
                 action1 = [temp3 objectForKey:@"TO:"];
                [action1 retain];
            }
            //SET ACTION2
            if ([[temp3 allKeys] containsObject:@"SUB:"]) {
                action2 = [temp3 objectForKey:@"SUB:"];
                [action2 retain];
            }
            //SET ACTION3
            if ([[temp3 allKeys] containsObject:@"BODY:"]) {
                action3 = [temp3 objectForKey:@"BODY:"];
                [action3 retain];
            }
        break;
        //GEO
        case 7:
            //SPECIAL ARRAYS
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"geo_find", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"map.png", @"upload.png", @"copy.png", @"info.png", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"GEO:" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"geo:" withString:@""];
            
            if ([scan_data_clean_in rangeOfString:@","].location != NSNotFound){
                
                NSArray *temp2 = [scan_data_clean_in componentsSeparatedByString:@","];
                scan_data_clean_in = @"";
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:NSLocalizedString(@"latitude",nil)];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:@": "];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:[temp2 objectAtIndex:0]];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:@"\r"];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:NSLocalizedString(@"longitude",nil)];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:@": "];
                scan_data_clean_in = [scan_data_clean_in stringByAppendingString:[temp2 objectAtIndex:1]];
                
                action1=[[NSString alloc] initWithString:[temp2 objectAtIndex:0]];// "@fff";
                action2=[[NSString alloc] initWithString:[temp2 objectAtIndex:1]];
               
                [action1 retain];
                [action2 retain];
            }else{
                
                action1 = [[NSString alloc] initWithString:scan_data_clean_in];
                [action1 retain];
            }

        break;
        //VCARD
        case 8:
            //SPECIAL ARRAYS
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"call_make", @"contact_copy", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"keypad.png", @"contact.png", @"upload.png", @"copy.png", @"info.png", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"begin:vcard" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@";CHARSET=UTF-8" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@";CHARSET=utf-8" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@";charset=utf-8" withString:@""];
            
            titles = [[NSMutableArray alloc] initWithObjects: @"FN:",@"N:",@"TITLE:",@"ORG:",@"TEL:",@"CELL:",@"TEL;WORK:",@"TEL;HOME:",@"FAX:",@"EMAIL:",@"INTERNET:",@"ADR:",@"URL:",@"ADR;WORK:",@"ADR;HOME:", nil];
            
            //REMOVER VERSION:
            scan_data_clean_in = [scan_data_clean_in stringByReplacingOccurrencesOfString:@"VERSION:" withString:@""];
            //PARSE DATA
            temp3 = [self QRparser:titles :[scan_data_clean_in stringByAppendingString:@";"] :10];
            temp4 = [[NSMutableString alloc] init];
            //FROM ARRAY PARSE DATA PREPARE scan_data_clean_in FINAL VIEW key value new line
            BOOL block = false;
            for(NSString *title in titles){
                
                //ITERATE THROUGH TITLES THAT WERE FOUND
                if ([[temp3 allKeys] containsObject:title]) {
                    
                    //CLEAN  GARBAGE BEFORE OUTPUT
                    NSString *temp5 = [[temp3 objectForKey:title] stringByReplacingOccurrencesOfString:@";" withString:@" "];
                    temp5 = [temp5 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    
              
                    
                    //N: FN: REPEAT NAME SURNAME SOLUTION
                    if(([title isEqual:@"FN:"] || [title isEqual:@"N:"]) && !block){
                        //NSLog(@"@AAAA");
                        if([temp5 length]>0){
                            block = true;
                        }
                        [temp4 appendString:temp5];
                        [temp4 appendString:@"\r"];
                    }
                    if(![title isEqual:@"FN:"] && ![title isEqual:@"N:"]){
                        
                        
                        [temp4 appendString:temp5];
                        if([title isEqual:@"CELL:"]) {
                            
                            [temp4 appendString:@" ("];
                            [temp4 appendString:NSLocalizedString(@"mobile","mobile")];
                            [temp4 appendString:@")"];
                        }
                        if([title isEqual:@"TEL;WORK:"]) {
                            
                            [temp4 appendString:@" ("];
                            [temp4 appendString:NSLocalizedString(@"work","work")];
                            [temp4 appendString:@")"];
                        }
                        if([title isEqual:@"TEL;HOME:"]) {
                            
                            [temp4 appendString:@" ("];
                            [temp4 appendString:NSLocalizedString(@"home","home")];
                            [temp4 appendString:@")"];
                        }
                        if([title isEqual:@"FAX:"]) {
                            
                            [temp4 appendString:@" ("];
                            [temp4 appendString:NSLocalizedString(@"fax","fax")];
                            [temp4 appendString:@")"];
                        }
                        [temp4 appendString:@"\r"];
                    }
                    
                  
                    /*
                    if([title isEqual:@"N:"] && !block){
                        
                        //NSLog(@"@BBBB");
                        if([temp5 length]>0){
                            block = true;
                        }
                    }
                    */
                 
                }
            }
            scan_data_clean_in = temp4;
            //SET ACTION1 - NAME
            if ([[temp3 allKeys] containsObject:@"N:"]) {
                
                action3 = [[NSString alloc] initWithString:[temp3 objectForKey:@"N:"]];
                [action3 retain];
            }else if ([[temp3 allKeys] containsObject:@"FN:"]) {
                action3 = [[NSString alloc] initWithString:[temp3 objectForKey:@"FN:"]];
                [action3 retain];
            }
            //SET ACTION2 - TEL
            if ([[temp3 allKeys] containsObject:@"TEL:"]) {
                action1 = [[NSString alloc] initWithString:[temp3 objectForKey:@"TEL:"]];
                //CLEAN PHONE NUMBER
                action1 = [self cleanPhone:action1];
                [action1 retain];
            }
            //SET ACTION3 - EMAIL
            if ([[temp3 allKeys] containsObject:@"EMAIL:"]) {
                action2 = [[NSString alloc] initWithString:[temp3 objectForKey:@"EMAIL:"]];
                [action2 retain];
            }
            
        break;
        //MECARD
        case 9:
            //SPECIAL ARRAYS
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"call_make", @"contact_copy", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"keypad.png", @"contact.png", @"upload.png", @"copy.png", @"info.png", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"BEGIN:VCARD" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"begin:vcard" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@";CHARSET=UTF-8" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@";CHARSET=utf-8" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@";charset=utf-8" withString:@""];
            
            titles = [[NSMutableArray alloc] initWithObjects: @"N:",@"ADR:",@"TEL:",@"EMAIL:", nil];
            //PARSE DATA
            temp3 = [self QRparser:titles:[scan_data_clean_in stringByAppendingString:@";"]:';'];
            temp4 = [[NSMutableString alloc] init];
            //FROM ARRAY PARSE DATA PREPARE scan_data_clean_in FINAL VIEW key value new line
            for(NSString *title in titles){
                
                if ([[temp3 allKeys] containsObject:title]) {
                    //CLEAN  GARBAGE BEFORE OUTPUT
                    NSString *temp5 = [[temp3 objectForKey:title] stringByReplacingOccurrencesOfString:@";" withString:@" "];
                    temp5 = [[temp3 objectForKey:title] stringByReplacingOccurrencesOfString:@"," withString:@" "];
                    temp5 = [temp5 stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    [temp4 appendString:temp5];
                    [temp4 appendString:@"\r"];
                }
            }
            scan_data_clean_in = temp4;
            //SET ACTION1 - NAME
            if ([[temp3 allKeys] containsObject:@"N:"]) {
                action3 = [[NSString alloc] initWithString:[temp3 objectForKey:@"N:"]];
                [action3 retain];
            }
            //SET ACTION2 - TEL
            if ([[temp3 allKeys] containsObject:@"TEL:"]) {
                action1 = [[NSString alloc] initWithString:[self CleanEmail:[temp3 objectForKey:@"TEL:"]]];
                //CLEAN PHONE NUMBER
                action1 = [self cleanPhone:action1];
                [action1 retain];
                
            }
            //SET ACTION3 - EMAIL
            if ([[temp3 allKeys] containsObject:@"EMAIL:"]) {
                action2 = [[NSString alloc] initWithString:[temp3 objectForKey:@"EMAIL:"]];
                [action2 retain];
            }
        break;
        //WIFI
        case 10:
            //SPECIAL ARRAYS
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"wifi1_copy", @"wifi2_copy", @"share", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects:  @"copy.png", @"copy.png", @"upload.png", @"info.png", nil];
            titles = [[NSMutableArray alloc] initWithObjects: @"T:", @"P:", @"S:", nil];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"wifi:" withString:@""];
            scan_data_clean_in=[scan_data_clean_in stringByReplacingOccurrencesOfString:@"WIFI:" withString:@""];
            //PARSE DATA
            temp3 = [self QRparser:titles :[scan_data_clean_in stringByAppendingString:@";"] :';'];
            temp4 = [[NSMutableString alloc] init];
            //FROM ARRAY PARSE DATA PREPARE scan_data_clean_in FINAL VIEW key value new line
            for (NSString* key in [temp3 allKeys]) {
                
                if([key isEqual:@"S:"]){[temp4 appendString:NSLocalizedString(@"wifi_name",nil)];[temp4 appendString:@": "];}
                if([key isEqual:@"P:"]){[temp4 appendString:NSLocalizedString(@"wifi_pass",nil)];[temp4 appendString:@": "];}
                [temp4 appendString:[temp3 objectForKey:key]];
                [temp4 appendString:@"\r"];
            }
            scan_data_clean_in = temp4;
            //SET ACTION1
            if ([[temp3 allKeys] containsObject:@"T:"]) {
        
                action1 = [temp3 objectForKey:@"T:"];
                [action1 retain];
            }
            //SET ACTION2
            if ([[temp3 allKeys] containsObject:@"S:"]) {
                action2 = [temp3 objectForKey:@"S:"];
                [action2 retain];
            }
            //SET ACTION3
            if ([[temp3 allKeys] containsObject:@"P:"]) {
                action3 = [temp3 objectForKey:@"P:"];
                [action3 retain];
            }
        break;
        default:
            actionsArr = [[NSMutableArray alloc] initWithObjects: @"email_send", @"share", @"text_copy", @"raw", nil];
            imagesArr = [[NSMutableArray alloc] initWithObjects: @"mail.png", @"search.png", @"copy.png", @"info.png", nil];
            
        break;
    }
    self.navigationItem.title = NSLocalizedString([data1Arr objectAtIndex: temp], nill);
    resultText1.text = scan_data_clean_in;
    scan_data_clean = scan_data_clean_in;
/*
    //RESULT TEXT FIELD AUTO RESIZE
    CGFloat fixedWidth = resultText1.frame.size.width;
    CGSize newSize = [resultText1 sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = resultText1.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    resultText1.frame = newFrame;
    resultText1.text = scan_data_clean_in;
    //[fixedWidth release];
*/
    
    label1.text = scan_data_clean_in;
    //RESULT TEXT FIELD AUTO RESIZE
    CGFloat fixedWidth = label1.frame.size.width;
    CGSize newSize = [label1 sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = label1.frame;
    newFrame.origin.x = 10;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    newFrame.size.width += 20;
    label1.frame = newFrame;
    
    label1.text = scan_data_clean_in;
    //SAVE CLEAN RESULT TO DB
    
    
    int N=0;
    //INITIALIZE DB
    NSManagedObjectContext *context = [self managedObjectContext];
    //CHECK IF USER ALLOWS REPEATED SCANS
    if([settings.history isEqual:@1]){
            
            //QUERY FOR MATCHING RECORDS
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"scan_data == %@", scan_data];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idl == %@", idl];
        
            [request setEntity:[NSEntityDescription entityForName:@"Scan_history" inManagedObjectContext:context]];
            [request setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *results = [context executeFetchRequest:request error:&error];
            N = (int)results.count;
            if(N>0){
                
                Scan_history *scan_history_up = [results objectAtIndex:0];
                scan_history_up.scan_data_clean = scan_data_clean;
                //scan_history.data1 = [NSNumber numberWithInt: [data1 integerValue]];
                //scan_history.time = [NSNumber numberWithInt:startTime];
                
                //NSLog(@"FOUND%d" , N);
                if (![context save:&error]) {
                    //NSLog(@"Error");
                }
            }
    }
    
    //ADMOB
    /*
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGRect frm = self.bannerView.frame;
    frm.size.width = screenWidth;
    //NSLog(@"data %f",screenWidth);
    self.bannerView.frame = frm;

    self.bannerView.adUnitID = @"ca-app-pub-000000000/000000000";
    self.bannerView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"your_test_device_id"];
    [self.bannerView loadRequest:request];
    */
}

- (void)viewWillAppear:(BOOL)animated{



}

- (NSMutableDictionary*) QRparser:(NSArray*)titles :(NSString*)scan_data_clean_in :(char)delim  {
    
    //NSArray *result;
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for(NSString *title in titles) {
        //delim = 10;
        NSRange range = [scan_data_clean_in rangeOfString:title];
        NSInteger start = range.location + range.length;
        
        for (NSUInteger i=start;i<[scan_data_clean_in length];i++)
        {
            //SEARCH TILL FIRST OCCURANCE OF SEPARATOR
            if (i>0 && [scan_data_clean_in characterAtIndex:i]==delim)
            {
                //JUST IN CASE SEPARATOR WAS ESCAPED | TRIGER BETWEEN SEPARETORS ';' 'r'
                if (((i>0 && [scan_data_clean_in characterAtIndex:(i-1)]!='\\') && delim==';') || ((i>0 && [scan_data_clean_in characterAtIndex:(i-1)]!=13) && delim==10))
                {
                    NSString *value = [scan_data_clean_in substringWithRange:NSMakeRange(start, (i-start))];
                    //NSLog(@"found: %d", i);NSLog(@"string: %@", value);
                    [result setObject:value forKey:title];
                    break;
                //IN CASE TWO END CHARACTERS TO BE REMOVED /r/n
                }else if(i>1 && delim==10 && ([scan_data_clean_in characterAtIndex:(i-1)]==13)){
                    
                    NSString *value = [scan_data_clean_in substringWithRange:NSMakeRange(start, (i-start-1))];
                    //NSLog(@"found: %d", i);NSLog(@"string: %@", value);
                    [result setObject:value forKey:title];
                    break;
                }
            }
           // NSLog(@"string: %c - %hu", [scan_data_clean_in characterAtIndex:i], [scan_data_clean_in characterAtIndex:i]);
        }
        
      }
      return result;
}

- (NSString*) cleanPhone:(NSString*)phone{
    
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    return phone;
}

- (NSString*) CleanEmail:(NSString*)email{
    
   // NSString *temp = email;
    email = [email stringByReplacingOccurrencesOfString:@"," withString:@""];
    email = [email stringByReplacingOccurrencesOfString:@"-" withString:@""];
    email = [email stringByReplacingOccurrencesOfString:@"(" withString:@""];
    email = [email stringByReplacingOccurrencesOfString:@")" withString:@""];
    email = [email stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return email;
}
- (void) dealloc
{
    [super dealloc];
    [data1Arr release];
    [imagesArr release];
    [actionsArr release];
    [data1 release];
    [scan_data release];
   // [scan_data_clean release];
    [scan_history release];
  //  [action1 release];
  //  [action2 release];
  //  [action3 release];
    
}
- (void)viewDidUnLoad
{
    //[self cleanup];
    actionsArr = nil;
    data1Arr = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDone:(id)sender {

    
}

-(void)email_send{
    
    
    
    NSString *subject = action2;
    NSString *body = action3;
    NSString *address = action1;
    NSString *cc = @"";
    NSString *path = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@", address, cc, subject, body];
    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}
/*
//IOS 6
- (void)email_send{
    

    MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]) {
        [composer setToRecipients:[NSArray arrayWithObjects:action1, nil]];
        [composer setSubject:action2];
        
        //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
        
        [composer setMessageBody:action3 isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
    }
    else {
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
//IOS 5
- (void)email_send_ios5{
    MFMailComposeViewController *composer=[[MFMailComposeViewController alloc]init];
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail]) {
        [composer setToRecipients:[NSArray arrayWithObjects:@"xyz@gmail.com", nil]];
        [composer setSubject:@""];
        
        //    [composer.setSubject.placeholder = [NSLocalizedString(@"This is a placeholder",)];
        
        [composer setMessageBody:@"" isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentModalViewController:composer animated:YES];
    }
    else {
    }
}
-(void)mailComposeController_ios5:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissModalViewControllerAnimated:YES];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [actionsArr count];
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
    
    // Configure the cell.
    UIImage *cellImage = [UIImage imageNamed:[imagesArr objectAtIndex:indexPath.row]];
    cell.imageView.image = cellImage;
    cell.textLabel.text = NSLocalizedString([actionsArr objectAtIndex:indexPath.row], nill);
    // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",info.data1];
    return cell;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        //return self.scan_data;
    }
    
    return @"";
}
//INITIALIZE PICKED UP ACTION
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    NSString *temp = [actionsArr objectAtIndex:indexPath.row];
    if([temp isEqualToString:@"link_open"]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scan_data]];
    }else if([temp isEqualToString:@"share"]){
     
        NSMutableArray *sharingItems = [NSMutableArray new];
        if (scan_data) {
            [sharingItems addObject:scan_data];
        }

        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
        [self presentViewController:activityController animated:YES completion:nil];
    }else if([temp isEqualToString:@"text_copy"]){
        
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:scan_data];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"text_copied", nill)
                                                             message:nil
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }else if([temp isEqualToString:@"raw"]){
        
        [self performSegueWithIdentifier:@"showRawOutput" sender:self];
    }else if([temp isEqualToString:@"email_send"]){
        
        [self email_send];
    }else if([temp isEqualToString:@"call_make"]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:action1]]];
    }else if([temp isEqualToString:@"geo_find"]){
      
        CGFloat sysVers = [UIDevice currentDevice].systemVersion.floatValue;
        NSString *hostName = (sysVers < 6.0) ? @"maps.google.com" : @"maps.apple.com";
    
        NSString *url = [NSString stringWithFormat: @"http://%@/maps?saddr=Current+Location&daddr=%@,%@",hostName,action1,action2];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        
    }else if([temp isEqualToString:@"google_search"]){
        
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:action1]];
    }else if([temp isEqualToString:@"google_product"]){
        
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:action2]];
    }else if([temp isEqualToString:@"wifi1_copy"]){
        
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:action2];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"text_copied", nill)
                                                             message:nil
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }else if([temp isEqualToString:@"wifi2_copy"]){
        
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:action3];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"text_copied", nill)
                                                             message:nil
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }else if([temp isEqualToString:@"sms_send"]){
        
        action3 =[@"sms:" stringByAppendingString:action1];
        //action3 =[action3 stringByAppendingString:@"?text="];
        //action3 =[action3 stringByAppendingString:action2];
        
        //NSLog(@"action %@", action3);
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: action3]];
    }else if([temp isEqualToString:@"contact_copy"]){
        

        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:action3];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"text_copied", nill)
                                                             message:nil
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
    }
    
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRawOutput"]) {
        
        RawOutput *detailVC = segue.destinationViewController;
        detailVC.scan_data = scan_data;
         
    }
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
