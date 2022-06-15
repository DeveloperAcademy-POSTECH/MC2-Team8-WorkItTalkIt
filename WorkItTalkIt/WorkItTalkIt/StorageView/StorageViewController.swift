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

        folderTableView.dataSource = self
        folderTableView.delegate = self
        
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
    //폴더 추가 버튼 눌렀을 때
    @IBAction func addFolderButtonClicked(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "폴더 추가", message: "폴더명을 입력해주세요", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "폴더명"
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            guard let text = alert.textFields?[0].text else { return }
            if text != "" {
                //중복방지
                if folderList.contains(text){
                    let newAlert = UIAlertController(title: "폴더명 추가", message: "중복된 이름입니다", preferredStyle: .alert)
                    newAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                    self.present(newAlert, animated: true, completion: nil)
                }else {
                    folderList.append(text)
                    self.folderTableView.reloadData()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //편집버튼 눌렀을 때
    @IBAction func editFolderButtonClicked(_ sender: UIButton) {
        if self.folderTableView.isEditing {
            self.editFolderButton.setTitle("편집", for: .normal)
            self.folderTableView.setEditing(false, animated: true)
        } else {
            self.editFolderButton.setTitle("완료", for: .normal)
            self.folderTableView.setEditing(true, animated: true)
        }
    }
}

extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideTableViewCell.identifier, for: indexPath) as? SideTableViewCell else { return UITableViewCell() }
        cell.folderNameLabel.text = folderList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    //편집버튼 눌렀을때 editingStyle
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if folderList[indexPath.row] == "기본" {
            return .none
        }
        return .delete
    }
    
    //delete버튼 누르면 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //삭제 전 alert창 띄우기
            let alert = UIAlertController(title: "'\(folderList[indexPath.row])' 폴더를 삭제하시겠습니까?", message: "폴더 안에 있는 툴도 모두 삭제됩니다.", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            let destructiveAction = UIAlertAction(title: "삭제", style: UIAlertAction.Style.destructive) { _ in
                folderList.remove(at: indexPath.row)
                self.folderTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alert.addAction(cancelAction)
            alert.addAction(destructiveAction)
            
            self.present(alert, animated: false)
            
        }
    }
    
    //목록에서 순서바꾸기
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let targetItem: String = folderList[sourceIndexPath.row]
        folderList.remove(at: sourceIndexPath.row)
        folderList.insert(targetItem, at: destinationIndexPath.row)
    }
    
    //폴더이름편집
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        //기본폴더는 변경불가
        if folderList[indexPath.row] == "기본" {
            let alert = UIAlertController(title: "폴더명 변경", message: "기본 폴더는 변경할 수 없습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "'\(folderList[indexPath.row])' 폴더명 변경", message: "변경할 이름을 입력해주세요", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "변경할 폴더명"
            }
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                guard let text = alert.textFields?[0].text else { return }
                if text != "" {
                    //중복방지
                    if folderList.contains(text){
                        let newAlert = UIAlertController(title: "폴더명 변경", message: "중복된 이름입니다", preferredStyle: .alert)
                        newAlert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                        self.present(newAlert, animated: true, completion: nil)
                    }
                    else {
                        folderList[indexPath.row] = text
                        self.folderTableView.reloadData()
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
}
