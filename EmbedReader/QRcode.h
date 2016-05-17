//
//  QRcode.h
//  QRcode
//
//  Created by Pavels Lukasenko on 26/06/14.
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
