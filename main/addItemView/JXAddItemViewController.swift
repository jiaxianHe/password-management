//
//  JXAddItemViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/15.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXAddItemViewController: UIViewController, UITextFieldDelegate {

    private var itemPasswordTextField: UITextField!
    private var itemNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加项目"
        self.view.backgroundColor = UIColor.white()
        addContentView()
        addNavigationBarButton()
    }

    @objc private func confirmButtonAction() {
        UIApplication.shared().keyWindow?.endEditing(true)
        if itemNameTextField.text == "" {
            showAlertViewWith(title: "请输入项目名称", message: "", alertAction: UIAlertAction(title: "确定", style: .default, handler: nil))
        }
        else if itemPasswordTextField.text == "" {
            showAlertViewWith(title: "请输入项目密码", message: "", alertAction: UIAlertAction(title: "确定", style: .default, handler: nil))
        }
        else {
            let passwordSpaceViewController = JXPasswordSpaceViewController()
            passwordSpaceViewController.JXitemName = itemNameTextField.text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared().keyWindow?.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == itemNameTextField {
            itemPasswordTextField .becomeFirstResponder()
        }
        else if textField == itemPasswordTextField {
            confirmButtonAction()
        }
        return true
    }
}

//MARK: - UI
extension JXAddItemViewController {
    
    private func addContentView() {
        let itemNameLabel = UILabel.convenient(title: "项目名称：", titleColor: UIColor.color(withHexString: "#222222"), font: 16, tag: nil)
        self.view.addSubview(itemNameLabel)
        
        itemNameTextField = UITextField.convenient(font: 16, placeholder: "请输入项目名称", tag: nil, textColor: UIColor.color(withHexString: "#666666"), delegate: self)
        itemNameTextField.fillet(cornerRadius: nil, borderWidth: onePixel, borderColor: UIColor.color(withHexString: "#999999"))
        self.view.addSubview(itemNameTextField)
        
        let itemPasswordLabel = UILabel.convenient(title: "项目密码：", titleColor: UIColor.color(withHexString: "#222222"), font: 16, tag: nil)
        self.view.addSubview(itemPasswordLabel)
        
        itemPasswordTextField = UITextField.convenient(font: 16, placeholder: "请输入项目密码", tag: nil, textColor: UIColor.color(withHexString: "#666666"), delegate: self)
        itemPasswordTextField.fillet(cornerRadius: nil, borderWidth: onePixel, borderColor: UIColor.color(withHexString: "#999999"))
        self.view.addSubview(itemPasswordTextField)
        
        itemNameLabel.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: 100).activeTrue()
        }
        
        itemNameTextField.layout {
            $0.centerYAnchor.constraint(equalTo: itemNameLabel.centerYAnchor).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.leftAnchor.constraint(equalTo: itemNameLabel.rightAnchor, constant: 5).activeTrue()
            $0.heightAnchor.constraint(equalToConstant: 30).activeTrue()
        }
        
        itemPasswordLabel.layout {
            $0.leftAnchor.constraint(equalTo: itemNameLabel.leftAnchor).activeTrue()
            $0.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 20).activeTrue()
        }
        itemPasswordLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        
        itemPasswordTextField.layout {
            $0.centerYAnchor.constraint(equalTo: itemPasswordLabel.centerYAnchor).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.leftAnchor.constraint(equalTo: itemPasswordLabel.rightAnchor, constant: 5).activeTrue()
            $0.heightAnchor.constraint(equalToConstant: 30).activeTrue()
        }
        
    }
    
    private func addNavigationBarButton() {
        let confirmButton = UIButton.convenient(title: "确定", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 18, action: #selector(confirmButtonAction), target: self, tag: nil)
        confirmButton.sizeToFit()
        let confirmItem = UIBarButtonItem(customView: confirmButton)
        self.navigationItem.rightBarButtonItem = confirmItem
    }
}
