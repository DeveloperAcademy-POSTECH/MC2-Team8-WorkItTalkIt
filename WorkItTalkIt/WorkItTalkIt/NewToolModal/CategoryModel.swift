//
//  Category.swift
//  WorkItTalkIt
//
//  Created by Lena on 2022/06/13.
//

import UIKit

enum ToolCategory: CaseIterable {
    case suggestion
    case calendar
    case kanban
    case todo
    case postit
    case deadlineChecker
    case gallary
    case clock
    // case emptyBox

    var title: String {
        switch self {
        case .suggestion: return "제안"
        case .calendar: return "캘린더"
        case .kanban: return "칸반보드"
        case .todo: return "투두리스트"
        case .postit: return "포스트잇"
        case .deadlineChecker: return "데드라인체커"
        case .gallary: return "갤러리"
        case .clock: return "시계"
        }
    }

    var image: UIImage? {
        switch self {
        case .suggestion:
            return UIImage(systemName: "rectangle.3.group")
        case .calendar:
            return UIImage(systemName: "calendar")
        case .kanban:
            return UIImage(named: "CategoryKanban")
        case .todo:
            return UIImage(systemName: "checklist")
        case .postit:
            return UIImage(systemName: "note.text")
        case .deadlineChecker:
            return UIImage(systemName: "chart.pie")
        case .gallary:
            return UIImage(systemName: "photo")
        case .clock:
            return UIImage(systemName: "clock")
        }
    }

    static var isExpanded = false
    var isExpanded: Bool {
        get {
            Self.isExpanded
            }
        nonmutating set {
            Self.isExpanded = newValue
        }
    }

    var hasArrow: Bool {
        switch self {
        case .suggestion: return false
        case .calendar: return true
        case .kanban: return false
        case .todo: return false
        case .postit: return false
        case .deadlineChecker: return true
        case .gallary: return false
        case .clock: return false
        }
    }

    var subCategory: [SubCategory]? {
        switch self {
        case .calendar:
            return [SubCategory.timeline, SubCategory.monthly]
        case .deadlineChecker:
            return [SubCategory.timeChecker, SubCategory.periodChecker]
        default:
            return nil
        }
    }
}

enum SubCategory: CaseIterable {
    case timeline
    case monthly
    case timeChecker
    case periodChecker

    var title: String {
        switch self {
        case .timeline:
            return "타임라인"
        case .monthly:
            return "월별"
        case .timeChecker:
            return "타임체커"
        case .periodChecker:
            return "기간체커"
        }
    }

    var image: UIImage? {
        switch self {
        case .timeline, .monthly, .timeChecker, .periodChecker:
            return UIImage(named: "CategorySubOval")
        }
    }

    var hasArrow: Bool {
        switch self {
        case .timeline, .monthly, .timeChecker, .periodChecker:
            return false
        }
    }
}
