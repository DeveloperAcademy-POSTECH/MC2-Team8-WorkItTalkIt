//
//  ViewController.swift
//  WorkItTalkIt
//
//  Created by 김수진 on 2022/06/10.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet var gestureArea: UIImageView!
    @IBAction func didTabEditButton(_ sender: UIButton) {
        if let editScreen = self.storyboard?.instantiateViewController(withIdentifier: "EditScreenVC") {
            editScreen.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(editScreen, animated: true)
            print(type(of: self))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        gestureArea.backgroundColor = .clear
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPressGesture.minimumPressDuration = 0.8
        longPressGesture.delegate = self
        self.view.addGestureRecognizer(longPressGesture)
    }
    @objc func longPressed(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            gestureArea.backgroundColor = .systemGray
        } else {
            gestureArea.backgroundColor = .cyan
        }
        print("Long Pressed")
    }
}
