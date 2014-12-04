//
//  ZZViewController.m
//  ZzishSDK
//
//  Created by Samir Seetal on 11/27/2014.
//  Copyright (c) 2014 Samir Seetal. All rights reserved.
//

#import "ZZViewController.h"
#import <ZzishSDK/ZzishSDK.h>

@interface ZZViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label4;

@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Are you connected %d",[ZZService connected]);
    ZZUser* user = [ZZUser instance];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender {
    self.label4.text = @"Hello";
}

@end
