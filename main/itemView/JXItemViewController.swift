//
//  JXItemViewController.swift
//  passwordManagement
//
//  Created by jiaxian_he on 16/7/31.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXItemViewController: UIViewController {
    
    private var tableView: JXItemTableView!
    private var selectedRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
        // Do any additional setup after loading the view.
        JXKeychain.save(service: JXItemKeychainKey, data: [1,2,3,4]);
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath[1]
        self.showAlertView()
    }
    
    func showAlertView() {
        let alertView = UIAlertController(title: "请选择", message: nil, preferredStyle: .alert)
        let singleShowAction = UIAlertAction(title: "显示一个", style: .default) {
            [weak self] action in
            self!.singleSelectAction()
        }
        let showListAction = UIAlertAction(title: "显示所有", style: .default) { [weak self] action in
            self!.selectListAction()
        }
        let editAction = UIAlertAction(title: "进入密码空间", style: .default) {
            [weak self] action in
            self!.editAction()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertView.addAction(singleShowAction)
        alertView.addAction(showListAction)
        alertView.addAction(editAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func singleSelectAction() {
        if isNeedToProtect() {
            
        }
    }
    
    func selectListAction() {
        if isNeedToProtect() {
            
        }
    }
    
    func editAction() {
        if let value = JXKeychain.load(service: JXItemKeychainKey) {
            debugLog(value)
        }
    }

}

extension JXItemViewController {
    private func addTableView() {
        self.tableView = JXItemTableView()
        self.tableView.didSelectRow = { [weak self] in
            self?.tableView(tableView: $0, didSelectRowAt: $1)
        }
        self.view.addSubview(tableView)
        self.tableView.fullLayout()
    }
}
