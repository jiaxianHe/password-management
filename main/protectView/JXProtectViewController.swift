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
    private let protectView = JXProtectView()
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
                    self.verifySuccess()
                }
                else {
                    if !automate && error?.code == LAError.touchIDNotEnrolled.rawValue {
                        self.showAlertViewWith(title:"未开启系统Touch ID", message: "请先在系统设置-Touch ID与密码中开启", alertAction: UIAlertAction(title: "知道了", style: .default, handler: nil))
                    }
                }
            })
        }
    }

    private func codeNumberAction(sender: UIButton) {
        let password = [0, 0, 0, 0, 0, 0]
        protectView.inAcode(number: code.count)
        code.append(sender.tag - 2000)
        protectView.cancelButton.setTitle("删除", for: .normal)
        if code.count == 6 {
            if code == password {
                verifySuccess()
            }
            else {
                for No in 0 ..< 6 {
                    protectView.outAcode(number: No)
                }
                code.removeAll()
                protectView.cancelButton.setTitle("取消", for: .normal)
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
    
}

//MARK: - UI
extension JXProtectViewController {
    func addProtectView() {
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
