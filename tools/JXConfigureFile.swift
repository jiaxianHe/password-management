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

let JXCurrentVersion = 1
let JXSystemVersion = UIDevice.current().systemVersion

let JXBackgroundColor = "#efeff4"
let JXLineColor = "#dcdcdc"
