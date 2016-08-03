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
    
    func fullLayout() {
        self.layout {
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor).activeTrue()
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor).activeTrue()
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor).activeTrue()
        }
    }
    
}

extension NSLayoutConstraint {
    
    func activeTrue() {
        self.isActive = true
    }
    
}
