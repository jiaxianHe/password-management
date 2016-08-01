//
//  JXViewConfigure.swift
//  passwordManagement
//
//  Created by shanp on 16/8/1.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UIView {
    
    func layout(_ closure:(UIView) -> ()) {
        self.translatesAutoresizingMaskIntoConstraints = false
        closure(self)
    }
    
}

extension NSLayoutConstraint {
    
    func activeTrue() {
        self.isActive = true
    }
    
}
