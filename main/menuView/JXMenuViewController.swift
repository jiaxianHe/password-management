//
//  JXMenuViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/17.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXMenuViewController: UIViewController {

    private var menuTableView: JXMenuTableView!
    private var optionsBackground: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "菜单"
        self.view.backgroundColor = UIColor.white()
        addCancelButton()
        addTableView()
        menuTableView.didSelectRow =  { [weak self] in
            self!.tableView($0, didSelectRowAt: $1)
        }
    }
    
    private func tableView(_ tableView: JXMenuTableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath[1] {
        case 0:
            creatOptionsBackground()
            displaySelectPasswordLenght()
        case 1:
            self.present(JXSetProtectViewController(), animated: true, completion: nil)
        default:
            return
        }
        
    }
    
    private func creatOptionsBackground() {
        optionsBackground = UIWindow(frame: UIScreen.main().bounds)
        optionsBackground.backgroundColor = UIColor(white: 0.0, alpha: 0.78)
        optionsBackground.windowLevel = UIWindowLevelAlert - 1
        optionsBackground.isHidden = false
    }
    
    private func dismissOptionsBackground() {
        optionsBackground.isHidden = true
        optionsBackground = nil
    }
    
    @objc private func cancelButtonAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: - SelectPasswordLenght
extension JXMenuViewController {
    
    private func displaySelectPasswordLenght() {
        let background = UIView()
        background.backgroundColor = UIColor.white()
        background.fillet(cornerRadius: 5, borderWidth: nil, borderColor: nil)
        optionsBackground.addSubview(background)
        background.layout {
            $0.centerYAnchor.constraint(equalTo: $0.superview!.centerYAnchor).activeTrue()
            $0.centerXAnchor.constraint(equalTo: $0.superview!.centerXAnchor).activeTrue()
        }
        var passwordRange: Array<Int> = []
        for rangeArray in JXpasswordRange {
            for index in rangeArray[0] ..< rangeArray[1] {
                passwordRange.append(index)
            }
        }
        let selectPasswordView = JXSelectPasswordLenghtView(selectedArray: passwordRange)
        selectPasswordView.tag = 3000
        background.addSubview(selectPasswordView)
        selectPasswordView.layout {
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor).activeTrue()
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor).activeTrue()
        }
        
        let confirmButton = UIButton.convenient(title: "确定", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 20, action: #selector(confirmAction), target: self, tag: nil)
        confirmButton.fillet(cornerRadius: nil, borderWidth: onePixel, borderColor: UIColor.color(withHexString: "#666666"))
        background.addSubview(confirmButton)
        
        confirmButton.layout {
            $0.topAnchor.constraint(equalTo: selectPasswordView.bottomAnchor).activeTrue()
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor).activeTrue()
            $0.heightAnchor.constraint(equalToConstant: 40)
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor).activeTrue()
        }
        
        let cancelButton = UIButton.convenient(title: "取消", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 20, action: #selector(cancelAction), target: self, tag: nil)
        cancelButton.fillet(cornerRadius: nil, borderWidth: onePixel, borderColor: UIColor.color(withHexString: "#666666"))
        background.addSubview(cancelButton)
        
        cancelButton.layout {
            $0.topAnchor.constraint(equalTo: selectPasswordView.bottomAnchor).activeTrue()
            $0.leftAnchor.constraint(equalTo: confirmButton.rightAnchor).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor).activeTrue()
            $0.heightAnchor.constraint(equalToConstant: 40)
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor).activeTrue()
            $0.widthAnchor.constraint(equalTo: confirmButton.widthAnchor).activeTrue()
        }
        
    }
    @objc private func confirmAction(sender: UIButton) {
        let selectPasswordView = sender.superview!.viewWithTag(3000) as! JXSelectPasswordLenghtView
        guard selectPasswordView.selected.count != 0 else {
            optionsBackground.isHidden = true
            showAlertViewWith(title: "请选择密码区间", message: nil, alertAction: UIAlertAction(title: "确定", style: .default, handler: { [weak self] (action) in
                self!.optionsBackground.isHidden = false
            }))
            return
        }
        selectPasswordView.selected.sort()
        debugLog(selectPasswordView.selected)
        var tempItem = selectPasswordView.selected[0] - 1
        var count = 0
        var begin = selectPasswordView.selected[0]
        var result: Array<[Int]> = []
        for item in selectPasswordView.selected {
            if item - 1 == tempItem {
                count += 1
            }
            else {
                result.append([begin, begin + count])
                count = 1
                begin = item
                
            }
            if item == selectPasswordView.selected.last! {
                result.append([begin, begin + count])
            }
            else {
                tempItem = item
            }
        }
        JXpasswordRange = result
        DispatchQueue.global().async {
            JXAppDelegate.saveData()
        }
        dismissOptionsBackground()
    }
    
    @objc private func cancelAction(sender: UIButton) {
        dismissOptionsBackground()
    }
    
}

//MARK: - UI
extension JXMenuViewController {
    
    private func addCancelButton() {
        let cancelButton = UIButton.convenient(title: "取消", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 18, action: #selector(cancelButtonAction), target: self, tag: nil)
        cancelButton.sizeToFit()
        let cancelItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = cancelItem
    }
    
    private func addTableView() {
        menuTableView = JXMenuTableView()
        self.view.addSubview(menuTableView)
        menuTableView.fullLayout()
    }
    
}
