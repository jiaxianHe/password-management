//
//  JXTableView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXTableView: UITableView {
    
    init(style: UITableViewStyle) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: style)
        self.separatorStyle = .none;
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = UIColor.color(withHexString: JXBackgroundColor)
    }
    
    func set(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        let className = NSStringFromClass(type(of: self))
        debugLog("deinit------" + className)
    }

}
