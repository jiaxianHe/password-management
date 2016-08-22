//
//  JXProtectViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/5.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit
import LocalAuthentication

class JXProtectViewController: UIViewController {

    private var code: Array<Int> = []
    private let protectView = JXProtectView(isCanUseFingerprint: JXAppDelegate.isCanUseFingerprint)
    var verificationResults: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProtectView()
        useFingerprint(automate: true)
        
    }
    
    private func useFingerprint(automate: Bool) {
        if JXAppDelegate.isCanUseFingerprint {
            let authentication = LAContext()
            authentication.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "需要验证你的密码", reply: { (success, error) in
                if success {
                    DispatchQueue.main.async(execute: { 
                        self.verifySuccess()
                    })
                }
                else {
                    if !automate && error?._code == LAError.touchIDNotEnrolled.rawValue {
                        DispatchQueue.main.async(execute: { 
                            self.showAlertViewWith(title:"未开启系统Touch ID", message: "请先在系统设置-Touch ID与密码中开启", alertAction: UIAlertAction(title: "知道了", style: .default, handler: nil))
                        })
                    }
                }
            })
        }
    }

    private func codeNumberAction(sender: UIButton) {
        guard code.count < 6 else {
            return
        }
        protectView.inAcode(number: code.count)
        code.append(sender.tag - 2000)
        protectView.cancelButton.setTitle("删除", for: .normal)
        if code.count == 6 {
            if code == JXprotectPassword {
                verifySuccess()
            }
            else {
                protectView.codeIdentifyShake() { [weak self] in
                    for No in 0 ..< 6 {
                        self!.protectView.outAcode(number: No)
                    }
                    self!.code.removeAll()
                    self!.protectView.cancelButton.setTitle("取消", for: .normal)
                }
                
            }
            
        }
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
    
    @objc private func fingerprintAction() {
        useFingerprint(automate: false)
    }
    
    private func verifySuccess() {
        self.dismiss(animated: true, completion: {
            if let _verificationResults = self.verificationResults {
                _verificationResults(true)
            }
        })
    }
    
//MARK: - UI
    func addProtectView() {
        protectView.title = JXAppDelegate.isCanUseFingerprint ? "Touch ID 或输入密码" : "输入密码"
        self.view.addSubview(protectView)
        protectView.fullLayout()
        protectView.codeNumber = { [weak self] in
            self!.codeNumberAction(sender: $0)
        }
        protectView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        if let _fingerprintButton = protectView.fingerprintButton {
            _fingerprintButton.addTarget(self, action: #selector(fingerprintAction), for: .touchUpInside)
        }
        
    }
}
