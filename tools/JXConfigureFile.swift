//
//  JXConfigureFile.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

typealias JXData = Array<[String]>
let JXAppDelegate = UIApplication.shared.delegate as! AppDelegate

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let scaleScreen = UIScreen.main.scale
let onePixel = (1 / scaleScreen)

let JXCurrentVersion = 1
let JXSystemVersion = UIDevice.current.systemVersion

let JXBackgroundColor = "#efeff4"
let JXLineColor = "#dcdcdc"

var JXIsNeedToRefreshItemView = false
