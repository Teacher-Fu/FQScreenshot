//
//  UIImage+FQSccreenshot.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/15.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

extension UIImage{
    
    /**
     *  拼接快照
     *
     *  @param SnapshotArray 快照的数组
     *
     *  @return 最终拼接的图片
     */
    static func getShotImageFormSnapshotArray(imageArrs:[UIImage]) -> UIImage{
        if imageArrs.count == 0{return UIImage()}
        var shotImage:UIImage?
        autoreleasepool {
            let imageTotalSize:CGSize = getImageTotalSizeFromSnapshotArray(imageArrs: imageArrs)
            UIGraphicsBeginImageContextWithOptions(imageTotalSize, false, UIScreen.main.scale)
            //拼接图片
            var imageOffset_y:CGFloat = 0
            for tempImage in imageArrs{
                tempImage.draw(at: CGPoint(x: 0, y: imageOffset_y))
                imageOffset_y = imageOffset_y + tempImage.size.height
                
            }
            
            shotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return shotImage!
    }
    
    
    private static func getImageTotalSizeFromSnapshotArray(imageArrs:[UIImage]) -> CGSize{
        var totalSize = CGSize.zero
        for temImage in imageArrs{
            let imageSize = temImage.size
            totalSize.height = imageSize.height + totalSize.height
            totalSize.width = max(totalSize.width, imageSize.width)
        }
        return totalSize
    }
}
