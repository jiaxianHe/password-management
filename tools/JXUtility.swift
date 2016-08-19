//
//  JXUtility.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

//MARK: - debug输出
func debugLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}

//MARK: - 大图片用的方法
func JXimagePathWithName(_ name : String) -> UIImage? {
    guard let path = Bundle.main.pathForResource(name, ofType: "png") else {
        return nil
    }
    return UIImage(contentsOfFile: path)
}

//MARK: - 删除两端空格
func JXdeleteSpaceOnBothEnds(string: String?) -> String {
    guard var _string = string else {
        return ""
    }
    let regTags = "^ *| *$"
    do {
        let regex = try RegularExpression(pattern: regTags, options: [.caseInsensitive])
        let matches = regex.matches(in: _string, options: [.reportProgress], range: NSMakeRange(0, _string.characters.count))
        for result in matches.reversed() {
            guard result.range.length != 0 else {
                continue
            }
            let start = _string.index(_string.startIndex, offsetBy: result.range.location)
            let end = _string.index(start, offsetBy: result.range.length)
            _string.removeSubrange(Range(uncheckedBounds: (start, end)))
        }
        return _string
    }
    catch {
        return ""
    }
}

//MARK: - NSDateFormatter单例
class JXDateFormatter: Foundation.DateFormatter {
    static let sharedDateFormatter = DateFormatter()
    private override init() {
        super.init()
        self.locale = Locale(localeIdentifier: "zh_CN")
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UIColor16进制
extension UIColor {
    class func color(withHexString string: String, alpha: CGFloat) -> UIColor {
        var cString = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        guard cString.characters.count >= 6 else {
            return UIColor.clear()
        }
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        guard cString.characters.count == 6 else {
            return UIColor.clear()
        }

        var range = cString.index(cString.startIndex, offsetBy: 0) ..< cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(with: range)
        range = cString.index(cString.startIndex, offsetBy: 2) ..< cString.index(cString.startIndex, offsetBy: 4)
        let gString = cString.substring(with: range)
        range = cString.index(cString.startIndex, offsetBy: 4) ..< cString.index(cString.startIndex, offsetBy: 6)
        let bString = cString.substring(with: range)
        //        print(rString,"------",gString, "-----",bString)
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //        print(r, "-------", g, "--------", b)
        return UIColor(red: CGFloat(r) / CGFloat(255), green: CGFloat(g) / CGFloat(255), blue: CGFloat(b) / CGFloat(255), alpha: alpha)
    }
    
    class func color(withHexString string: String) -> UIColor {
        return color(withHexString: string, alpha: CGFloat(1))
    }
}
