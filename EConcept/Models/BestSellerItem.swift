//
//  BestSellerItem.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct BestSellerItem {
    
    var id: Int = 0
    var isFavorites: Bool = false
    var title: String = ""
    var priceWithoutDiscount: Decimal = 0
    var discountPrice: Decimal = 0
    var pictureUrlString: String = "" {
        didSet {
            pictureUrl = URL(string: pictureUrlString)
        }
    }
    var pictureUrl: URL?
}
