//
//  JXProtectViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/5.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXProtectViewController: UIViewController {

    var code: Array<Int> = []
    
    override func loadView() {
        self.view = JXProtectView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK: - UI
extension JXProtectViewController {
    
}
