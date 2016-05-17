//
//  Scan_history.h
//  QRcode
//
//  Created by Pavels Lukasenko on 11/12/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Scan_history : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * idl;
@property (nonatomic, retain) NSString * scan_data;
@property (nonatomic, retain) NSString * scan_data_clean;
@property (nonatomic, retain) NSNumber * data1;
@property (nonatomic, retain) NSString * data2;
@property (nonatomic, retain) NSNumber * time;

@end
