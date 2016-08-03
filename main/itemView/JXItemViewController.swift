//
//  JXItemViewController.swift
//  passwordManagement
//
//  Created by jiaxian_he on 16/7/31.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXItemViewController: UIViewController {
    
    private var tableView: JXTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
        // Do any additional setup after loading the view.
    }

}

extension JXItemViewController {
    private func addTableView() {
        self.tableView = JXItemTableView()
        self.view.addSubview(tableView)
        self.tableView.fullLayout()
    }
}
