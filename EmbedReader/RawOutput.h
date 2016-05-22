//
//  RawOutput.h
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import <UIKit/UIKit.h>

@interface RawOutput : UITableViewController
<UITextFieldDelegate, UITableViewDelegate> {
 
    NSNumber *data1;
    NSString *scan_data;
    UITextView *resultText1;
    UITextView *resultText2;
    UILabel *resultLabel;
}
@property (nonatomic, copy) NSNumber *data1;
@property (nonatomic, copy) NSString *scan_data;
@property (nonatomic, retain) IBOutlet UITextView *resultText1, *resultText2;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;

@end
