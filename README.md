# ALNoDataView
No data tip view in OC language

Hello there! I'm **ALNoDataView**,the easy no data tipview in OC;

## 用法

把ALNoDataView的.h和.m拖到你的项目中，就能使用。

## 原理

初始化方法有两种：

* +(instancetype)noDataView;
	* 这是提供的API，你可以用这个方法初始化控件。
* [ALNoDataView new]; 
	* 也可以像使用原生控件那样，这样初始化。

点击事件处理

* 遵守协议ALNoDataViewDelegate,实现代理方法

	* - (void)noDataViewReloadAction;

* 成为代理

	* @property (nonatomic, strong) id<ALNoDataViewDelegate> delegate;

	
