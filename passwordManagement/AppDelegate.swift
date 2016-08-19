//
//  AppDelegate.swift
//  passwordManagement
//
//  Created by shanp on 16/7/29.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit
import LocalAuthentication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var isCanUseFingerprint: Bool {
        get {
            var error: NSError?
            let verification = LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            if !verification && error?.code == LAError.touchIDNotAvailable.rawValue {
                return false
            }
            return true
        }
    }
    var data: JXData!
    private let keychain = KeychainSwift()
    
    var window: UIWindow?
    private var _rootViewController = JXNavigationViewController(rootViewController:JXItemViewController())


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.main().bounds)
        getUserData()
        
        window?.rootViewController = _rootViewController
        window?.backgroundColor = UIColor.white()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func getUserData() {
        
        if let isNeedToProtect = UserDefaults.standard.object(forKey: "JXisNeedToProtect") as? NSNumber {
            JXisNeedToProtect = isNeedToProtect.boolValue
        }
        else {
            UserDefaults.standard.set(NSNumber(value: 1), forKey: "JXisNeedToProtect")
            JXisNeedToProtect = true
        }
        if let passwordData = keychain.getData(JXkeychainKey), let passwordDic = NSKeyedUnarchiver.unarchiveObject(with: passwordData) {
            JXpasswordRange = (passwordDic[JXpasswordRangeKey]) as! Array<[Int]>
            data = (passwordDic[JXDataKey]) as! Array<[String]>
            JXprotectPassword = (passwordDic[JXprotectPasswordKey]) as! Array<Int>
        }
        else {
            data = []
            JXpasswordRange = [[0, 12]]
            JXprotectPassword = [0, 0, 0, 0, 0, 0]
            saveData()
        }
//        data = [["QQ", "123456", "51532b362582c2bb6e", "md5"], ["WW", "123456", "51532b362582c2bb6e", "md5"], ["EE", "123456", "51532b362582c2bb6e", "md5"], ["RR", "123456", "51532b362582c2bb6e", "md5"], ["TT", "123456", "51532b362582c2bb6e", "md5"]]
        
    }
    
    func saveData() {
        let passwordData = NSKeyedArchiver.archivedData(withRootObject: [JXDataKey: data, JXpasswordRangeKey: JXpasswordRange, JXprotectPasswordKey: JXprotectPassword] as NSDictionary)
        let isSuccess = keychain.set(passwordData, forKey: JXkeychainKey)
        if !isSuccess {
            saveData()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

