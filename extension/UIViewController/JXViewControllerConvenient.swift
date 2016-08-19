//
//  JXViewControllerConvenient.swift
//  passwordManagement
//
//  Created by shanp on 16/8/9.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertViewWith(title: String?, message: String?, alertAction: UIAlertAction...) -> Void {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in alertAction {
            alertView.addAction(action)
        }
        self.present(alertView, animated: true, completion: nil)
    }
    
}
