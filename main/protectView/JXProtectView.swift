//
//  JXProtectView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/5.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXProtectView: UIView {
    
    let cancelButton = UIButton.convenient(title: "取消", normalColor: UIColor.blue, highlightedColor: UIColor.gray, font: 16, action: nil, target: nil, tag: nil)
    var fingerprintButton: UIButton?
    var codeNumber: ((UIButton) -> Void)?
    private let numberButtonBackgroundView = UIView()
    private let codeIdentifyBackgroundView = UIView()
    private var centerXConstraint: NSLayoutConstraint!
    private let titleLabel = UILabel.convenient(title: "", titleColor: UIColor.blue, font: 16, tag: nil, textAlignment: .center)
    var title: String {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text!
        }
    }
    
    convenience init(isCanUseFingerprint: Bool) {
        self.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white
        addNumberButton()
        addFingerprintAndCancelButton(isCanUseFingerprint: isCanUseFingerprint)
        addCodeIdentify()
        self.addSubview(titleLabel)
        titleLabel.layout { [weak self] in
            $0.centerXAnchor.constraint(equalTo: $0.superview!.centerXAnchor).activeTrue()
            $0.bottomAnchor.constraint(equalTo: self!.codeIdentifyBackgroundView.topAnchor, constant: -20).activeTrue()
        }
    }
    
    private func addFingerprintAndCancelButton(isCanUseFingerprint: Bool) {
        self.addSubview(cancelButton)
        cancelButton.layout {
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: -20).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -20).activeTrue()
            $0.layoutSize(size: CGSize(width: 100, height: 30))
        }
        
        if isCanUseFingerprint {
            fingerprintButton = UIButton.convenient(title: "使用指纹", normalColor: UIColor.blue, highlightedColor: UIColor.gray, font: 16, action: nil, target: nil, tag: nil)
            self.addSubview(fingerprintButton!)
            fingerprintButton?.layout {
                $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: -20).activeTrue()
                $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 20).activeTrue()
                $0.layoutSize(size: CGSize(width: 100, height: 30))
            }
        }
    }
    
//MARK: - NumberButton
    private func addNumberButton() {
        //        numberButtonBackgroundView.backgroundColor = UIColor.red()
        self.addSubview(numberButtonBackgroundView)
        numberButtonBackgroundView.layout {
            $0.leftAnchor.constraint(equalTo: $0.superview!.leftAnchor, constant: 20).activeTrue()
            $0.rightAnchor.constraint(equalTo: $0.superview!.rightAnchor, constant: -20).activeTrue()
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).activeTrue()
            $0.layoutOnCenter()
        }
        
        var tempButton: UIButton?
        for No in 0..<9 {
            let button = UIButton.convenient(title: String(No + 1), normalColor: UIColor.blue, highlightedColor: UIColor.gray, font: 32, action: #selector(codeNumberAction), target: self, tag: 2001 + No)
            numberButtonBackgroundView.addSubview(button)
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
        
        let zeroButton = UIButton.convenient(title: "0", normalColor: UIColor.blue, highlightedColor: UIColor.gray, font: 32, action: #selector(codeNumberAction), target: self, tag: 2000)
        self.addSubview(zeroButton)
        zeroButton.layout { [weak self] in
            $0.topAnchor.constraint(equalTo: self!.numberButtonBackgroundView.bottomAnchor).activeTrue()
            $0.centerXAnchor.constraint(equalTo: $0.superview!.centerXAnchor).activeTrue()
            $0.widthAnchor.constraint(equalTo: self!.numberButtonBackgroundView.widthAnchor, multiplier: 0.33).activeTrue()
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).activeTrue()
        }
        
    }
    
    @objc private func codeNumberAction(sender: UIButton) {
        if let _codeNumber = codeNumber {
            _codeNumber(sender)
        }
    }
    
//MARK: - CodeIdentify
    private func addCodeIdentify() {
        self.addSubview(codeIdentifyBackgroundView)
        centerXConstraint = codeIdentifyBackgroundView.centerXAnchor.constraint(equalTo: codeIdentifyBackgroundView.superview!.centerXAnchor)
        codeIdentifyBackgroundView.layout { [weak self] in
            self!.centerXConstraint.activeTrue()
            $0.bottomAnchor.constraint(equalTo: self!.numberButtonBackgroundView.topAnchor, constant: -10).activeTrue()
            $0.layoutSize(size: CGSize(width: 210, height: 20))
        }
        
        for No in 0..<6 {
            let circleView = JXCircleView(lineWidth: 1, color: UIColor.red, mode: .stroke)
            circleView.tag = 2000 + No
            circleView.frame = CGRect(x: 40 * No, y: 5, width: 10, height: 10)
            codeIdentifyBackgroundView.addSubview(circleView)
        }
    }
    
    func inAcode(number: Int) {
        if number >= 0 && number <= 5{
            let circleView = codeIdentifyBackgroundView.viewWithTag(2000 + number) as! JXCircleView
            circleView.mode = .fillStroke
            circleView.setNeedsDisplay()
        }
    }
    
    func outAcode(number: Int) {
        if number >= 0 && number <= 5 {
            let circleView = codeIdentifyBackgroundView.viewWithTag(2000 + number) as! JXCircleView
            circleView.mode = .stroke
            circleView.setNeedsDisplay()
        }
    }
    
    func codeIdentifyShake(completion:@escaping () -> Void) {
        UIView.animate(withDuration: 0.05, animations: {
            self.centerXConstraint.constant += 20
            self.codeIdentifyBackgroundView.layoutIfNeeded()
            }, completion:nil)
        UIView.animate(withDuration: 0.1, delay: 0.05, options: [], animations: {
            self.centerXConstraint.constant -= 40
            self.codeIdentifyBackgroundView.layoutIfNeeded()
            }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.15, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: [], animations: {
            self.centerXConstraint.constant += 20
            self.codeIdentifyBackgroundView.layoutIfNeeded()
        }) { (finish) in
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    deinit {
        let className = NSStringFromClass(type(of: self))
        debugLog("deinit------" + className)
    }
}
