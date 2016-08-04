//
//  JXItemTableView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXItemTableView: JXTableView, UITableViewDelegate, UITableViewDataSource {

    var didSelectRow: ((UITableView,IndexPath) -> Void)?
    
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
            UIView.createHorizontalLine(supperView: cell!.contentView, left: 15, right: 0, isTop: (false, 0))
        }
        cell?.textLabel?.text = "abc"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let value = didSelectRow {
            value(tableView, indexPath)
        }
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
