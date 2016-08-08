//
//  JXProtectViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/5.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXProtectViewController: UIViewController {

    private var code: Array<Int> = []
    private let protectView = JXProtectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProtectView()
        
        
    }

    private func codeNumberAction(sender: UIButton) {
        code.append(sender.tag - 2000)
        protectView.cancelButton.setTitle("删除", for: .normal)
    }
    
    @objc private func cancelAction() {
        if code.count == 0 {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            code.removeLast()
            if code.count == 0 {
                protectView.cancelButton.setTitle("取消", for: .normal)
            }
        }
    }
    
    @objc private func fingerprintAction() {
        
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
