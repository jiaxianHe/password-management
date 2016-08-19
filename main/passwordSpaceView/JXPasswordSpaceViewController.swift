//
//  JXPasswordSpaceViewController.swift
//  passwordManagement
//
//  Created by shanp on 16/8/15.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXPasswordSpaceViewController: UIViewController {

    var JXitemName: String!
    var JXitemPassword: String!
    var JXisNew: Bool!
    var JXrow: Int!
    private var originalPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "密码空间"
        self.view.backgroundColor = UIColor.white()
        addItmeView()
        addButtons()
    }
    
    @objc private func buttonAction(sender: UIButton) {
        if JXisNeedToProtect {
            let protectViewController = JXProtectViewController()
            protectViewController.verificationResults = { [weak self] (finish) in
                self!.getUserfulPassword(tag: sender.tag - 2000)
            }
            self.present(protectViewController, animated: true, completion: nil)
        }
        else {
            getUserfulPassword(tag: sender.tag - 2000)
        }
    }
    
    private func getUserfulPassword(tag: Int) {
        let selectorArray = ["ns_md5", "ns_sha1", "ns_sha224", "ns_sha256", "ns_sha384", "ns_sha512"]
        let selector = NSSelectorFromString(selectorArray[tag])
        if let result = (JXitemPassword as NSString).perform(selector).takeUnretainedValue() as? String {
            debugLog(result)
            var password: String = ""
            for resultArray in JXpasswordRange {
                let range = Range(uncheckedBounds: (result.index(result.startIndex, offsetBy: resultArray[0]),result.index(result.startIndex, offsetBy: resultArray[1])))
                let tempString = result.substring(with: range)
                password.append(tempString)
            }
            showAlertViewWith(title: "你的密码", message: password, alertAction: UIAlertAction(title: "保存", style: .default, handler: { [weak self] (action) in
                self!.save(password: password, selector: selectorArray[tag])
                self!.navigationController!.popToRootViewController(animated: true)
            }), UIAlertAction(title: "保存并复制", style: .default, handler: { [weak self] (action) in
                self!.save(password: password, selector: selectorArray[tag])
                let pasteboard = UIPasteboard.general()
                pasteboard.string = password
                self!.navigationController!.popToRootViewController(animated: true)
            }), UIAlertAction(title: "取消", style: .cancel, handler: nil))
            
            debugLog(password)
        }
        else {
            showAlertViewWith(title: "提示", message: "生成可用密码失败", alertAction: UIAlertAction(title: "确定", style: .default, handler: nil))
        }
    }
    
    private func save(password: String, selector: String) {
        if JXisNew! {
            JXAppDelegate.data.append([JXitemName, JXitemPassword, password, selector])
            JXIsNeedToRefreshItemView = true
        }
        else {
            JXAppDelegate.data.remove(at: JXrow)
            JXAppDelegate.data.insert([JXitemName, JXitemPassword, password, selector], at: JXrow)
        }
        DispatchQueue.global().async {
            JXAppDelegate.saveData()
        }
    }

}

extension JXPasswordSpaceViewController {
    
    private func addItmeView() {
        let itemLabel = UILabel.convenient(title: "项目名称：" + JXitemName, titleColor: UIColor.color(withHexString: "#222222"), font: 16, tag: nil)
        self.view.addSubview(itemLabel)
        
        originalPasswordLabel = UILabel.convenient(title: "原始密码：" + JXitemPassword, titleColor: UIColor.color(withHexString: "#666666"), font: 16, tag: nil)
        self.view.addSubview(originalPasswordLabel)
        
        itemLabel.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: 64 + 20).activeTrue()
        }
        
        originalPasswordLabel.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
            $0.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 15).activeTrue()
        }
    }
    
    private func addButtons() {
        let titleArray = ["东邪", "西毒", "南帝", "北丐", "中神通", "周伯通"]
        for index in 0 ..< 6 {
            let button = UIButton.convenient(title: titleArray[index], normalColor: UIColor.red(), highlightedColor: UIColor.blue(), font: 20, action: #selector(buttonAction), target: self, tag: 2000 + index)
            button.fillet(cornerRadius: 5, borderWidth: onePixel, borderColor: UIColor.color(withHexString: "#666666"))
            self.view.addSubview(button)
            button.layout { [weak self] in
                $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 15).activeTrue()
                $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -15).activeTrue()
                $0.topAnchor.constraint(equalTo: self!.originalPasswordLabel.bottomAnchor, constant: CGFloat( 10 + 55 * index)).activeTrue()
                $0.heightAnchor.constraint(equalToConstant: 40).activeTrue()
            }
        }
    }
}
