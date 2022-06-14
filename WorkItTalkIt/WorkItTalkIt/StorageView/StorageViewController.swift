//
//  StorageViewController.swift
//  WorkItTalkIt
//
//  Created by Somin Park on 2022/06/14.
//

import UIKit

class StorageViewController: UIViewController {

    // 뷰
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var storageView: UIView!
    @IBOutlet weak var toolView: UIView!
    @IBOutlet weak var folderTableView: UITableView!
    // 버튼
    @IBOutlet weak var editFolderButton: UIButton!
    @IBOutlet weak var addFolderButton: UIButton!
    @IBOutlet weak var deleteToolButton: UIButton!
    @IBOutlet weak var addToBoardButton: UIButton!
    @IBOutlet weak var moveFolderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 사이드뷰 레이아웃
        sideView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 0.9)
        //보관함뷰 레이아웃
        storageView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        // 편집버튼 레이아웃
        editFolderButton.setTitle("편집", for: .normal)
        editFolderButton.setTitleColor(UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1), for: .normal)
        editFolderButton.backgroundColor = UIColor.clear
        //폴더추가버튼 레이아웃
        addFolderButton.setTitle(" 폴더 추가", for: .normal)
        addFolderButton.setTitleColor(UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1), for: .normal)
        addFolderButton.tintColor = UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1)
        addFolderButton.backgroundColor = UIColor.clear
        //삭제버튼 레이아웃
        deleteToolButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        deleteToolButton.tintColor = UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1)
        deleteToolButton.backgroundColor = UIColor.clear
        //폴더이동 버튼 레이아웃
        moveFolderButton.setImage(UIImage(named: "moveFolderIcon"), for: .normal)
        moveFolderButton.backgroundColor = UIColor.clear
        //보드에추가버튼 레이아웃
        addToBoardButton.setTitle("보드에 추가", for: .normal)
        addToBoardButton.tintColor = UIColor.white
        addToBoardButton.backgroundColor = UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1)
        addToBoardButton.layer.masksToBounds = true
        addToBoardButton.layer.cornerRadius = 18
    }
    
    
}
