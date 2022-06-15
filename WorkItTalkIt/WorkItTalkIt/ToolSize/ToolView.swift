//
//  AllToolSizeView.swift
//  WorkItTalkIt
//
//  Created by Yu ahyeon on 2022/06/13.
//

import UIKit

class ToolView: UIView {
    
    @IBOutlet var tool: UIView!
    @IBOutlet var toolDeleteBtn: UIButton!
    var onEditMode = false {
        didSet {
            if onEditMode == true {
                toolDeleteAnimation()
                toolDeleteBtn.isHidden = false
            } else {
                toolDeleteBtn.isHidden = true
            }
        }
    }
    let nibName = "ToolView"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func toolShadow() {
        tool.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        tool.layer.shadowColor = CGColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        tool.layer.shadowOffset = CGSize(width: 3, height: 3)
        tool.layer.shadowOpacity = 0.3
        tool.layer.shadowRadius = 10.0
    }
    
    func toolDeleteAnimation() {
        let toolDeleteAnimation = CAKeyframeAnimation(keyPath: "transform")
        toolDeleteAnimation.values = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0, 0, 1)), NSValue(caTransform3D: CATransform3DMakeRotation(-0.04, 0, 0, 1))]
        toolDeleteAnimation.autoreverses = true
        toolDeleteAnimation.duration = 0.15
        toolDeleteAnimation.repeatCount = Float.infinity
        self.layer.add(toolDeleteAnimation, forKey: "transform")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        toolShadow()
        toolDeleteBtn.isHidden = true
    }
    
    @IBAction func toolDeleteBtnClick(_ sender: Any) {
        //print("툴 삭제 버튼")
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
