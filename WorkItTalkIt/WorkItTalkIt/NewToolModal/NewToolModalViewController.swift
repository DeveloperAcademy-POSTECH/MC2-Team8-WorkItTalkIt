//
//  NewToolModalViewController.swift
//  WorkItTalkIt
//
//  Created by Lena on 2022/06/12.
//

import UIKit

class NewToolModalViewController: UIViewController {

    var toolCategory: [ToolCategory] = ToolCategory.allCases

    @IBOutlet var categoryTableView: UITableView! = {
        let categoryTableView = UITableView()
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewToolCategoryTableViewCell")
        return categoryTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryTableView.delegate = self
        categoryTableView.dataSource = self

        view.addSubview(categoryTableView)
    }
}

extension NewToolModalViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return toolCategory.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toolCategory[section].hasArrow {
            return (toolCategory[section].subCategory?.count ?? 0) + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = categoryTableView.dequeueReusableCell(withIdentifier: "NewToolCategoryTableViewCell", for: indexPath) as? NewToolCategoryTableViewCell else { return UITableViewCell() }

        // 카테고리 표시
        if indexPath.row == 0 {
            cell.categoryTitleLabel.text = toolCategory[indexPath.section].title
            cell.categoryImage.image = toolCategory[indexPath.section].image
            cell.categoryArrowImage.isHidden = !toolCategory[indexPath.section].hasArrow
            // ArrowImage 구분하기
            if !toolCategory[indexPath.section].hasArrow {
                cell.categoryArrowImage.image = nil
            }
            if toolCategory[indexPath.section].isExpanded {
                cell.categoryArrowImage.isHighlighted = toolCategory[indexPath.section].isExpanded
            }

        // 펼쳐져 있으면 카테고리 내 sub 카테고리를 표시할 조건문
        } else {
            cell.categoryArrowImage.image = nil
            cell.categoryTitleLabel.text = toolCategory[indexPath.section].subCategory?[indexPath.row - 1].title
            cell.categoryImage.image = toolCategory[indexPath.section].subCategory?[indexPath.row - 1].image
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        categoryTableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            // 카테고리를 접었다 편다
            // print("1\(toolCategory[indexPath.section].isExpanded)")
            toolCategory[indexPath.section].isExpanded = !toolCategory[indexPath.section].isExpanded
            // print("2\(toolCategory[indexPath.section].isExpanded)")

            // 테이블뷰 reload
            categoryTableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("tapped sub categories")
        }
    }
}
