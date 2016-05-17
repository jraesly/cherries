//
//  More.h
//  QRcode
//
//  Created by Pavels Lukasenko on 11/16/13.
//
//

#import <UIKit/UIKit.h>

@interface More : UITableViewController
<UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

{
    UITableView *tableview;
    //UITextView *resultText;
    UILabel *about, *help, *rate, *privacy;
    
}
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UILabel *about, *help, *rate, *privacy;
//@property (nonatomic, retain) IBOutlet UITextView *resultText;


@end
