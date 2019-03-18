//
//  ViewController.swift
//  FQScreenshotDemo
//
//  Created by TeacherFu on 2019/3/15.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataArr:[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initTableView()
    }
    
    func loadData(){
        dataArr = ["UIWebView保存为图片","UITableView保存为图片","WKWebView保存为图片","UIScrollView保存为图片","UICollectionView保存为图片","UIView保存图片"]
    }
    
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.reloadData()
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArr == nil{return 0}
        return (self.dataArr?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ViewControllerCell"
        let cell  = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        cell.textLabel?.text = dataArr?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextVC:UIViewController?
        switch indexPath.row {
        case 0:
            nextVC = FQWebVC()
        case 1:
            nextVC = FQTableVC()
        case 2:
            nextVC = FQWkWebVC()
        case 3:
            nextVC = FQScrollViewVC()
        case 4:
            nextVC = FQCollectionVC()
        case 5:
            nextVC = FQViewVC()
        default:
            break
        }
        if nextVC != nil{
            self.navigationController?.pushViewController(nextVC!, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

