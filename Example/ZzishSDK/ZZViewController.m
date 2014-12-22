//
//  ZZViewController.m
//  ZzishSDK
//
//  Created by Samir Seetal on 11/27/2014.
//  Copyright (c) 2014 Samir Seetal. All rights reserved.
//

#import "ZZViewController.h"


@interface ZZViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userId;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *groupCode;
@property (weak, nonatomic) IBOutlet UITextField *activityName;
@property (weak, nonatomic) IBOutlet UITextField *actionName;
@property (strong, nonatomic) IBOutlet UIView *score;
@property (weak, nonatomic) IBOutlet UITextField *duration;
@property (weak, nonatomic) IBOutlet UITextField *attempts;
@property (weak, nonatomic) IBOutlet UITextField *correct;
@property (weak, nonatomic) IBOutlet UITextField *scoreText;
@property (weak, nonatomic) IBOutlet UILabel *responseStatus;
@property (weak, nonatomic) IBOutlet UILabel *responseMessage;
@property (weak, nonatomic) IBOutlet UITextField *response;
@property (weak, nonatomic) IBOutlet UITextField *activityKey;
@property (weak, nonatomic) IBOutlet UITextField *activityValue;
@property (weak, nonatomic) IBOutlet UIButton *saveActivityState;

@property (weak, nonatomic) IBOutlet UITextField *actionKey;
@property (weak, nonatomic) IBOutlet UITextField *actionValue;
@property (weak, nonatomic) IBOutlet UIButton *saveActionState;

@property (strong,nonatomic) ZZUser* user;
@property (strong,nonatomic) ZZActivity* activity;
@property (strong,nonatomic) ZZAction* action;

@end

@implementation ZZViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Zzish startWithApplicationId:@"868b8768-c031-434c-b4f6-69e8f39dd5bf"];
    [Zzish delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createUser:(id)sender {
    self.user = [Zzish user:self.userId.text];
    self.user.name = self.name.text;
    self.user.groupCode = self.groupCode.text;
    NSLog(@"Created user");
}

- (IBAction)createActivity:(id)sender {
    self.activity = [self.user createActivity:self.activityName.text];
    [self.activity start];
    NSLog(@"Started Activity");
}

- (IBAction)createAction:(id)sender {
    self.action = [self.activity createAction:
                   self.actionName.text];
    NSLog(@"Created action");
}
-
(IBAction)saveAction:(id)sender {
    if (self.scoreText.text) {
        [self.action score:[self.scoreText.text floatValue]];
    }
    if (self.duration.text) {
        [self.action duration:[self.duration.text longLongValue]];
    }
    if (self.attempts.text) {
        [self.action attempts:[self.attempts.text intValue]];
    }
    if (self.correct.text) {
        [self.action correct:[self.correct.text boolValue]];
    }
    self.action.response = self.response.text;
    [self.action save];
}

- (IBAction)stopActivity:(id)sender {
    //saves the attributes
    [self.activity stop];
}

- (IBAction)cancelActivity:(id)sender {
    [self.activity cancel];
}

- (void)processZzishResponse:(int)status andMessage:(NSString *)message {
    self.responseStatus.text = [NSString stringWithFormat:@"%d",status];
    self.responseMessage.text = message;
}

- (IBAction)saveActivityState:(id)sender {
    [self.activity setValue:self.activityValue.text forKey:self.activityKey.text];
}

- (IBAction)saveActionState:(id)sender {
    [self.action setValue:self.actionValue.text forKey:self.actionKey.text];
}



@end
