# FQScreenShot

## 一句代码保存截图,将View相关的页面保存为图片,支持 UIView,UIScrollView,UITableView,UICollectionView,UIWebView,WKWebView。支持iOS11

[![](https://img.shields.io/badge/Supported-iOS7-4BC51D.svg?style=flat-square)](https://github.com/Teacher-Fu/FQScreenshot)
[![](https://img.shields.io/badge/Swift-compatible-4BC51D.svg?style=flat-square)](https://github.com/Teacher-Fu/FQScreenshotl)


### 方法一:cocopods
- 1、:

```swift
在Podfile文件里面添加:pod 'FQScreenShot'
```
- 2、:对应文件添加头文件

```swift
import FQScreenShot


//在需要截图的地方调用此方法
FQScreenShot.screenShot(yourView) { (shotImage) in
            toDoSomething
}
```

### 方法二:手动添加
- 1、引入头文件:

```swift
import FQScreenShot
```
- 2、使用以下方法

```swift
//在需要截图的地方调用此方法
FQScreenShot.screenShot(yourView) { (shotImage) in
            toDoSomething
}
```


![FQScreenShot](shot.gif)


