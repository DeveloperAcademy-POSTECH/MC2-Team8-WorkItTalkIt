//
//  AllToolSizeView.swift
//  WorkItTalkIt
//
//  Created by Yu ahyeon on 2022/06/13.
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

    @IBOutlet var tool: UIView!
    @IBOutlet var toolDeleteButton: UIButton!

    var size: ToolSize = .small
    var width: Int {
        return size.col * Grid.shared.unitSize + (size.col - 1) * Grid.shared.unitSpace
    }
    var height: Int {
        return size.row * Grid.shared.unitSize + (size.row - 1) * Grid.shared.unitSpace
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    convenience init(size: ToolSize) {
        self.init(frame: .zero)
        self.size = size

        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }

    var isEditMode = false {
        didSet {
            if isEditMode == true {
                playEditModeToolAnimation()
                toolDeleteButton.isHidden = false
            } else {
                toolDeleteButton.isHidden = true
            }
        }
    }
    let nibName = "ToolView"

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        toolDeleteButton.isHidden = true
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func setToolShadow() {
        tool.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        tool.layer.shadowColor = CGColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        tool.layer.shadowOffset = CGSize(width: 3, height: 3)
        tool.layer.shadowOpacity = 0.3
        tool.layer.shadowRadius = 10.0
    }

    func playEditModeToolAnimation () {
        let editModeToolAnimation = CAKeyframeAnimation(keyPath: "transform")
        editModeToolAnimation.values = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0, 0, 1)),
                                        NSValue(caTransform3D: CATransform3DMakeRotation(-0.04, 0, 0, 1))]
        editModeToolAnimation.autoreverses = true
        editModeToolAnimation.duration = 0.15
        editModeToolAnimation.repeatCount = Float.infinity
        self.layer.add(editModeToolAnimation, forKey: "transform")
    }

    @IBAction private func toolDeleteBtnClick(_ sender: Any) {
        // print("툴 삭제 버튼")
    }
}

class SmallTool: ToolView {
    override func awakeFromNib() {
        super.awakeFromNib()
        tool.frame = CGRect(x: 0, y: 0, width: 136, height: 136)
    }
}

class MediumTool: ToolView {
    override func awakeFromNib() {
        super.awakeFromNib()
        tool.frame = CGRect(x: 0, y: 0, width: 300, height: 136)
    }
}

class LargeTool: ToolView {
    override func awakeFromNib() {
        super.awakeFromNib()
        tool.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
    }
}

class ExtraWideTool: ToolView {
    override func awakeFromNib() {
        super.awakeFromNib()
        tool.frame = CGRect(x: 0, y: 0, width: 628, height: 300)
    }
}

class ExtraLongTool: ToolView {
    override func awakeFromNib() {
        super.awakeFromNib()
        tool.frame = CGRect(x: 0, y: 0, width: 300, height: 628)
    }
}

class KingTool: ToolView {
    override func awakeFromNib() {
        super.awakeFromNib()
        tool.frame = CGRect(x: 0, y: 0, width: 628, height: 628)
    }
}
