//
//  KingTool.swift
//  WorkItTalkIt
//
//  Created by Yu ahyeon on 2022/06/12.
//

import UIKit

class KingTool: UIView {

    @IBOutlet var kingTool: UIView!
    @IBAction func toolDeleteBtnClick(_ sender: Any) {
    }

    let nibName = "KingTool"

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
        kingTool.layer.shadowColor =
        CGColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        kingTool.layer.shadowOffset = CGSize(width: 3, height: 3)
        kingTool.layer.shadowOpacity = 0.3
        kingTool.layer.shadowRadius = 10.0
    }

}
