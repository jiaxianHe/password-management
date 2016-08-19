//
//  JXItemTableView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXItemTableView: JXTableView, UITableViewDelegate, UITableViewDataSource {

    var didSelectRow: ((JXItemTableView, IndexPath) -> Void)?
    var deleteRow: ((JXItemTableView, IndexPath) -> Void)?
    var data: JXData!
    
    convenience init(data: JXData) {
        self.init(style: .plain)
        self.data = data
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
        cell!.textLabel?.text = data[indexPath.row][0]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let _didSelectRow = didSelectRow {
            _didSelectRow(tableView as! JXItemTableView, indexPath)
        }
    }

}

//MARK: - edit
extension JXItemTableView {
    @objc(tableView:editActionsForRowAtIndexPath:) func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .default, title: "删除") { [weak self] (action, indexPath) in
            if let _deleteRow = self!.deleteRow {
                _deleteRow(tableView as! JXItemTableView, indexPath)
            }
        }
        return [action]
    }
}

//MARK: - headerAndFooter
extension JXItemTableView {
    
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
