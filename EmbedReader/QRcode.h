//
//  QRcode.h
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface QRcode : UIViewController<MFMailComposeViewControllerDelegate>{
    
    //NSString *qrData;
}


@property (nonatomic, retain) NSString *qrData;
@property (nonatomic, retain) UIColor *qrColor;


- (IBAction) buttonClick:  (UIButton *)sender;

//- (IBAction) buttonClick:(id)sender;
//- (void)buttonClick:(id)sender;


@end
