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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        addNavigationBarButton()
        itemTableView.didSelectRow = { [weak self] in
            self!.tableView($0, didSelectRowAt: $1)
        }
        itemTableView.deleteRow = { [weak self] in
            self!.tableView($0, deleteRowAt: $1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if JXIsNeedToRefreshItemView {
            itemTableView.data = JXAppDelegate.data
            itemTableView.reloadData()
            JXIsNeedToRefreshItemView = false
        }
    }
    
    private func tableView(_ tableView: JXItemTableView, didSelectRowAt indexPath: IndexPath) {
        showAlertView(didSelectRowAt: indexPath)
    }
    
    private func tableView(_ tableView: JXItemTableView, deleteRowAt indexPath: IndexPath) {
        JXAppDelegate.data.remove(at: indexPath.row)
        DispatchQueue.global().async { 
            JXAppDelegate.saveData()
        }
        tableView.data = JXAppDelegate.data
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        let menuViewController = JXMenuViewController()
        let nav_menuViewController = JXNavigationViewController(rootViewController: menuViewController)
        self.present(nav_menuViewController, animated: true, completion: nil)
    }
    
    @objc private func addButtonAction(sender: UIButton) {
        self.navigationController?.pushViewController(JXAddItemViewController(), animated: true)
    }
    
//MARK: - selectAction
    private func showAlertView(didSelectRowAt indexPath: IndexPath) {
        let alertView = UIAlertController(title: "请选择", message: nil, preferredStyle: .alert)
        let singleShowAction = UIAlertAction(title: "显示一个", style: .default) {
            [weak self] action in
            self!.singleSelectAction(didSelectRowAt: indexPath)
        }
        let showListAction = UIAlertAction(title: "显示所有", style: .default) { [weak self] action in
            self!.selectListAction()
        }
        let editAction = UIAlertAction(title: "进入密码空间", style: .default) {
            [weak self] action in
            self!.editAction(didSelectRowAt: indexPath)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertView.addAction(singleShowAction)
        alertView.addAction(showListAction)
        alertView.addAction(editAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    private func singleSelectAction(didSelectRowAt indexPath: IndexPath) {
        if JXisNeedToProtect {
            let protectViewController = JXProtectViewController()
            protectViewController.verificationResults = { [weak self] (finish) in
                if finish {
                    self!.showOnePassword(didSelectRowAt: indexPath)
                }
            }
            self.present(protectViewController, animated: true, completion: nil)
        }
        else {
            showOnePassword(didSelectRowAt: indexPath)
        }
    }
    
    private func showOnePassword(didSelectRowAt indexPath: IndexPath) {
        let data = JXAppDelegate.data[indexPath[1]]
        
        let copyOriginalPasswordAction = UIAlertAction(title: "复制原始密码", style: .default) {
            [weak self] action in
            self!.copyOriginalPasswordAction(didSelectRowAt: indexPath)
        }
        let copyUserfulPasswordAction = UIAlertAction(title: "复制使用密码", style: .default) { [weak self] action in
            self!.copyUserfulPasswordAction(didSelectRowAt: indexPath)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        showAlertViewWith(title: data[0], message: data[1] + "\n\n" + data[2], alertAction: copyOriginalPasswordAction, copyUserfulPasswordAction, cancelAction)
    }
    
    private func copyOriginalPasswordAction(didSelectRowAt indexPath: IndexPath) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = JXAppDelegate.data[indexPath[1]][1]
    }
    
    private func copyUserfulPasswordAction(didSelectRowAt indexPath: IndexPath) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = JXAppDelegate.data[indexPath[1]][2]
    }
    
    private func selectListAction() {
        if JXisNeedToProtect {
            let protectViewController = JXProtectViewController()
            protectViewController.verificationResults = { [weak self] (finish) in
                self!.showPassworkList()
            }
            self.present(protectViewController, animated: true, completion: nil)
        }
        else {
            showPassworkList()
        }
    }
    
    private func showPassworkList() {
        self.navigationController?.pushViewController(JXListAllPasswordViewController(), animated: true)
    }
    
    private func editAction(didSelectRowAt indexPath: IndexPath) {
        let passwordSpaceViewController = JXPasswordSpaceViewController()
        passwordSpaceViewController.JXitemName = JXAppDelegate.data[indexPath[1]][0]
        passwordSpaceViewController.JXitemPassword = JXAppDelegate.data[indexPath[1]][1]
        passwordSpaceViewController.JXisNew = false
        passwordSpaceViewController.JXrow = indexPath[1]
        self.navigationController?.pushViewController(passwordSpaceViewController, animated: true)
    }

//MARK: - UI
    private func addTableView() {
        itemTableView = JXItemTableView(data:JXAppDelegate.data)
        view.addSubview(itemTableView)
        itemTableView.fullLayout()
    }
    
    private func addNavigationBarButton() {
        let menuButton = UIButton.convenient(title: "菜单", normalColor: UIColor.blue, highlightedColor: UIColor.gray, font: 18, action: #selector(menuButtonAction), target: self, tag: nil)
        menuButton.sizeToFit()
        let menuItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = menuItem
        
        let addButton = UIButton.convenient(title: "添加", normalColor: UIColor.blue, highlightedColor: UIColor.gray, font: 18, action: #selector(addButtonAction), target: self, tag: nil)
        addButton.sizeToFit()
        let addItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = addItem
    }
}
