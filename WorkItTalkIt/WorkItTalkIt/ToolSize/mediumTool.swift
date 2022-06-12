//
//  MediumTool.swift
//  WorkItTalkIt
//
//  Created by Yu ahyeon on 2022/06/12.
//

import UIKit

class MediumTool: UIView {

    @IBOutlet var mediumTool: UIView!
    @IBAction func toolDeleteBtnClick(_ sender: Any) {
        print("미디엄삭제")
    }

    let nibName = "MediumTool"

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
        view.frame = self.bounds
        self.addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    // Tool 그림자 주기
    override func awakeFromNib() {
        super.awakeFromNib()
        mediumTool.layer.shadowColor =
        CGColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        mediumTool.layer.shadowOffset = CGSize(width: 3, height: 3)
        mediumTool.layer.shadowOpacity = 0.3
        mediumTool.layer.shadowRadius = 10.0
    }

}
