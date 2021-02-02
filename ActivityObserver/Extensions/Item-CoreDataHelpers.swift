//
//  Item-CoreDataHelpers.swift
//  ActivityObserver
//
//  Created by Denis Svetlakov on 13.01.2021.
//

import Foundation

extension Item {
    enum SortOrder {
    case optimized, title, creationDate
    }

    var itemTitle: String {
        title ?? NSLocalizedString("New item", comment: "Create a new item")
    }

    var itemDetail: String {
        detail ?? ""
    }

    var itemCreationDate: Date {
        creationDate ?? Date()
    }

    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        let item = Item(context: viewContext)
        item.title = "Example item"
        item.detail = "This is example item"
        item.priority = 3
        item.creationDate = Date()
        return item
    }

}
