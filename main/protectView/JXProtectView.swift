//
//  JXProtectView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/5.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXProtectView: UIView {
    
    let cancelButton = UIButton.convenient(withTitle: "取消", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 16, action: nil, target: nil, tag: nil)
    var fingerprintButton: UIButton?
    var codeNumber: ((UIButton) -> Void)?
    
    convenience init() {
        self.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white()
        addNumberButton()
        addFingerprintAndCancelButton()
    }
    
    private func addNumberButton() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.red()
        self.addSubview(backgroundView)
        backgroundView.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 20).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -20).activeTrue()
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).activeTrue()
            $0.layoutOnCenter()
        }
        
        var tempButton: UIButton?
        for No in 0..<9 {
            let button = UIButton.convenient(withTitle: String(No + 1), normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 32, action: #selector(codeNumberAction), target: self, tag: 2001 + No)
            backgroundView.addSubview(button)
            button.layout {
                if No % 3 == 0 {
                    $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor).activeTrue()
                    if let _tempButton = tempButton {
                        $0.topAnchor.constraint(equalTo: _tempButton.bottomAnchor).activeTrue()
                    }
                    else {
                        $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor).activeTrue()
                    }
                }
                else {
                    $0.leftAnchor.constraint(equalTo: tempButton!.rightAnchor).activeTrue()
                    $0.topAnchor.constraint(equalTo: tempButton!.topAnchor).activeTrue()
                }
                if No % 3 == 2 {
                    $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor).activeTrue()
                }
                if No / 3 == 2 {
                    $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor).activeTrue()
                }
                if let _tempButton = tempButton {
                    $0.widthAnchor.constraint(equalTo: _tempButton.widthAnchor).activeTrue()
                    $0.heightAnchor.constraint(equalTo: _tempButton.heightAnchor).activeTrue()
                }
            }
            tempButton = button
        }
        
        let zeroButton = UIButton.convenient(withTitle: "0", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 32, action: #selector(codeNumberAction), target: self, tag: 2000)
        self.addSubview(zeroButton)
        zeroButton.layout {
            $0.topAnchor.constraint(equalTo: backgroundView.bottomAnchor).activeTrue()
            $0.centerXAnchor.constraint(equalTo: $0.superview!.centerXAnchor).activeTrue()
            $0.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.33).activeTrue()
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).activeTrue()
        }
        
    }
    
    @objc private func codeNumberAction(sender: UIButton) {
        if let value = codeNumber {
            value(sender)
        }
    }
    
    private func addFingerprintAndCancelButton() {
        self.addSubview(cancelButton)
        cancelButton.layout {
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: -20).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -20).activeTrue()
            $0.layoutSize(size: CGSize(width: 100, height: 30))
        }
        
//        if JXAppDelegate.isCanUseFingerprint {
            fingerprintButton = UIButton.convenient(withTitle: "使用指纹", normalColor: UIColor.blue(), highlightedColor: UIColor.gray(), font: 16, action: nil, target: nil, tag: nil)
            self.addSubview(fingerprintButton!)
            fingerprintButton?.layout {
                $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: -20).activeTrue()
                $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 20).activeTrue()
                $0.layoutSize(size: CGSize(width: 100, height: 30))
            }
//        }
    }

    deinit {
        let className = NSStringFromClass(self.dynamicType)
        debugLog("deinit------" + className)
    }
}
