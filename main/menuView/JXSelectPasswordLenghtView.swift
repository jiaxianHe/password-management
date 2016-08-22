//
//  JXSelectPasswordLenghtView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/18.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXSelectPasswordLenghtView: UIView {
    
    private enum seletStatus {
        case select, deselect, noStatus
    }
    
    var selected: Array<Int>!
    private var selectedStatus = seletStatus.noStatus
    private let width = screenWidth - 40
    private let singleWidth = (screenWidth - 40) / 8

    convenience init(selectedArray: Array<Int>) {
        self.init(frame:CGRect.zero)
        selected = selectedArray
        var tempLabel: UILabel? = nil
        for index in 0 ..< 32 {
            let label = UILabel.convenient(title: String(index + 1), titleColor: UIColor.color(withHexString: "#222222"), font: 16, tag: 2000 + index, textAlignment: .center)
            label.fillet(cornerRadius: nil, borderWidth: onePixel, borderColor: UIColor.color(withHexString: "#666666"))
            if selected.contains(index) {
                label.backgroundColor = UIColor.gray
            }
            else {
                label.backgroundColor = UIColor.white
            }
            self.addSubview(label)
            label.layout { [weak self] in
                if index % 8 == 0 {
                    $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor).activeTrue()
                    if tempLabel != nil {
                        $0.topAnchor.constraint(equalTo: tempLabel!.bottomAnchor).activeTrue()
                    }
                    else {
                        $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor).activeTrue()
                    }
                }
                else {
                    $0.leftAnchor.constraint(equalTo: tempLabel!.rightAnchor, constant: 0).activeTrue()
                    $0.topAnchor.constraint(equalTo: tempLabel!.topAnchor).activeTrue()
                }
                if index % 8 == 7 {
                    $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor).activeTrue()
                }
                if index / 8 == 3 {
                    $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor).activeTrue()
                }
                $0.widthAnchor.constraint(equalToConstant: self!.singleWidth).activeTrue()
                $0.heightAnchor.constraint(equalTo: $0.widthAnchor).activeTrue()
            }
            tempLabel = label
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        debugLog("begin")
        
        if  let point = touches.first?.location(in: self) {
            guard point.x > 0 && point.x < width && point.y > 0 && point.y < width / 2 else {
                return
            }
            let tag = 8 * Int(point.y / singleWidth) + Int(point.x / singleWidth)
            let label = self.viewWithTag(2000 + tag) as! UILabel
            if selected.contains(tag) {
                selectedStatus = .deselect
                selected.remove(at: selected.index(of: tag)!)
                label.backgroundColor = UIColor.white
            }
            else {
                selectedStatus = .select
                selected.append(tag)
                label.backgroundColor = UIColor.gray
            }
        }
        
//        debugLog(touches.first?.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        debugLog("move")
        if  let point = touches.first?.location(in: self) {
            guard point.x > 0 && point.x < width && point.y > 0 && point.y < width / 2 else {
//                debugLog("越界")
                return
            }
            let tag = 8 * Int(point.y / singleWidth) + Int(point.x / singleWidth)
            if selectedStatus == .select {
                if !selected.contains(tag) {
                    selected.append(tag)
                    let label = self.viewWithTag(2000 + tag) as! UILabel
                    label.backgroundColor = UIColor.gray
                }
            }
            else if selectedStatus == .deselect {
                if selected.contains(tag) {
                    selected.remove(at: selected.index(of: tag)!)
                    let label = self.viewWithTag(2000 + tag) as! UILabel
                    label.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        debugLog("end")
        selectedStatus = .noStatus
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        debugLog("cancel")
        selectedStatus = .noStatus
    }
    
    deinit {
        let className = NSStringFromClass(type(of: self))
        debugLog("deinit------" + className)
    }
}
