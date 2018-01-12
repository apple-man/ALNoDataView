//
//  ALActionVC.m
//  ALNoDataView
//
//  Created by Alan on 2018/1/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ALActionVC.h"

@interface ALActionVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBtnAction;

@end

@implementation ALActionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)backBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
