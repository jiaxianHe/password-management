//
//  JXTextFieldConvenient.swift
//  passwordManagement
//
//  Created by shanp on 16/8/15.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

extension UITextField {
    class func convenient(font: Float?, placeholder: String?, tag: Int?, textColor: UIColor, delegate: UITextFieldDelegate?, clearButtonMode: UITextFieldViewMode = .whileEditing, keyboardType: UIKeyboardType = .default, returnKeyType: UIReturnKeyType = .default) -> UITextField {
        let textField = UITextField()
        if let titleFont = font {
            textField.font = UIFont(name: "ArialMT", size: CGFloat(titleFont))
        }
        textField.placeholder = placeholder
        if let labelTag = tag {
            textField.tag = labelTag
        }
        textField.textColor = textColor
        textField.delegate = delegate
        textField.clearButtonMode = clearButtonMode
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        return textField
    }
}
