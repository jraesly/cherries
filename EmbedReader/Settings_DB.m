//
//  Settings_DB.m
//  QRcode
//
//  Created by Pavels Lukasenko on 11/18/13.
//
//

#import "Settings_DB.h"

@implementation Settings_DB

@synthesize sid, link, beep, vibrate, history, backlight, torch, bulk, t1, t2, t3, t4, t5, t6, t7, t8, t9;

//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static Settings_DB *instance =nil;
+ (void) initialize {
    
}

+(Settings_DB *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [Settings_DB new];
        }
    }
    return instance;
}


@end