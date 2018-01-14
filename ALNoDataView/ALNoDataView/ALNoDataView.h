//
//  ALNoDataView.h
//  ALNoDataView
//
//  Created by Alan on 2018/1/12.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NoDataType){
    kNoDataTypeNoData = 0, // 没有数据
    kNoDataTypeNetworkError, // 网络未连接
    kNoDataTypeNetworkTimeOut, // 请求超时
    kNoDataTypeServerError, // 服务器故障
    kNoDataTypeUnSignIn, // 用户未登录
    KNoDataTypeSignOut // 用户注销
};


@protocol ALNoDataViewDelegate<NSObject>
/** 重载action */
- (void)noDataViewReloadAction;
@end

@interface ALNoDataView : UIView
/** 提示icon */
@property (nonatomic, copy) NSString * imageName;
/** 提示文案 */
@property (nonatomic, copy) NSString * message;
/** 重载文案 */
@property (nonatomic, copy) NSString * reloadMessage;
/** id<ALNoDataViewDelegate> */
@property (nonatomic, strong) id<ALNoDataViewDelegate> delegate;

@property (nonatomic, assign) NoDataType noDataType;

/** 实例化方法 */
+(instancetype)noDataView;

@end
