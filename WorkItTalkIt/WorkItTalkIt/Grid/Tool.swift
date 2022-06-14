//
//  Tool.swift
//  WorkItTalkIt
//
//  Created by 김수진 on 2022/06/14.
//

import UIKit

enum ToolSize: CaseIterable {
    case small
    case medium
    case large
    case extraLong
    case extraWide
    case king

    var row: Int {
        switch self {
        case .small: return 1
        case .medium: return 1
        case .large: return 2
        case .extraLong: return 4
        case .extraWide: return 2
        case .king: return 4
        }
    }

    var col: Int {
        switch self {
        case .small: return 1
        case .medium: return 2
        case .large: return 2
        case .extraLong: return 2
        case .extraWide: return 4
        case .king: return 4
        }
    }
}

class ToolView: UIView {
    var size: ToolSize
    var width: Int {
        return size.col * Grid.shared.unitSize + (size.col - 1) * Grid.shared.unitSpace
    }
    var height: Int {
        return size.row * Grid.shared.unitSize + (size.row - 1) * Grid.shared.unitSpace
    }

    override init(frame: CGRect) {
        size = .small
        super.init(frame: frame)
    }

    convenience init(size: ToolSize) {
        self.init(frame: .zero)
        self.size = size

        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }

}
