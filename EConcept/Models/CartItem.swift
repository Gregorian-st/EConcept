//
//  CartItem.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct CartItem {
    
    var id: Int = 0
    var imageUrlString: String = "" {
        didSet {
            imageUrl = URL(string: imageUrlString)
        }
    }
    var imageUrl: URL?
    var price: Decimal = 0
    var title: String = ""
}
