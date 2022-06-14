//
//  NewToolModalViewController.swift
//  WorkItTalkIt
//
//  Created by Lena on 2022/06/12.
//

import UIKit

class NewToolModalViewController: UIViewController {
    
    // expandable
    @IBOutlet weak var categoryTableView: UITableView! = {
        let categoryTableView = UITableView()
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewToolCategoryTableViewCell")
        return categoryTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(categoryTableView)
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
}

extension NewToolModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories[section].isExpanded {
            return categories[section].subCategories.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = categoryTableView.dequeueReusableCell(withIdentifier: "NewToolCategoryTableViewCell", for: indexPath) as? NewToolCategoryTableViewCell else { return UITableViewCell()}
        
        // 카테고리 표시
        if indexPath.row == 0 {
            cell.categoryTitleLabel.text = categories[indexPath.section].categoryTitle
            cell.categoryImage.image = categories[indexPath.section].categoryImage
            cell.categoryArrowImage.isHidden = !categories[indexPath.section].isArrow
            // ArrowImage 구분하기
            if !categories[indexPath.section].isArrow {
                cell.categoryArrowImage.isHidden = true
            }
            
            if categories[indexPath.section].isExpanded {
                cell.categoryArrowImage.isHighlighted = categories[indexPath.section].isExpanded
            }
        
        // 펼쳐져 있으면 카테고리 내 sub 카테고리를 표시할 조건문
        } else {
            cell.categoryArrowImage.isHidden = true
            cell.categoryTitleLabel.text = categories[indexPath.section].subCategories[indexPath.row - 1].categoryTitle
            cell.categoryImage.image = categories[indexPath.section].subCategories[indexPath.row - 1].categoryImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            // 카테고리를 접었다 편다
            categories[indexPath.section].isExpanded = !categories[indexPath.section].isExpanded
            
            // 테이블뷰 reload
            categoryTableView.reloadSections([indexPath.section], with: .automatic)
        }
        else {
            print("tapped sub categories")
        }
    }
}
