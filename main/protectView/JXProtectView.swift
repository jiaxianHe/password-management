//
//  JXProtectView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/5.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXProtectView: UIView {
    
    convenience init() {
        self.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white()
        addNumber()
    }
    
    func addNumber() {
        let backgroundView = UIView()
        self.addSubview(backgroundView)
        
    }

    deinit {
        let className = NSStringFromClass(self.dynamicType)
        debugLog("deinit------" + className)
    }
}
