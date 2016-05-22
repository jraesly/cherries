//
//  TabBarController.m
//  QRcode
//
//  Created by John Raesly on 4/6/15.
//
//


#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //self.tabBarController.tabBar.barTintColor = [UIColor blackColor];
    //self.tabBarController.tabBar.translucent = false;
    //self.tabBarController.tabBar.tintColor = [UIColor blueColor];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor orangeColor]];
    //[[UITabBar appearance] setAlpha:0.25];
    
    
//    UIImage *t1 = [UIImage imageNamed:@"searchfo.png"];
//    UIImage *t1s = [UIImage imageNamed:@"sun.png"];

    /*

    [[[[self tabBar] items] objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"searchfo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"searchg.png"]];
    [[[[self tabBar] items] objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"clockfo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"clockg.png"]];
    [[[[self tabBar] items] objectAtIndex:2] setFinishedSelectedImage:[UIImage imageNamed:@"settingsfo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"settingsg.png"]];
    [[[[self tabBar] items] objectAtIndex:3] setFinishedSelectedImage:[UIImage imageNamed:@"morefo.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"moreg.png"]];
    
    //!!!!! COLOR OF TEXT ICON BAR
    [[self tabBar] setTintColor:[UIColor colorWithRed:231/255.0 green:122/255.0 blue:12/255.0 alpha:1.0]];
    //!!!!! CHANGES BACKGROUND OF TAB BAR AND
    //[[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];
    //!!!!! CHANGES COLOR OF INACTIVE TEXT
    //[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    
    [[[[self tabBar] items] objectAtIndex:0] setTitle:NSLocalizedString(@"scanner", nill)];
    [[[[self tabBar] items] objectAtIndex:1] setTitle:NSLocalizedString(@"history", nill)];
    [[[[self tabBar] items] objectAtIndex:2] setTitle:NSLocalizedString(@"settings", nill)];
    [[[[self tabBar] items] objectAtIndex:3] setTitle:NSLocalizedString(@"more", nill)];
    
    
    //[[[[self tabBar] items] objectAtIndex:1] setFinishedSelectedImage:t1 withFinishedUnselectedImage:t1s];

    
    */
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController

{
 
}
@end
