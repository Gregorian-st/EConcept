//
//  APIEConceptCartResult.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct APIEConceptCartResult: Decodable {
    
    var cartTotal = CartTotal()
    
    enum CartTotalCodingKeys: String, CodingKey {
        case id
        case delivery
        case total
        case items = "basket"
    }
    
    enum CartItemCodingKeys: String, CodingKey {
        case id
        case title
        case imageUrlString = "images"
        case price
    }
    
    init(from decoder: Decoder) throws {
        
        let cartTotalContainer = try decoder.container(keyedBy: CartTotalCodingKeys.self)
        
        do {
            cartTotal.id = try cartTotalContainer.decodeIfPresent(String.self, forKey: .id) ?? ""
            cartTotal.delivery = try cartTotalContainer.decodeIfPresent(String.self, forKey: .delivery) ?? "Free"
            cartTotal.total = try cartTotalContainer.decodeIfPresent(Decimal.self, forKey: .total) ?? 0
            var cartItemsContainer = try cartTotalContainer.nestedUnkeyedContainer(forKey: .items)
            let countItems = cartItemsContainer.count ?? 0
            if countItems > 0 {
                for index in 0..<countItems {
                    let cartItemContainer = try cartItemsContainer.nestedContainer(keyedBy: CartItemCodingKeys.self)
                    cartTotal.items.append(CartItem())
                    cartTotal.items[index].id = try cartItemContainer.decodeIfPresent(Int.self, forKey: .id) ?? 0
                    cartTotal.items[index].title = try cartItemContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
                    cartTotal.items[index].imageUrlString = try cartItemContainer.decodeIfPresent(String.self, forKey: .imageUrlString) ?? ""
                    cartTotal.items[index].price = try cartItemContainer.decodeIfPresent(Decimal.self, forKey: .price) ?? 0
                }
            }
        } catch {}
    }
}
