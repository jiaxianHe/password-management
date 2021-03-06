//
//  JXMenuTableView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/17.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXMenuTableView: JXTableView, UITableViewDelegate, UITableViewDataSource {

    var didSelectRow: ((JXMenuTableView, IndexPath) -> Void)?
    let titleArray = ["密码位数", "修改保护密码"]
    
    convenience init() {
        self.init(style: .plain)
        self.set(delegate: self, dataSource: self)
        self.rowHeight = 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JXTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            UIView.createHorizontalLine(supperView: cell!, left: 15, right: 0, isTop: (false, 0))
        }
        cell!.textLabel?.text = titleArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let _didSelectRow = didSelectRow {
            _didSelectRow(tableView as! JXMenuTableView, indexPath)
        }
    }

}

//MARK: - headerAndFooter
extension JXMenuTableView {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return onePixel
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.createLine()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return onePixel
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        UIView.createHorizontalLine(supperView: footer, left: 0, right: 0, isTop: (false, -onePixel))
        return footer
    }
    
}
