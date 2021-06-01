//
//  SpotlightManager.swift
//  SwiftSearcher
//
//  Created by Matheus Silva on 31/05/21.
//  Copyright © 2021 Matheus Silva. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

// MARK: - SpotlightManager

public struct SpotlightManager {

    // MARK: - Properties

    public static let items: [Item] = [
        .init(
            id: "0",
            title: "Pix",
            description: "Realize um Pix agora mesmo!",
            image: #imageLiteral(resourceName: "btg")
        )
    ]

    private static var searchableIndex = CSSearchableIndex.default()

    // MARK: - Static Methods

    public static func initialize() {
        items.forEach { set(item: $0) }
    }

    public static func remove() {
        delete()
    }

    // MARK: - Private Methods

    private static func set(item: Item) {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = item.title
        attributeSet.contentDescription = item.description
        attributeSet.thumbnailData = item.image.pngData()

        let item = CSSearchableItem(
            uniqueIdentifier: item.id,
            domainIdentifier: Constants.domainIdentifier,
            attributeSet: attributeSet
        )

        item.expirationDate = Date.distantFuture

        // Adds or updates items in the index.
        searchableIndex.indexSearchableItems([item]) { (error) in
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else{
                print("Search item successfully indexed!")
            }
        }
    }

    private static func delete() {
        searchableIndex.deleteAllSearchableItems() { (error) in
            if let error = error {
                print("Delete Searchable Items Error: \(error.localizedDescription)")
            } else{
                print("Searchable items successfully removed!")
            }
        }
    }
}

// MARK: - Constants

public extension SpotlightManager {
    enum Constants {
        static let domainIdentifier: String? = Bundle.main.bundleIdentifier
    }
}

// MARK: - Structs

public extension SpotlightManager {
    struct Item {
        let id: String
        let title: String
        let description: String
        let image: UIImage
    }
}
