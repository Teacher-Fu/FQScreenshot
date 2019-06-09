//
//  FQCollectionVC.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQCollectionVC: BaseViewController {
    
    let cellID = "FQCollectionCellID"
    var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initSubVCs() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        shotView = collectionView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}

extension FQCollectionVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 123
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.contentView.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        return cell
    }
    
    
}
