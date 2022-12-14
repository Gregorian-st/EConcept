//
//  HomeStoreItem.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct HomeStoreItem {
    
    var id: Int = 0
    var isNew: Bool = false
    var title: String = ""
    var subtitle: String = ""
    var pictureUrlString: String = "" {
        didSet {
            pictureUrl = URL(string: pictureUrlString)
        }
    }
    var pictureUrl: URL?
    var isBuy: Bool = false
}
