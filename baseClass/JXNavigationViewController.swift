//
//  JXNavigationViewController.swift
//  passwordManagement
//
//  Created by jiaxian_he on 16/7/31.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXNavigationViewController: UINavigationController {

    var statusBarStyle: UIStatusBarStyle = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

}
