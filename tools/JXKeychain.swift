//
//  JXKeyChain.swift
//  passwordManagement
//
//  Created by shanp on 16/8/4.
//  Copyright © 2016年 personal. All rights reserved.
//

import Foundation
import Security

class JXKeychain {
    
    private class func getKeychainQuery(service: NSString) -> NSMutableDictionary {
        //    return Dictionary(objects: [kSecClassGenericPassword as String, service, service,kSecAttrAccessibleAfterFirstUnlock as String], forKeys: [kSecClass as String, kSecAttrService as String, kSecAttrAccount as String, kSecAttrAccessible as String])
//        return [kSecClass: kSecClassGenericPassword, kSecAttrService as String: service, kSecAttrAccount as String: service, kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock as String]
//        return NSMutableDictionary(objects: [kSecClassGenericPassword as NSString, service, service,kSecAttrAccessibleAfterFirstUnlock as NSString], forKeys: [kSecClass as NSString, kSecAttrService as NSString, kSecAttrAccount as NSString, kSecAttrAccessible as NSString])
        let keyChainItem = NSMutableDictionary()
        keyChainItem.setObject(kSecClassInternetPassword as NSString, forKey: kSecClass as NSString)
        keyChainItem.setObject(service, forKey:  kSecAttrServer as NSString)
        keyChainItem.setObject(service, forKey: kSecAttrAccount as NSString)
        return keyChainItem
    }
    
    class func save(service: NSString, data: NSString) {
        let keychainQuery = getKeychainQuery(service: service)
        debugLog(keychainQuery)
        SecItemDelete(keychainQuery)
        keychainQuery[kSecValueData as NSString] = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true)
        let test = SecItemAdd(keychainQuery, nil)
        debugLog(test)
    }
    
    class func load(service: NSString) -> AnyObject? {
        var ret: AnyObject?
        let keychainQuery = getKeychainQuery(service: service)
        keychainQuery[kSecReturnData as NSString] = kCFBooleanTrue
        keychainQuery[kSecMatchLimit as NSString] = kSecMatchLimitOne
        var keyData: CFTypeRef?
        let test = SecItemCopyMatching(keychainQuery as CFDictionary, &keyData)
        debugLog(test)
        if SecItemCopyMatching(keychainQuery as CFDictionary, &keyData) == noErr {
            ret = NSKeyedUnarchiver.unarchiveObject(with: keyData as! Data)
        }
        return ret
    }
    
    class func delete(service: NSString) {
        let keychainQuery = getKeychainQuery(service: service)
        SecItemDelete(keychainQuery as CFDictionary)
    }
    
}






