//
//  ExtraLongTool.swift
//  WorkItTalkIt
//
//  Created by Yu ahyeon on 2022/06/12.
//

import UIKit

class ExtraLongTool: UIView {

    @IBOutlet var extraLongTool: UIView!
    @IBAction func toolDeleteBtnClick(_ sender: Any) {
        print("엑스트라 롱 삭제")
    }

    let nibName = "ExtraLongTool"

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
        extraLongTool.layer.shadowColor =
        CGColor(red: 171 / 255, green: 171 / 255, blue: 171 / 255, alpha: 1)
        extraLongTool.layer.shadowOffset = CGSize(width: 3, height: 3)
        extraLongTool.layer.shadowOpacity = 0.3
        extraLongTool.layer.shadowRadius = 10.0
    }

}
