![GLNavigationArchitectureSet](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/GLNavigationArchitectureSet.png)

![](https://img.shields.io/badge/platform-iOS%207.0%2B-brightgreen.svg)
![](https://img.shields.io/badge/build-passing-brightgreen.svg)
![](https://img.shields.io/badge/pod-v0.7-orange.svg)
![](https://img.shields.io/badge/coverage-70%25-yellow.svg)


# GLNavigationArchitectureSet
使用本库能快速搭建常见App UI架构，包括GLTabBarController， GLNavigationController，GLPageViewController，GLSideViewController。可以灵活组合使用。

## 效果展示
### GLTabBarController

系统ButtonItem样式＋定制按钮| 扁平动效ButtonItem样式 ＋ 定制按钮
---|---
![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/tabbar1.gif) |![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/tabbar2.gif)

### GLNavigationController

系统手势全屏返回 | 截图手势全屏返回
---|---
![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/nav1.gif) |![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/nav2.gif)

navbar alpha变换 | navbar 位移变换
---|---
![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/navbar1.gif) |![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/navbar2.gif)

### GLPageViewController

指示标变化样式 | 字体变换样式
---|---
![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/page1.gif) |![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/page2.gif)

### GLSideViewController

仿射变换样式 | 扁平样式
---|---
![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/side1.gif) |![loading](https://raw.githubusercontent.com/GarfieldLover/GLNavigationArchitectureSet/master/DemoGif/side2.gif)

## 如何使用
### GLTabBarController
#### 1.系统ButtonItem样式＋定制按钮

创建GLTabBarController
```
- (GLTabBarController*)tabBarController
{
    GLSpecialButtonSubclass* specialButton = [[GLSpecialButtonSubclass alloc] init];

    GLTabBarController* tabBarController=[GLTabBarController tabBarControllerWithViewControllers:[self setupViewControllers] tabBarItemsAttributes:[self customizeTabBarForControll] SpecialButtonWith:specialButton];

    return tabBarController;
}
```

GLTabBarController传入的tabBarItemsAttributes和ViewControllers
```
- (NSArray*)setupViewControllers
{
    UINavigationController *homeNavigationController = [[GLNavigationController alloc]
                                                   initWithRootViewController:pageViewController];
    
    GLMessageViewController *messageViewController = [[GLMessageViewController alloc] init];
    UINavigationController *messageNavigationController = [[GLNavigationController alloc]
                                                    initWithRootViewController:messageViewController];
    
    GLDiscoveryViewController *discoveryViewController = [[GLDiscoveryViewController alloc] init];
    UINavigationController *discoveryNavigationController = [[GLNavigationController alloc]
                                                   initWithRootViewController:discoveryViewController];
    
    GLPersonViewController *personViewController = [[GLPersonViewController alloc] init];
    UINavigationController *personNavigationController = [[GLNavigationController alloc]
                                                    initWithRootViewController:personViewController];
    
    NSArray* array=@[homeNavigationController,messageNavigationController,discoveryNavigationController, personNavigationController];
    return array;
}


- (NSArray*)customizeTabBarForControll {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:144.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:241.0/255.0 green:124.0/255.0 blue:0/255.0 alpha:1];
    
    NSDictionary *dict1 = @{
                            //GLTabBarItemTitle : @"首页",
                            GLTabBarItemImage : @"tabbar_home_os7",
                            GLTabBarItemSelectedImage : @"tabbar_home_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict2 = @{
                            //GLTabBarItemTitle : @"消息",
                            GLTabBarItemImage : @"tabbar_message_center_os7",
                            GLTabBarItemSelectedImage : @"tabbar_message_center_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict3 = @{
                            //GLTabBarItemTitle : @"发现",
                            GLTabBarItemImage : @"tabbar_discover_os7",
                            GLTabBarItemSelectedImage : @"tabbar_discover_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSDictionary *dict4 = @{
                            //GLTabBarItemTitle : @"我的",
                            GLTabBarItemImage : @"tabbar_profile_os7",
                            GLTabBarItemSelectedImage : @"tabbar_profile_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4 ];
    return tabBarItemsAttributes;
}
```
#### 2.扁平动效ButtonItem样式 ＋ 定制按钮
只需要设置tabbar高度、和阴影颜色或图片能实现。

    [tabBarController setTabBarHeight:40];
    [tabBarController setShadeItemBackgroundColor:[UIColor grayColor]];

不传入GLTabBarItemTitle，会自动适应没有title情况。

        NSDictionary *dict1 = @{
                            //GLTabBarItemTitle : @"首页",
                            GLTabBarItemImage : @"tabbar_home_os7",
                            GLTabBarItemSelectedImage : @"tabbar_home_selected_os7",
                            GLTabBarItemTitleTextAttributes : normalAttrs,
                            GLTabBarItemSelectedTitleTextAttributes : selectedAttrs
                            };

### GLNavigationController
#### 1. GLNavigationController
非常简单，只需要设置popStyle属性，就能使用2种样式。

    GLPersonViewController *personViewController = [[GLPersonViewController alloc] init];
    GLNavigationController *personNavigationController = [[GLNavigationController alloc]
                                                    initWithRootViewController:personViewController];
    personNavigationController.popStyle = ScreenShotPopStyle;

#### 2.UINavigationBar+GLTransform
引用分类，由UIScrollView代理方法计算出并设置当前bar的颜色。

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        [self.navigationController.navigationBar setBackgroundColor:[color colorWithAlphaComponent:alpha]];
}
```
根据滑动变化计算bar位移变化。

```
    [self.navigationController.navigationBar setTranslationY:(-44 * progress)];
[self.navigationController.navigationBar setElementsAlpha:(1-progress)];
```

### GLPageViewController
创建GLPageViewController要传入titles－标题，pageControlStyle－pageControl样式，needPageControlView－是否在vc的view上加PageControlView 。

    NSArray *titles = @[@"首页",@"电视剧",@"综艺",@"会员",@"电影",@"测试超长长长长长长长长",@"动漫",@"韩日剧",@"自媒体",@"体育",@"娱乐",@"直播"];
    
    GLPageViewController* pageViewController = [[GLPageViewController alloc] initWithTitles:titles pageControlStyle:GLPageControlFontChangeStyle needPageControlView:YES];
    
    self.pageVCModel= [[GLPageVCModel alloc] init];
    pageViewController.delegate=self.pageVCModel;
    
    UINavigationController *homeNavigationController = [[GLNavigationController alloc]initWithRootViewController:pageViewController];
 
实现GLPageViewControllerDelegate，提供ViewController。
 
```
-(UIViewController *)getViewControllerWithIndex:(NSUInteger)index
```
当滑动到某个位置代理方法。

```
-(void)didSelectViewControllerWithIndex:(NSUInteger)index
```

### GLSideViewController
传入左侧、右侧和内容ViewController，leftSideViewController、rightSideViewController可以为nil。


```
- (GLSideViewController*)sideViewController
{
    GLLeftViewController *leftSideViewController = [[GLLeftViewController alloc] init];
    GLRightViewController *rightSideViewController = [[GLRightViewController alloc] init];
    
    GLSideViewController *sideViewController = [[GLSideViewController alloc]
                                                initWithContentViewController:[self tabBarController]
                                                leftSideViewController:leftSideViewController
                                                rightSideViewController:rightSideViewController];
                                                
}
```
设置backgroundImage 和 delegate

```
sideViewController.backgroundImage = [UIImage imageNamed:@"sideBack"];
sideViewController.delegate = self;
```
设置一下属性可以实现扁平策划。
    
    sideViewController.fadeSideView = NO;
    sideViewController.scaleContentView = NO;
    sideViewController.scaleBackgroundImageView = NO;
    sideViewController.scaleSideView = NO;

设置RootViewController为sideViewController

```
[self.window setRootViewController:[self sideViewController]];
```

UIViewController+GLSide类别也提供了调出方法，一般用于barbuttonitem调出左右vc。

```
- (void)presentLeftSideViewController;
- (void)presentRightSideViewController;
```

## 如何安装（还没做😄）
使用CocoaPods导入GLNavigationArchitectureSet。
如果没有安装 CocoaPods, 运行以下命令进行安装:

```
gem install cocoapods
```
在 Podfile 中进行如下导入：

```
platform :ios, '7.0'

target 'TargetName' do
pod 'GLNavigationArchitectureSet', '~> 0.7'
end
```
然后用如下方式更新：

```
pod update
```

## 问题反馈
改类库现在完成度70%左右，还有很多地方需要优化，如在试用过程中有问题，请联系我 [![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social&maxAge=2592000?style=plastic)](https://twitter.com/GarfieldLover5)，或者提交Issues。

## 喜欢就Star下吧😄