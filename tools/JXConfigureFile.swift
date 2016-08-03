//
//  JXConfigureFile.swift
//  passwordManagement
//
//  Created by shanp on 16/8/3.
//  Copyright © 2016年 personal. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main().bounds.size.width
let screenHeight = UIScreen.main().bounds.size.height
let pictureWidth = screenWidth < 375 ? 320 : (screenWidth < 414 ? 375 : 414)
let scaleScreen = UIScreen.main().scale
let onePixel = (1 / scaleScreen)

let SPCurrentVersion = 1
let SPSystemVersion = UIDevice.current().systemVersion
