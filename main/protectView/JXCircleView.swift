//
//  JXCircleView.swift
//  passwordManagement
//
//  Created by shanp on 16/8/9.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

class JXCircleView: UIView {

    private var lineWidth: CGFloat
    private var color: UIColor
    var mode: CGPathDrawingMode
    
    init(lineWidth: CGFloat, color: UIColor, mode: CGPathDrawingMode) {
        self.lineWidth = lineWidth
        self.color = color
        self.mode = mode
        super.init(frame:CGRect.zero)
        self.backgroundColor = UIColor.white()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        if let _context = context {
            _context.setStrokeColor(color.cgColor)
            _context.setFillColor(color.cgColor)
            _context.setLineWidth(lineWidth)
            _context.addArc(centerX: rect.size.width / 2, y: rect.size.height / 2, radius: rect.size.width / 2 - lineWidth, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: 0)
            _context.drawPath(using: mode)
        }
        
    }
    
    deinit {
        let className = NSStringFromClass(self.dynamicType)
        debugLog("deinit------" + className)
    }

}
