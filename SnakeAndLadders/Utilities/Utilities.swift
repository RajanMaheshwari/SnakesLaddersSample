//
//  Utilities.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 13/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    enum UIUserInterfaceIdiom : Int{
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize {
        static let screenWidth        = UIScreen.main.bounds.size.width
        static let screenHeight       = UIScreen.main.bounds.size.height
        static let screenMaxLength    = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
        static let screenMinLength    = min(ScreenSize.screenWidth, ScreenSize.screenHeight)
    }
    
    struct DeviceType {
        static let iPhone_4_4s  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength < 568.0
        static let iPhone_5_5c_5s_SE          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 568.0
        static let iPhone_6_7_8          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 667.0
        static let iPhone_6p_7p_8p         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 736.0
        static let iPhoneX              = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 812.0
        static let iPad              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.screenMaxLength == 1024.0
    }
    
    struct Version {
        static let systemVersion = (UIDevice.current.systemVersion as NSString).floatValue
        static let iOS7 = (Version.systemVersion < 8.0 && Version.systemVersion >= 7.0)
        static let iOS8 = (Version.systemVersion >= 8.0 && Version.systemVersion < 9.0)
        static let iOS9 = (Version.systemVersion >= 9.0 && Version.systemVersion < 10.0)
        static let iOS10 = (Version.systemVersion >= 10.0 && Version.systemVersion < 11.0)
        static let iOS11 = (Version.systemVersion >= 11.0 && Version.systemVersion < 12.0)
    }
    
    class func applicationDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }

}
