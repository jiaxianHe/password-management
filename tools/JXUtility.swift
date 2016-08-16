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
func imagePathWithName(_ name : String) -> UIImage? {
    guard let path = Bundle.main.pathForResource(name, ofType: "png") else {
        return nil
    }
    return UIImage(contentsOfFile: path)
}

//MARK: - 删除两端空格
func deleteSpaceOnBothEnds(string: String) -> String {
    let regTags = "^ *| *$"
    do {
        let regex = try RegularExpression(pattern: regTags, options: [.caseInsensitive])
        var _string = string
        let matches = regex.matches(in: _string, options: [.reportProgress], range: NSMakeRange(0, _string.characters.count))
        for result in matches.reversed() {
            _string.remove(at: _string.index(_string.startIndex, offsetBy: result.range.length))
        }
        return _string
    }
    catch {
        return ""
    }
    
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:nil];
//    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
//    for (NSInteger i = [matches count]; i > 0; i --)
//    {
//        NSTextCheckingResult *result = [matches objectAtIndex:i - 1];
//        [str deleteCharactersInRange:result.range];
//    }
}

//MARK: - NSDateFormatter单例
class DateFormatter: Foundation.DateFormatter {
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
