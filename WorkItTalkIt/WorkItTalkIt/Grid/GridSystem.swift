//
//  GridSystem.swift
//  WorkItTalkIt
//
//  Created by 김수진 on 2022/06/14.
//

import UIKit

class DeviceInfo {
    static var devicePortraitWidth: CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        return min(width, height)
    }

    static var devicePortraitHeight: CGFloat {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        return max(width, height)
    }
}

class Grid {
    static let shared = Grid()
    private init() {}

    var unitSize: Int {
        switch DeviceInfo.devicePortraitWidth {
        case ...768: return 120
        case 810: return 124
        case 834:
            switch DeviceInfo.devicePortraitHeight {
            case 1112: return 132
            case 1194: return 136
            default: return 136
            }
        case 820: return 136
        case 1024...: return 160
        default: return 136
        }
    }

    var unitSpace: Int {
        switch DeviceInfo.devicePortraitWidth {
        case ...768: return 20
        case 810: return 24
        case 834:
            switch DeviceInfo.devicePortraitHeight {
            case 1112: return 24
            case 1194: return 28
            default: return 28
            }
        case 820: return 28
        case 1024...: return 36
        default: return 28
        }
    }

}
