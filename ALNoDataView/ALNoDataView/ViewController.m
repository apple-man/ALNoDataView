//
//  ViewController.m
//  ALNoDataView
//
//  Created by Alan on 2018/1/11.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ViewController.h"
#import "ALNoDataView.h"
#import "ALActionVC.h"

#define ALScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ALScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<ALNoDataViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *requestBtn;
@property (nonatomic, strong) ALNoDataView *noDataView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

-(void)setupUI{
    self.requestBtn.layer.borderWidth = 1;
    self.requestBtn.layer.borderColor = [UIColor purpleColor].CGColor;
    self.requestBtn.backgroundColor = [UIColor whiteColor];
    self.requestBtn.layer.cornerRadius = 5;
    self.requestBtn.layer.masksToBounds = YES;
    self.requestBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
}

- (IBAction)requestBtnAction:(UIButton *)sender {
    
    /**
     arc4random() 这个函数产生随机数，
     因为定义的枚举enum，有0到5总共六种情况，所以要对 6 取余，但是我的ALNoDataView的noDataType的set方法只重写了 0 1 2，所以对 3 取余。
     */
     // 这里可以模拟 多种网络情况
    //int noDataType = arc4random() % 6;
     int noDataType = arc4random() % 3;
    self.noDataView.hidden = NO;
    self.noDataView.noDataType = noDataType;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.noDataView.frame = CGRectMake(0, 0, ALScreenWidth, ALScreenHeight);
}

#pragma mark - <ALNoDataViewDelegate>
- (void)noDataViewReloadAction{
    /**
     控制器VC没有所谓的frame的设置，设置的也是VC的view。
     UIView显示有两点，大小和位置，还有事件处理
     */
    ALActionVC *VC = [ALActionVC new];
    // 为什么不设置view的frame，这是因为frame是子控件相对于父控件的位置设置，bound设置父控件基于自己，实际就是size的设置，origin原点基于自己，是（0,0）
    VC.view.bounds = self.view.bounds;
    [self presentViewController:VC animated:YES completion:nil];
}


#pragma mark - getter
- (ALNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [ALNoDataView noDataView];
        _noDataView.delegate = self;
        _noDataView.hidden = YES;
        
         // 此处也可以不初始化请求响应文案，根据网络返回类型，直接设置noDataType
//        _noDataView.imageName = @"errorImage1";
//        _noDataView.message = @"请求失败...";
//        _noDataView.reloadMessage = @"刷新一下";
        
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
