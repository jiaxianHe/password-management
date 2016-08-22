//
//  JXCircleView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/9.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXCircleView: UIView {

    private var lineWidth: CGFloat!
    private var color: UIColor!
    var mode: CGPathDrawingMode!
    
    convenience init(lineWidth: CGFloat, color: UIColor, mode: CGPathDrawingMode) {
        self.init(frame:CGRect.zero)
        self.lineWidth = lineWidth
        self.color = color
        self.mode = mode
        self.backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        if let _context = context {
            _context.setStrokeColor(color.cgColor)
            _context.setFillColor(color.cgColor)
            _context.setLineWidth(lineWidth)
            _context.addArc(center: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2), radius: rect.size.width / 2 - lineWidth, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
            _context.drawPath(using: mode)
        }
    }
    
    deinit {
        let className = NSStringFromClass(type(of: self))
        debugLog("deinit------" + className)
    }

}
