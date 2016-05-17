//
//  RawOutput.m
//  QRcode
//
//  Created by Pavels Lukasenko on 11/18/13.
//
//

#import "RawOutput.h"

@interface RawOutput ()

@end

@implementation RawOutput
@synthesize data1, scan_data;
@synthesize resultText1;
@synthesize resultText2;
@synthesize resultLabel;

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
    self.navigationItem.title = NSLocalizedString(@"raw", nill);
    resultText1.text = scan_data;
    resultLabel.text = NSLocalizedString(@"raw_output", nill);
    //[resultText1 release];
    //[resultLabel release];
    //[scan_data release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [data1 release];
    [resultText1 release];
    [resultText2 release];
    [resultLabel release];
    [scan_data release];
    [super dealloc];
}

@end
