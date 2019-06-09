//
//  UIView+FQScreenshot.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/15.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

extension UIView{
    
    func viewScreenShot(finishBlock:imageBackBlock?){
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        let currentContent = UIGraphicsGetCurrentContext()
        layer.render(in: currentContent!)
        let shotImage = UIGraphicsGetImageFromCurrentImageContext()
        if finishBlock != nil{
            finishBlock?(shotImage!)
        }
    }
    
    func viewScrrenSnpShot(finishBlock:imageBackBlock?){
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let shotImage = renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        Thread.sleep(forTimeInterval: 0.3)
        if finishBlock != nil{
            finishBlock?(shotImage)
        }
    }
}



extension UIView{
    /// 嵌套结构体
    private struct FQAssociatedKeys {
        static var isShowKey = "FQIsShowKey"
        static var displayNameKey = "FQDisplayNameKey"
        static var widthKey = "FQWidthKey"
        static var insertLayer = "FQInsertLayer"
    }
    
    /// 通用的插入layer
    fileprivate var insertLayer:CALayer?{
        set{
            objc_setAssociatedObject(self, &FQAssociatedKeys.insertLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, &FQAssociatedKeys.insertLayer) as? CALayer
        }
    }
    
    /// 多张图片拼接
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - chartType:
    ///   -  fillColor  填充颜色
    /// - completion: 返回图片回调
    func async_maskRadiusImage(chartType:ChartType){
        if self.bounds.size.height != self.bounds.size.width{
            return
        }
        if chartType == .circular {
            
        }else if chartType == .rectangle{
            return
        }else if chartType == .triangle{
            triangle(cornerRadius: 0, lineWidth: 0, lineColor: UIColor.red)
        }else if chartType == .regularHexagon{
            hexagon(cornerRadius: 0, lineWidth: 0, lineColor: UIColor.green)
        }else if chartType == .pentagon{
            pentagon(cornerRadius: 0, lineWidth: 0, lineColor: UIColor.red)
        }else if chartType == .diamond{
            diamond(cornerRadius: 0, lineWidth: 0, lineColor: nil)
        }
    }
    
    enum ChartType:String{
        case triangle//三角形
        case regularHexagon//正六边形
        case circular//圆形
        case rectangle//矩形
        case pentagon//五角形
        case diamond//菱形
//        case five_pointed_star//五角星
    }
    
    func triangle(cornerRadius:CGFloat,lineWidth:CGFloat,lineColor:UIColor?){
        pathAddOthers(cornerRadius: cornerRadius, lineWidth: lineWidth, lineColor: lineColor, sides: 3)
    }
    
    func pentagon(cornerRadius:CGFloat,lineWidth:CGFloat,lineColor:UIColor?){
        pathAddOthers(cornerRadius: cornerRadius, lineWidth: lineWidth, lineColor: lineColor, sides: 5)
    }
    
    func diamond(cornerRadius:CGFloat,lineWidth:CGFloat,lineColor:UIColor?){
        pathAddOthers(cornerRadius: cornerRadius, lineWidth: lineWidth, lineColor: lineColor, sides: 4)
    }
    
