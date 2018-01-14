//
//  ALNoDataView.m
//  ALNoDataView
//
//  Created by Alan on 2018/1/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "ALNoDataView.h"

@interface ALNoDataView()
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@end

@implementation ALNoDataView

+(instancetype)noDataView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[self class] noDataView];
        [self setupUI];
    }
    return self;
}

/** 如果contentView设置了alpha，就会无法响应事件，所以要重写这个touchBegan方法 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    // 这里可以模拟 多种网络情况
    int noDataType = arc4random() % 3;
    self.noDataType = noDataType;
}

- (void)setupUI {
    /** enabled = NO; 设置交互，发现照片有点透明灰色，改成userInteractionEnabled = NO;就好了 */
    //self.imageBtn.enabled = NO;
    self.imageBtn.userInteractionEnabled = NO;
    self.imageBtn.contentMode = UIViewContentModeScaleAspectFill;
    /**
     UIButtonType是readonly，所有创建的时候设置，或者在SB和xib中设置Type，默认是system，设置成custom，system模式下设置UIButtonType的image不起作用。
     用代码创建UIButtond的[[UIButton alloc] init];和[UIButton buttonWithType:UIButtonTypeCustom];创建的都是custom类型的。
     buttonType是readonly 只读
     self.imageBtn.buttonType = UIButtonTypeCustom;
     self.reloadBtn.buttonType = UIButtonTypeCustom;
     */
    self.reloadBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.reloadBtn.layer.borderWidth = 1;
    self.reloadBtn.layer.cornerRadius = 4;
    self.reloadBtn.layer.masksToBounds = YES;
    /**
        如果不设置requestBtn的width和height,默认边框贴着文字的，可以通过设置内边距达到边框和文字分离
        self.requestBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        如果在SB和xib中设置的width和height大于文字的内容的width和height。设置的边框也会和文字有距离。
     */
    
    self.reloadBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    
}

-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    [self.imageBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.imageBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

- (void)setMessage:(NSString *)message{
    _message = message;
    self.messageLabel.text = message;
}

- (void)setReloadMessage:(NSString *)reloadMessage{
    _reloadMessage = reloadMessage;
    [self.reloadBtn setTitle:reloadMessage forState:UIControlStateNormal];
    [self.reloadBtn setTitle:reloadMessage forState:UIControlStateHighlighted];
}

- (void)setNoDataType:(NoDataType)noDataType{
    _noDataType = noDataType;
    if (noDataType == kNoDataTypeNoData) {
        [self setNoDataTypeNoData];
    }else if(noDataType == kNoDataTypeNetworkError){
        [self setNoDataTypeNetworkError];
    }else if(noDataType == kNoDataTypeNetworkTimeOut){
        [self setNoDataTypeNetworkTimeOut];
    }
}

/** 没有数据 */
- (void)setNoDataTypeNoData{
    [self.imageBtn setImage:[UIImage imageNamed:@"errorImage1"] forState:UIControlStateNormal];
    [self.imageBtn setImage:[UIImage imageNamed:@"errorImage1"] forState:UIControlStateHighlighted];
    self.messageLabel.text = @"没有数据";
    self.reloadBtn.hidden = YES;
}

/** 网络未连接 */
- (void)setNoDataTypeNetworkError{
    [self.imageBtn setImage:[UIImage imageNamed:@"errorImage1"] forState:UIControlStateNormal];
    [self.imageBtn setImage:[UIImage imageNamed:@"errorImage1"] forState:UIControlStateHighlighted];
    self.messageLabel.text = @"请检查网络";
    [self.reloadBtn setTitle:@"设置网络" forState:UIControlStateNormal];
    [self.reloadBtn setTitle:@"设置网络" forState:UIControlStateHighlighted];
    self.reloadBtn.hidden = NO;
}

/** 请求超时 */
- (void)setNoDataTypeNetworkTimeOut{
    [self.imageBtn setImage:[UIImage imageNamed:@"errorImage2"] forState:UIControlStateNormal];
    [self.imageBtn setImage:[UIImage imageNamed:@"errorImage2"] forState:UIControlStateHighlighted];
    self.messageLabel.text = @"请求超时";
    [self.reloadBtn setTitle:@"刷新一下" forState:UIControlStateNormal];
    [self.reloadBtn setTitle:@"刷新一下" forState:UIControlStateHighlighted];
    self.reloadBtn.hidden = NO;
}


- (IBAction)reloadBtnAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(noDataViewReloadAction)]) {
        [self.delegate noDataViewReloadAction];
    }
}


@end
