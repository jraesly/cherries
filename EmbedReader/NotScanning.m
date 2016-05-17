//
//  NotScanning.m
//  QRcode
//
//  Created by Pavels Lukasenko on 26/06/14.
//
//

#import "NotScanning.h"

@interface NotScanning ()

@end

@implementation NotScanning

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
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"help", nill);
    
    UILabel *l1 = (UILabel *)[self.view viewWithTag:101];
    l1.text = NSLocalizedString(@"helps1", nill);
    l1 = (UILabel *)[self.view viewWithTag:103];
    l1.text = NSLocalizedString(@"helps3", nill);
    l1 = (UILabel *)[self.view viewWithTag:105];
    l1.text = NSLocalizedString(@"helps5", nill);
    l1 = (UILabel *)[self.view viewWithTag:107];
    l1.text = NSLocalizedString(@"helps7", nill);
    UITextView *t1 = (UITextView *)[self.view viewWithTag:102];
    t1.text = NSLocalizedString(@"helps2", nill);
    t1 = (UITextView *)[self.view viewWithTag:104];
    t1.text = NSLocalizedString(@"helps4", nill);
    t1 = (UITextView *)[self.view viewWithTag:106];
    t1.text = NSLocalizedString(@"helps6", nill);
    t1 = (UITextView *)[self.view viewWithTag:108];
    t1.text = NSLocalizedString(@"helps8", nill);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
