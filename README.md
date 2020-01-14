# FQScreenShot

## 一句代码保存截图,将View及其子视图相关的页面保存为图片.

## 一句话异步把view切成圆型,把view切成正三角形,正六边形,正五边形,菱形

## 一句话拼接图片,加水印

[![](https://img.shields.io/badge/Supported-iOS9-4BC51D.svg?style=flat-square)](https://github.com/Teacher-Fu/FQScreenshot)
[![](https://img.shields.io/badge/Swift-compatible-4BC51D.svg?style=flat-square)](https://github.com/Teacher-Fu/FQScreenshot)


### 方法一:cocoapods
- 1、:在Podfile文件里面添加:pod 'FQScreenShot'

- 2、:对应文件添加头文件

```swift
import FQScreenShot

```

### 方法二:手动添加
- 1、下载demo引入文件FQScreenshot,对应文件添加头文件
- 2、:对应文件添加头文件

```swift
import FQScreenShot
```




![FQScreenShot](shot.gif)

###  1.截图

```swift
//在需要截图的地方调用此方法
FQShoutManger.share.screenShot(shotView) { (shotImage) in
//一系列装13操作
}
```

### 2.view切图形
```swift
let image = UIImageView()
image.async_maskRadiusImage(chartType: UIView.ChartType.circular)
```

### 3.加水印
```swift
//水印文字
var image = UIImage()
image = image.drawTextInImage(attributedStr: NSAttributedString(string: "我是大哥"), corner: UIImage.WaterMarkCorner.TopLeft, margin: CGPoint(x: 20, y: 20))
```

```swift
//水印图片
var image = UIImage()
image = image.composeImageWithImage(addImgae: addImg, frame: CGRect(x: 0, y: 0, width:100, height:100), alpha: 1)

```
### 4.拼接图片
```swift
//两张拼接
var finish = UIImage()
let currentImage = UIImage()
let addImage = UIImage()
finish = currentImage.composeOutsideImgaeInImage(addImage: addImage, corner: UIImage.ComposeImageEnum.rightTop, margin: 20)
```
```swift
//多图拼接
var finishImage = UIImage()
let bgImage = UIImage()
let image1 = UIImage()
let image2 = UIImage()
let image3 = UIImage()
let imageArr = [image1,image2,image3]
        
let rect1 = CGRect()
let rect2 = CGRect()
let rect3 = CGRect()
let rectArr = [rect1,rect2,rect3]
finishImage = FQShoutManger.share.composeImageWithImage(bgImage: bgImage, imageRect: rectArr, images: imageArr)
```
