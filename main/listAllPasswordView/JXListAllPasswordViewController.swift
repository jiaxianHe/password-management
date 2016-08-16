//
//  JXListAllPasswordViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/11.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXListAllPasswordViewController: UIViewController {
    
    private var listAllPasswordTableView: JXListAllPasswordTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        listAllPasswordTableView.didSelectRow = { [weak self] in
            self!.tableView($0, didSelectRowAt: $1)
        }
    }
    
    private func tableView(_ tableView: JXListAllPasswordTableView, didSelectRowAt indexPath: IndexPath) {
        showAlertView(didSelectRowAt: indexPath)
    }

}

//MARK: - UI
extension JXListAllPasswordViewController {
    private func addTableView() {
        listAllPasswordTableView = JXListAllPasswordTableView(data: JXAppDelegate.data)
        self.view.addSubview(listAllPasswordTableView)
        listAllPasswordTableView.fullLayout()
    }
}

//MARK: - selectAction
extension JXListAllPasswordViewController {
    private func showAlertView(didSelectRowAt indexPath: IndexPath) {
        let copyOriginalPasswordAction = UIAlertAction(title: "复制原始密码", style: .default) {
            [weak self] action in
            self!.copyOriginalPasswordAction(didSelectRowAt: indexPath)
        }
        let copyUserfulPasswordAction = UIAlertAction(title: "复制使用密码", style: .default) { [weak self] action in
            self!.copyUserfulPasswordAction(didSelectRowAt: indexPath)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        showAlertViewWith(title: "请选择", message: nil, alertAction: copyOriginalPasswordAction, copyUserfulPasswordAction, cancelAction)
    }
    
    private func copyOriginalPasswordAction(didSelectRowAt indexPath: IndexPath) {
        let pasteboard = UIPasteboard.general()
        pasteboard.string = JXAppDelegate.data[indexPath[1]].1
    }
    
    private func copyUserfulPasswordAction(didSelectRowAt indexPath: IndexPath) {
        let pasteboard = UIPasteboard.general()
        pasteboard.string = JXAppDelegate.data[indexPath[1]].2
    }
}
