//
//  JXItemViewController.swift
//  passwordManagement
//
//  Created by jiaxian_he on 16/7/31.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXItemViewController: UIViewController {
    
    private var itemTableView: JXItemTableView!
    private var selectedRow: Int!
    private var data: Array<(String, String)> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [("QQ", "123456"), ("WW", "123456"), ("EE", "123456"), ("RR", "123456"), ("TT", "123456"), ]
        addTableView()
    }
    
    func tableView(_ tableView: JXItemTableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath[1]
        showAlertView()
    }
    
    func tableView(_ tableView: JXItemTableView, deleteRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.data = data
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }

}

//MARK: - selectAction
extension JXItemViewController {
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
            self.present(JXProtectViewController(), animated: true, completion: nil)
        }
    }
    
    func selectListAction() {
        if isNeedToProtect() {
            
        }
    }
    
    func editAction() {
        
    }
}

//MARK: - UI
extension JXItemViewController {
    private func addTableView() {
        itemTableView = JXItemTableView(data:data)
        itemTableView.didSelectRow = { [weak self] in
            self!.tableView($0, didSelectRowAt: $1)
        }
        itemTableView.deleteRow = { [weak self] in
            self!.tableView($0, deleteRowAt: $1)
        }
        view.addSubview(itemTableView)
        itemTableView.fullLayout()
    }
}