    func hexagon(cornerRadius:CGFloat,lineWidth:CGFloat,lineColor:UIColor?){
        pathAddOthers(cornerRadius: cornerRadius, lineWidth: lineWidth, lineColor: lineColor, sides: 6)
    }
    
//    func five_pointed_star(cornerRadius:CGFloat,lineWidth:CGFloat,lineColor:UIColor?){
//        var shapeLayer:CAShapeLayer!
//        if (self.insertLayer != nil)
//        {
//            self.insertLayer?.removeFromSuperlayer()
//            shapeLayer = self.insertLayer as! CAShapeLayer
//        }else{
//            shapeLayer = CAShapeLayer()
//            self.insertLayer = shapeLayer
//        }
//        let shapePath = self.five_pointed_star(rect: self.bounds, lineWidth: lineWidth, cornerRadius: cornerRadius)
//        shapeLayer.path = shapePath.cgPath
//        if (lineColor != nil){
//            shapeLayer.strokeColor = lineColor?.cgColor
//        }
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = min(0, lineWidth)
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = shapePath.cgPath
//        self.layer.mask = maskLayer
//        self.layer.insertSublayer(shapeLayer, above: maskLayer)
//    }
//
//    func five_pointed_star(rect:CGRect,lineWidth:CGFloat,cornerRadius:CGFloat) -> UIBezierPath
//    {
//        let cutRation:CGFloat = 0.02;
//        let path = UIBezierPath()
//        let theta:CGFloat = CGFloat(2.0 * Double.pi / Double(5))
//        let half_theta = theta/2
//        let squareWidth = min(rect.size.width, rect.size.height*(1 - cutRation))
//        let offset = cornerRadius * CGFloat(tanf(Float(CGFloat(theta / 2.0))))
//        let offsetX = ((rect.size.width*(1 - cutRation/2) - squareWidth)/2)
//        let offsetY = ((rect.size.height*(1 - cutRation/2) - squareWidth)/2)
//        var length = squareWidth - lineWidth
//        if (5 % 4 != 0){
//            length = length * CGFloat(cosf(Float(theta / 2.0))) + offset/2.0//length * cosf(theta / 2.0)== 短的轴长，
//        }
//        let sideLength = length * CGFloat(tanf(Float(theta / 2.0)))//单边长
//
//        var point = CGPoint(x: 2*sideLength - offset + offsetX, y: offset + sideLength/2 + offsetY)
//        var angle:CGFloat = CGFloat(Double.pi/2)
//        path.move(to: point)
//        for index in 0..<5
//        {
//            autoreleasepool {
//
//                let point1 = CGPoint(x: center.x + sin(angle + CGFloat(index)*theta + half_theta)*(length - length*CGFloat.angleSinValue(half_theta)/sin(theta)), y:point.y - CGFloat.angleCosValue(angle+CGFloat( index)*theta+half_theta)*(length - length*(CGFloat.angleSinValue(half_theta)/CGFloat.angleSinValue(theta))))
//                path.addLine(to: point1)
//                let point2 = CGPoint(x: point.x + CGFloat.angleSinValue(CGFloat(angle + CGFloat(index) * theta)), y:point.y - CGFloat.angleCosValue(angle + CGFloat(index)*theta))
//                path.addLine(to: point2)
//                let center = CGPoint(x: point.x + cornerRadius * CGFloat(cosf(Float(angle + CGFloat(Double.pi/2)))), y:  point.y + cornerRadius * CGFloat(sinf(Float(angle + CGFloat(Double.pi/2)))))
//                path.addArc(withCenter: center, radius: cornerRadius, startAngle: CGFloat(angle - CGFloat(Double.pi/2))
//                    , endAngle:CGFloat(angle + theta - CGFloat(Double.pi/2)), clockwise: true)
//                point = path.currentPoint
//                angle += theta
//            }
//
//
//        }
//        path.close()
//        return path
//    }
    
  
    
    func pathAddOthers(cornerRadius:CGFloat,lineWidth:CGFloat,lineColor:UIColor?,sides:NSInteger){
        var shapeLayer:CAShapeLayer!
        if (self.insertLayer != nil)
        {
            self.insertLayer?.removeFromSuperlayer()
            shapeLayer = self.insertLayer as! CAShapeLayer
        }else{
            shapeLayer = CAShapeLayer()
            self.insertLayer = shapeLayer
        }

        let shapePath = roundedPolygonPath(rect: self.bounds, lineWidth: lineWidth, sides: sides, cornerRadius: cornerRadius, rotationOffset: CGFloat(Double.pi/2))
        shapeLayer.path = shapePath.cgPath
        if (lineColor != nil){
            shapeLayer.strokeColor = lineColor?.cgColor
        }
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = min(0, lineWidth)
        let maskLayer = CAShapeLayer()
        maskLayer.path = shapePath.cgPath
        self.layer.mask = maskLayer
        self.layer.insertSublayer(shapeLayer, above: maskLayer)
    }

   
    
    
    public func roundedPolygonPath(rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0) -> UIBezierPath {
        let path = UIBezierPath()
        let theta: CGFloat = CGFloat(Double.pi*2) / CGFloat(sides) // How much to turn at every corner
        let offset: CGFloat = cornerRadius * tan(theta / 2.0)     // Offset from which to start rounding corners
        let width = min(rect.size.width, rect.size.height)        // Width of the square
        
        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
        
        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
        
        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)
        
        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
        
        for _ in 0..<sides {
            angle += theta
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
            
            path.addLine(to: start)
            path.addQuadCurve(to: end, controlPoint: tip)
        }
        
        path.close()
        
        // Move the path to the correct origins
        let bounds = path.bounds
        let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0, y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
        path.apply(transform)
        
        return path
    }
}



// MARK: - 延展 通过三角函数计算 con 和 sin 角度的值
extension CGFloat {
    // 通过角度获取 cos 值
    static func angleCosValue(_ angle: CGFloat) -> CGFloat {
        return CGFloat(cos(Double.pi/180.0 * Double(angle)))
    }
    
    // 通过角度获取 sin 值
    static func angleSinValue(_ angle: CGFloat) -> CGFloat {
        return CGFloat(sin(Double.pi/180.0 * Double(angle)))
    }
}
