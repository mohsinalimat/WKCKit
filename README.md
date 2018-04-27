# WKCKit
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/WKCKit.svg?style=flat)](https://cocoapods.org/pods/WKCKit) [![License: MIT](https://img.shields.io/cocoapods/l/WKCKit.svg?style=flat)](http://opensource.org/licenses/MIT)

Some base on Kit

## Such as

 import into  `#import <WKCKit/WKCKit.h>`
 
 1. 屏幕尺寸相关
 ```
 /**是不是4或者5或者SE屏幕*/
 BOOL isIphone4Or5 = [WKCUIUtil isPhone4Or5];
 
 /**ipnoneX底部多出的空位*/
 CGFloat iphoneXBottomSpace = [WKCUIUtil iphoneXBottomSpace];
 
 /**navigation高度*/
 CGFloat heightOfNavigation = [WKCUIUtil heightOfNavigation];
 ```
 2. 按钮
 ```
 /**扩大按钮的点击区域*/
 self.button.LargeLength = 5;
 
 /**定时按钮,如需取消闪烁效果，设置buttonType为custom*/
 [self.button setTimeout:5 title:@"点击进入" waitTittle:@"s"];
 ```
 ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/1.gif)
 
 3. textView
 ```
 /**给textViewplaceHolder设置,字体默认与文字相同*/
 textView.zw_placeHolder = @"你说呢";
 textView.zw_placeHolderColor = [UIColor blueColor];
 
 /**动态高度*/
 CGFloat height =  [textView heightWithText:@"你说呢" font:12];
 ```
 
 4. 键盘观察
 ```
 /**添加键盘观察 添加者self.view会随键盘移动*/
 [self.view addKeyBoardObsverWithCompeletionHnadle:^(CGFloat keyboredDismissTime) {
 
 }];
 ```
  ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/2.gif)
  
 5. frame
 ```
 /**frame相关*/
 CGFloat maxX = self.view.wkc_maxX;
 CGFloat maxY = self.view.wkc_maxY;
 ```
 6. 阴影和圆角
 ```
 /**同时添加阴影和圆角*/
 [self.imageView shadowWithCornerRadius:8 shadowColor:[UIColor blueColor] shadowOffSet:CGSizeMake(0, 12) shadowOpacity:0.2 shadowBlur:24];
 ```
   ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/3.png)
   
 7. 视图拖动
 ```
 /**可在屏幕内拖动*/
 [self.imageView addPanAnimation];
 ```
![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/4.gif)
    
 8. 截屏
 ```
 /**根据视图进行截屏*/
 UIImage *screenShort = [self.imageView screenshot];
 ```
 9. 渐变色
 
 ```
 /**添加渐变色 colors数组 start开始位置 end结束位置,x代表横向,y代表纵向 location代表开始改变的位置*/
 [self.imageView gradientWithColors:@[[UIColor blackColor],[UIColor whiteColor]] startPoint:CGPointZero endPoint:CGPointMake(1, 0) changeLocation:0.4];
 ```
  ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/6.png)
  
  10.  UIImage
  ```
  /**根据颜色生成一张图片*/
  UIImage *colorImage = [UIImage imageWithColor:[UIColor blueColor]];
  self.imageView.image = colorImage;
  ```
  ![Alt text](https://github.com/WeiKunChao/WKCKit/raw/master/screenShort/5.png)
  
  11. 导航栏间距
  ```
  /**导航栏间距*/
  self.navigationItem.leftMargin = 8;
  self.navigationItem.rightMargin = 9;
  ```
12. NavigationController
```
/**自定义转场动画  翻页、屏幕内翻转等*/
PushViewController *push = [PushViewController new];
[self.navigationController wkc_pushViewController:push withTransition:UIViewAnimationTransitionFlipFromRight];

/**返回到指定控制器*/
[self.navigationController popToDesignationController:[PushViewController class] animated:YES compeletionHandle:^(UIViewController *DesignatedViewController) {

}];
```
  
 
