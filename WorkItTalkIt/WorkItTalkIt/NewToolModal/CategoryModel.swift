//
//  Category.swift
//  WorkItTalkIt
//
//  Created by Lena on 2022/06/13.
// TableViewCell 에 뿌려줄 데이터들 (카테고리 정보들) 
// Model

import UIKit

struct Category {
    var categoryTitle: String
    var categoryImage: UIImage?
    var isExpanded: Bool // 고정값으로 주자
    var isArrow: Bool // 화살표 있냐 없냐 (카테고리 펼쳐질 용도)
    var subCategories: [Category]
}
