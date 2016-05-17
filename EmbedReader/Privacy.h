//
//  Privacy.h
//  QRcode
//
//  Created by Pavels Lukasenko on 11/17/13.
//
//

#import <UIKit/UIKit.h>

@interface Privacy : UITableViewController
<UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

{
    UITableView *tableview;
    //UITextView *resultText;
    UILabel *a1, *a2, *a3, *a4, *a5, *a6;
    
}
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UILabel *a1, *a2, *a3, *a4, *a5, *a6;
//@property (nonatomic, retain) IBOutlet UITextView *resultText;

@end
