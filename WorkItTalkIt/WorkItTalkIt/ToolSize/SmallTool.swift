//
//  SmallTool.swift
//  WorkItTalkIt
//
//  Created by Yu ahyeon on 2022/06/11.
//

import UIKit

class SmallTool: UIView {

    @IBOutlet var smallTool: UIView!

    let nibName = "SmallTool"    // xib 이름
    @IBAction func toolDeleteBtnClick(_ sender: Any) {
        print("스몰삭제")
    }

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
        smallTool.layer.shadowColor =
        CGColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        smallTool.layer.shadowOffset = CGSize(width: 3, height: 3)
        smallTool.layer.shadowOpacity = 0.3
        smallTool.layer.shadowRadius = 10.0
    }
}
