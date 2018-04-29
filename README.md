# WKCKit
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/WKCKit.svg?style=flat)](https://cocoapods.org/pods/WKCKit) [![License: MIT](https://img.shields.io/cocoapods/l/WKCKit.svg?style=flat)](http://opensource.org/licenses/MIT)

Some base on Kit

## Such as

 import into  `#import <WKCKit/WKCKit.h>`
 
 ### WKCUIUtil
 1. 属性和方法
 ```
 @property (nonatomic, strong, readonly) WKCUIUtil * sharedInstance;
 @property (nonatomic, assign, readonly) BOOL isPhone4Or5;
 @property (nonatomic, assign, readonly) BOOL isPhone6;
 @property (nonatomic, assign, readonly) BOOL isPhone6p;
 @property (nonatomic, assign, readonly) BOOL isPhoneX;
 @property (nonatomic, assign, readonly) BOOL isiPad;
 @property (nonatomic, assign, readonly) CGFloat iphoneXTopSpace;
 @property (nonatomic, assign, readonly) CGFloat iphoneXBottomSpace;
 @property (nonatomic, assign, readonly) CGFloat heightOfNavigationBar;
 @property (nonatomic, assign, readonly) CGFloat heightOfStatusBar;
 @property (nonatomic, assign, readonly) CGFloat heightOfNavigation;
 @property (nonatomic, assign, readonly) CGFloat heightOfTabBar;
 
 + (instancetype)sharedInstance;
 ```
 
```
 BOOL isIphoneX = WKCUIUtil.sharedInstance.isPhoneX;
 CGFloat heightOfNavigation = WKCUIUtil.sharedInstance.heightOfNavigation;
```
### UIButton+extension
1. 扩大按钮的点击区域
 ```
 self.button.LargeLength = 5;
```
2. 定时按钮,如需取消闪烁效果，设置buttonType为custom
```
 [self.button setTimeout:5 title:@"点击进入" waitTittle:@"s"];
 ```
 ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/1.gif)
 
 ### UITextView+ZWPlaceHolder
 1.  给textViewplaceHolder设置,字体默认与文字相同
 ```
 textView.zw_placeHolder = @"你说呢";
 textView.zw_placeHolderColor = [UIColor blueColor];
```
2.  动态高度
```
 CGFloat height =  [textView heightWithText:@"你说呢" font:12];
```
### UIImage+extension
1. 图片宽高.
```
@property (nonatomic, assign, readonly) CGFloat wkc_width;
@property (nonatomic, assign, readonly) CGFloat wkc_height;
```
2. 通过颜色画一张图.
```
 UIImage *blueImage = [UIImage imageWithColor:[UIColor blueColor]];
```
3. 画一张渐变色的图片.
0xefefefff - 后两位代表透明度. pointX代表横向,pointY代表纵向.
```
  UIImage *gradientImage =  [UIImage imageWithGradientColors:@[@(0xefefefff),@(0x000000ff)] startPoint:CGPointZero endPoint:CGPointMake(1, 0) corners:UIRectCornerAllCorners cornerRadius:8 size:CGSizeMake(60, 60)];
```
### UIView+extension
1. 快速读取和设置UI值.
```
/**原点*/
@property (nonatomic, assign) CGPoint wkc_origin;
/**size*/
@property (nonatomic, assign) CGSize wkc_size;
/**中心x*/
@property (nonatomic, assign) CGFloat wkc_centerX;
/**中心y*/
@property (nonatomic, assign) CGFloat wkc_centerY;
/**原点x*/
@property (nonatomic, assign) CGFloat wkc_originX;
/**原点Y*/
@property (nonatomic, assign) CGFloat wkc_originY;
/**最大X*/
@property (nonatomic, assign, readonly) CGFloat wkc_maxX;
/**最大Y*/
@property (nonatomic, assign, readonly) CGFloat wkc_maxY;
/**宽*/
@property (nonatomic, assign) CGFloat wkc_width;
/**高*/
@property (nonatomic, assign) CGFloat wkc_height;

/**设置frame*/
- (void)setWkc_frame:(NSArray <NSNumber *>*)frame;
/**设置bounds*/
- (void)setWkc_bounds:(NSArray <NSNumber *>*)bounds;
```
 
 2. 键盘观察
 添加键盘观察 添加者self.view会随键盘移动
 ```
 [self.view addKeyBoardObsverWithCompeletionHnadle:^(CGFloat keyboredDismissTime) {
 
 }];
 ```
  ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/2.gif)

3. 视图标识.
```
 [UITableViewCell cellReuseIdentifier];
```
4. 视图所属控制器
```
 UIViewController *controller = self.view.viewController;
```
5. 阴影和圆角
 同时添加阴影和圆角
 ```
 [self.imageView shadowWithCornerRadius:8 shadowColor:[UIColor blueColor] shadowOffSet:CGSizeMake(0, 12) shadowOpacity:0.2 shadowBlur:24];
 ```
   ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/3.png)
   
 6. 视图拖动
 可在屏幕内拖动.
 ```
  button.isCanPan = YES;;
 ```
![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/4.gif)
    
 7. 截屏
 ```
 UIImage *screenShort = [self.imageView screenshot];
 ```
8. 渐变色
 添加渐变色 colors数组 start开始位置 end结束位置,x代表横向,y代表纵向 location代表开始改变的位置
 ```
 [self.imageView gradientWithColors:@[[UIColor blackColor],[UIColor whiteColor]] startPoint:CGPointZero endPoint:CGPointMake(1, 0) changeLocation:0.4];
 ```
  ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/6.png)

### UINavigationItem+extension
自定义导航栏按钮间距
  ```
  self.navigationItem.leftMargin = 8;
  self.navigationItem.rightMargin = 9;
  ```
  ### UINavigationController+Transition
1. 自定义转场动画  翻页、屏幕内翻转
```
PushViewController *push = [PushViewController new];
[self.navigationController wkc_pushViewController:push withTransition:UIViewAnimationTransitionFlipFromRight];
```
2. 返回到指定控制器
```
[self.navigationController popToDesignationController:[PushViewController class] animated:YES compeletionHandle:^(UIViewController *DesignatedViewController) {

}];
```

### WKCBottomHUD
底部弹框
```
[[WKCBottomHUD sharedInstance] showWithText:@"你点击的是底部弹框" duration:2.0f];
```
  ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/7.gif)
    
  
 
