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
    
    private class func getKeychainQuery(service: String) -> Dictionary<String, AnyObject> {
        //    return Dictionary(objects: [kSecClassGenericPassword as String, service, service,kSecAttrAccessibleAfterFirstUnlock as String], forKeys: [kSecClass as String, kSecAttrService as String, kSecAttrAccount as String, kSecAttrAccessible as String])
        return [kSecClass as String: kSecClassGenericPassword as String, kSecAttrService as String: service, kSecAttrAccount as String: service, kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock as String]
    }
    
    class func save(service: String, data: AnyObject) {
        var keychainQuery = getKeychainQuery(service: service)
        SecItemDelete(keychainQuery as CFDictionary)
        keychainQuery[kSecValueData as String] = NSKeyedArchiver.archivedData(withRootObject: data)
        let test = SecItemAdd(keychainQuery as CFDictionary, nil)
        debugLog(test)
    }
    
    class func load(service: String) -> AnyObject? {
        var ret: AnyObject?
        var keychainQuery = getKeychainQuery(service: service)
        keychainQuery[kSecReturnData as String] = kCFBooleanTrue
        keychainQuery[kSecMatchLimit as String] = kSecMatchLimitOne
        var keyData: CFTypeRef?
        let test = SecItemCopyMatching(keychainQuery as CFDictionary, &keyData)
        debugLog(test)
        if SecItemCopyMatching(keychainQuery as CFDictionary, &keyData) == noErr {
            ret = NSKeyedUnarchiver.unarchiveObject(with: keyData as! Data)
        }
        return ret
    }
    
    class func delete(service: String) {
        let keychainQuery = getKeychainQuery(service: service)
        SecItemDelete(keychainQuery as CFDictionary)
    }
    
}






