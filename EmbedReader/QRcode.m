//
//  QRcode.m
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import "QRcode.h"
#import "UIImage+MDQRCode.h"


@interface QRcode ()

@end

@implementation QRcode

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
    self.navigationItem.title = NSLocalizedString(@"preview", nill);
    if ([MFMailComposeViewController canSendMail]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareCode)];
        
    }
   
    if([_qrData length]==0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"attention", @"Attention")
                                                        message:NSLocalizedString(@"nodata", @"No data")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel")
                                              otherButtonTitles:nil, nil];
        //alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
    _qrColor = [UIColor darkGrayColor];
    [self drawCode];
    
    // [[self tabBar] setTintColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:12/255.0 alpha:1.0]];
    //l1.text = NSLocalizedString(@"helps1", nill);
    //NSLog(@"DATA%@",_qrData);
    // Do any additional setup after loading the view.
}

- (void)shareCode{
    
    
    MFMailComposeViewController *mcv = [[MFMailComposeViewController alloc] init];
    mcv.mailComposeDelegate = self;
    
    [mcv setSubject:@"QR-code"];
    [mcv setToRecipients:[NSArray arrayWithObject:@""]];
    UIImageView *qr = (UIImageView *)[self.view viewWithTag:1000];
    NSData* dtemp = UIImagePNGRepresentation(qr.image);
    
    [mcv setMessageBody:NSLocalizedString(@"raloco_qr_scan", nill) isHTML:NO];
    [mcv addAttachmentData:dtemp mimeType:@"image/jpeg" fileName:@"QRcode.jpg"];
    
    [self presentViewController:mcv animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

#pragma mark - MFMailComposeViewControllerDelegate
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)drawCode{
    
    UIImageView *qr = (UIImageView *)[self.view viewWithTag:1000];
    UIViewController *viewController = [[UIViewController alloc] init];
	CGFloat imageSize = ceilf(viewController.view.bounds.size.width * 0.6f);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf(viewController.view.bounds.size.width * 0.5f - imageSize * 0.5f), floorf(viewController.view.bounds.size.height * 0.5f - imageSize * 0.5f), imageSize, imageSize)];
	[viewController.view addSubview:imageView];
	qr.image = [UIImage mdQRCodeForString:_qrData size:imageView.bounds.size.width fillColor:_qrColor];
}

- (IBAction)buttonClick:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    _qrColor = btn.backgroundColor;
    [self drawCode];
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
