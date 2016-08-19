//
//  JXListAllPasswordTableView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/11.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

private class JXListAllPasswordTableViewCell: UITableViewCell {
    
    var itemLabel: UILabel!
    var originalPasswordLabel: UILabel!
    var userfulPasswordLabel: UILabel!
    
    convenience init(style: UITableViewCellStyle, identifier: String?) {
        self.init(style: style, reuseIdentifier: identifier)
        
        itemLabel = UILabel.convenient(title: "", titleColor: UIColor.color(withHexString: "#222222"), font: 16, tag: nil)
        self.addSubview(itemLabel)
        
        originalPasswordLabel = UILabel.convenient(title: "", titleColor: UIColor.color(withHexString: "#666666"), font: 16, tag: nil)
        self.addSubview(originalPasswordLabel)
        
        userfulPasswordLabel = UILabel.convenient(title: "", titleColor: UIColor.color(withHexString: "#999999"), font: 16, tag: nil)
        self.addSubview(userfulPasswordLabel)
        
        UIView.createHorizontalLine(supperView: self, left: 15, right: 0, isTop: (false, 0))
        
        itemLabel.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: 20).activeTrue()
        }
        
        originalPasswordLabel.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.centerYAnchor.constraint(equalTo: $0.superview!.centerYAnchor).activeTrue()
        }
        
        userfulPasswordLabel.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant:-20).activeTrue()
        }
    }
    
}

class JXListAllPasswordTableView: JXTableView, UITableViewDelegate, UITableViewDataSource {

    var didSelectRow: ((JXListAllPasswordTableView, IndexPath) -> Void)?
    var data: JXData!
    
    convenience init(data: JXData) {
        self.init(style: .plain)
        self.data = data
        self.set(delegate: self, dataSource: self)
        self.rowHeight = 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "JXTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? JXListAllPasswordTableViewCell
        if cell == nil {
            cell = JXListAllPasswordTableViewCell(style: .default, identifier: identifier)
        }
        cell!.itemLabel.text = "项       目：" + data[indexPath.row][0]
        cell!.originalPasswordLabel.text = "原始密码：" + data[indexPath.row][1]
        cell!.userfulPasswordLabel.text = "可用密码：" + data[indexPath.row][2]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let _didSelectRow = didSelectRow {
            _didSelectRow(tableView as! JXListAllPasswordTableView, indexPath)
        }
    }
    
}

//MARK: - headerAndFooter
extension JXListAllPasswordTableView {
    
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
