//
//  Settings_DB.h
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


//#import <Foundation/Foundation.h>
//#import <CoreData/CoreData.h>

@interface Settings_DB : NSObject

@property (nonatomic, retain) NSNumber * sid;
@property (nonatomic, retain) NSNumber * link;
@property (nonatomic, retain) NSNumber * vibrate;
@property (nonatomic, retain) NSNumber * beep;
@property (nonatomic, retain) NSNumber * history;
@property (nonatomic, retain) NSNumber * backlight;
@property (nonatomic, retain) NSNumber * bulk;
@property (nonatomic, retain) NSNumber * torch;


@property (nonatomic, retain) NSNumber * t1;
@property (nonatomic, retain) NSNumber * t2;
@property (nonatomic, retain) NSNumber * t3;
@property (nonatomic, retain) NSNumber * t4;
@property (nonatomic, retain) NSNumber * t5;
@property (nonatomic, retain) NSNumber * t6;
@property (nonatomic, retain) NSNumber * t7;
@property (nonatomic, retain) NSNumber * t8;
@property (nonatomic, retain) NSNumber * t9;


+(Settings_DB*)getInstance;

@end