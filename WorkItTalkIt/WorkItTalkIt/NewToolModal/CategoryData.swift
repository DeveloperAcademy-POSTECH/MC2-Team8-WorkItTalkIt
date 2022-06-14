//
//  CategoryData.swift
//  WorkItTalkIt
//
//  Created by Lena on 2022/06/13.
//

import UIKit

var categories: [Category] = [
    Category(categoryTitle: "제안",
             categoryImage: UIImage(systemName: "rectangle.3.group"),
             isExpanded: false,
             isArrow: false,
             subCategories: []),
    Category(categoryTitle: "캘린더",
             categoryImage: UIImage(systemName:  "calendar"),
             isExpanded: false,
             isArrow: true,
             subCategories: [Category(categoryTitle: "타임라인",
                                      categoryImage: UIImage(named: "CategorySubOval"),
                                      isExpanded: false,
                                      isArrow: true,
                                      subCategories: []),
                             Category(categoryTitle: "월별 캘린더",
                                      categoryImage: UIImage(named: "CategorySubOval"),
                                      isExpanded: false,
                                      isArrow: true,
                                      subCategories: [])]),
    Category(categoryTitle: "칸반보드",
             categoryImage: UIImage(named: "CategoryKanban"),
             isExpanded: false,
             isArrow: false,
             subCategories: []),
    Category(categoryTitle: "투두리스트",
             categoryImage: UIImage(systemName: "checklist"),
             isExpanded: false,
             isArrow: false,
             subCategories: []),
    Category(categoryTitle: "포스트잇",
             categoryImage: UIImage(systemName: "note.text"),
             isExpanded: false,
             isArrow: false,
             subCategories: []),
    Category(categoryTitle: "데드라인체커",
             categoryImage: UIImage(systemName: "chart.pie"),
             isExpanded: false,
             isArrow: true,
             subCategories: [Category(categoryTitle: "기간 체커",
                                      categoryImage: UIImage(named: "CategorySubOval"),
                                      isExpanded: false,
                                      isArrow: false,
                                      subCategories: []),
                             Category(categoryTitle: "시간 체커",
                                      categoryImage: UIImage(named: "CategorySubOval"),
                                      isExpanded: false,
                                      isArrow: false,
                                      subCategories: [])]),
    Category(categoryTitle: "갤러리",
             categoryImage: UIImage(systemName: "photo"),
             isExpanded: false,
             isArrow: false,
             subCategories: []),
    Category(categoryTitle: "시계",
             categoryImage: UIImage(systemName: "clock"),
             isExpanded: false,
             isArrow: false,
             subCategories: [])
    /* 임시로 제외할 카테고리
    Category(categoryTitle: "빈 박스",
             categoryImage: UIImage(systemName: "app.dashed"),
             isExpandable: false,
             chevronArrow: nil,
             subCategories: [])
     */
]
