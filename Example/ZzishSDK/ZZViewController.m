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

@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UILabel *outputCode;

@property (strong,nonatomic) ZZUser* user;
@property (strong,nonatomic) ZZActivity* activity;
@property (strong,nonatomic) ZZAction* action;

@end

@implementation ZZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ZZService initWithApplicationId:@"12346"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createUser:(id)sender {
    self.user = [ZZService user:self.input.text];
}
- (IBAction)createActivity:(id)sender {
    self.activity = [self.user createActivity:self.input.text];
    [self.activity start];
}

- (IBAction)createAction:(id)sender {
    self.action = [self.activity createAction:
                   self.input.text];
    [self.action score:100];
    [self.action save];
}

- (IBAction)createGroupUser:(id)sender {
    self.user = [ZZService user:[[NSUUID UUID] UUIDString]];
    self.user.groupCode = self.input.text;
}

- (IBAction)stopActivity:(id)sender {
    [self.activity stop];
}

- (IBAction)cancelActivity:(id)sender {
    [self.activity cancel];
}




@end
