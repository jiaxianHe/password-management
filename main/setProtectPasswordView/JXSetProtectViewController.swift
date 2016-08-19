//
//  JXSetProtectViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/19.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXSetProtectViewController: UIViewController {

    private enum JXSetProtectStatus {
        case JXSetProtectStatusVerifyOld, JXSetProtectStatusInputNew, JXSetProtectStatusVerifyNew
    }
    private var code: Array<Int> = []
    private var newPassword: Array<Int> = []
    private let protectView = JXProtectView(isCanUseFingerprint: false)
    private var status = JXSetProtectStatus.JXSetProtectStatusVerifyOld
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProtectView()
    }
    
    private func codeNumberAction(sender: UIButton) {
        guard code.count < 6 else {
            return
        }
        protectView.inAcode(number: code.count)
        code.append(sender.tag - 2000)
        protectView.cancelButton.setTitle("删除", for: .normal)
        if code.count == 6 {
            if status == .JXSetProtectStatusVerifyOld {
                verifyOld()
            }
            else if status == .JXSetProtectStatusInputNew {
                inputNew()
            }
            else if status == .JXSetProtectStatusVerifyNew {
                verifyNew()
            }
        }
    }
    
    private func verifyOld() {
        
        if code == JXprotectPassword {
            clearCode()
            protectView.title = "请输入你的新密码"
            status = .JXSetProtectStatusInputNew
        }
        else {
            protectView.codeIdentifyShake() { [weak self] in
                self!.clearCode()
                self!.showAlertViewWith(title: "原密码错误", message: nil, alertAction: UIAlertAction(title: "确定", style: .default, handler: nil))
            }
            
        }
    }
    
    private func inputNew() {
        newPassword = code
        clearCode()
        protectView.title = "请再输入一遍新密码"
        status = .JXSetProtectStatusVerifyNew
    }
    
    private func verifyNew() {
        if code == newPassword {
            JXprotectPassword = newPassword
            DispatchQueue.global().async {
                JXAppDelegate.saveData()
            }
            showAlertViewWith(title: "修改成功", message: nil, alertAction: UIAlertAction(title: "确定", style: .default, handler: { [weak self] (action) in
                self!.dismiss(animated: true, completion: nil)
            }))
        }
        else {
            protectView.title = "请输入你的新密码"
            status = .JXSetProtectStatusInputNew
            protectView.codeIdentifyShake() { [weak self] in
                self!.clearCode()
                self!.showAlertViewWith(title: "提示", message: "第二次输入错误，请重新输入", alertAction: UIAlertAction(title: "确定", style: .default, handler: nil))
            }
            
        }
    }
    
    private func clearCode() {
        for No in 0 ..< 6 {
            self.protectView.outAcode(number: No)
        }
        self.code.removeAll()
        self.protectView.cancelButton.setTitle("取消", for: .normal)
    }
    
    @objc private func cancelAction() {
        if code.count == 0 {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            protectView.outAcode(number: code.count - 1)
            code.removeLast()
            if code.count == 0 {
                protectView.cancelButton.setTitle("取消", for: .normal)
            }
        }
    }

}

//MARK: - UI
extension JXSetProtectViewController {
    func addProtectView() {
        protectView.title = "请输入原密码"
        self.view.addSubview(protectView)
        protectView.fullLayout()
        protectView.codeNumber = { [weak self] in
            self!.codeNumberAction(sender: $0)
        }
        protectView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
    }
}
