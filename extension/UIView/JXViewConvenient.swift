//
//  JXViewConvenient.swift
//  passwordManagement
//
//  Created by shanp on 16/8/16.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillet(cornerRadius: CGFloat?, borderWidth: CGFloat?, borderColor: UIColor?) {
        if let _cornerRadius = cornerRadius {
            self.layer.cornerRadius = _cornerRadius;
            self.layer.masksToBounds = true;
        }
        if let _borderWidth = borderWidth {
            self.layer.borderWidth = _borderWidth
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
}
