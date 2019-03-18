//
//  FQTableVC.swift
//  FQScreenshotDemo
//
//  Created by 付强 on 2019/3/16.
//  Copyright © 2019年 IamTheHeroYasuo. All rights reserved.
//

import UIKit

class FQTableVC: BaseViewController {

    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func initSubVCs() {
        tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        shotView = tableView
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
}


extension FQTableVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "FQTableViewVcCel"
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        cell.textLabel?.text = "列表:\(indexPath.row)"
        return cell
    }
    
}
