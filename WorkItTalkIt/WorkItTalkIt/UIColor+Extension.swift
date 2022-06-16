//
//  UIColor+Extension.swift
//  WorkItTalkIt
//
//  Created by Somin Park on 2022/06/16.
//
import UIKit

enum AssetsColor {
    case sidebarColor
    case modalViewColor
    case boardColor
    case mainColor
    case selectedYellowColor
    case disabledGrayColor
    case storageAreaColor
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .sidebarColor:
            return UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.9)
        case .modalViewColor:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        case .boardColor:
            return UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        case .mainColor:
            return UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1)
        case .selectedYellowColor:
            return UIColor(red: 247/255, green: 207/255, blue: 116/255, alpha: 1)
        case .disabledGrayColor:
            return UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1)
        case .storageAreaColor:
            return UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        }
    }
}
