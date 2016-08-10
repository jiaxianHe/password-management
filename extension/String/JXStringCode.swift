//
//  JXStringCode.swift
//  passwordManagement
//
//  Created by shanp on 16/8/10.
//  Copyright © 2016年 personal. All rights reserved.
//

import Foundation

extension String {
    
    var md5: String {
        let strData = JXutf8String()
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        
        CC_MD5(strData.0, strData.1, result)
        
        return JXgetHashRest(digestLen: digestLen, result: result)
    }
    
    var sha1: String {
        let strData = JXutf8String()
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        
        CC_SHA1(strData.0, strData.1, result)
        
        return JXgetHashRest(digestLen: digestLen, result: result)
    }
    
    var sha224: String {
        let strData = JXutf8String()
        let digestLen = Int(CC_SHA224_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        
        CC_SHA224(strData.0, strData.1, result)
        
        return JXgetHashRest(digestLen: digestLen, result: result)
    }
    
    var sha256: String {
        let strData = JXutf8String()
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        
        CC_SHA256(strData.0, strData.1, result)
        
        return JXgetHashRest(digestLen: digestLen, result: result)
    }
    
    var sha384: String {
        let strData = JXutf8String()
        let digestLen = Int(CC_SHA384_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        
        CC_SHA384(strData.0, strData.1, result)
        
        return JXgetHashRest(digestLen: digestLen, result: result)
    }
    
    var sha512: String {
        let strData = JXutf8String()
        let digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>(allocatingCapacity: digestLen)
        
        CC_SHA512(strData.0, strData.1, result)
        
        return JXgetHashRest(digestLen: digestLen, result: result)
    }
    
    private func JXutf8String() -> ([CChar]?, CC_LONG) {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        return (str, strLen)
    }
    
    private func JXgetHashRest(digestLen: Int, result: UnsafeMutablePointer<CUnsignedChar>) -> String {
        let hash = NSMutableString(capacity: digestLen * 2)
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocateCapacity(digestLen)
        
        return String(format: hash as String)
    }
    
}
