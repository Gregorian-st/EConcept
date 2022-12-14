//
//  APIEConceptMainResult.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct APIEConceptMainResult: Decodable {
    
    var homeStoreItems: [HomeStoreItem] = []
    var bestSellerItems: [BestSellerItem] = []
    
    enum MainCodingKeys: String, CodingKey {
        case homeStoreItems = "home_store"
        case bestSellerItems = "best_seller"
    }
    
    enum HomeStoreCodingKeys: String, CodingKey {
        case id
        case isNew = "is_new"
        case title
        case subtitle
        case pictureUrlString = "picture"
        case isBuy = "is_buy"
    }
    
    enum BestSellerCodingKeys: String, CodingKey {
        case id
        case isFavorites = "is_favorites"
        case title
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case pictureUrlString = "picture"
    }
    
    init(from decoder: Decoder) throws {
        
        let mainContainer = try decoder.container(keyedBy: MainCodingKeys.self)
        
        do {
            var homeStoreContainer = try mainContainer.nestedUnkeyedContainer(forKey: .homeStoreItems)
            let countItems = homeStoreContainer.count ?? 0
            if countItems > 0 {
                for index in 0..<countItems {
                    let homeStoreItemContainer = try homeStoreContainer.nestedContainer(keyedBy: HomeStoreCodingKeys.self)
                    homeStoreItems.append(HomeStoreItem())
                    homeStoreItems[index].id = try homeStoreItemContainer.decodeIfPresent(Int.self, forKey: .id) ?? 0
                    homeStoreItems[index].isNew = try homeStoreItemContainer.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
                    homeStoreItems[index].title = try homeStoreItemContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
                    homeStoreItems[index].subtitle = try homeStoreItemContainer.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
                    homeStoreItems[index].pictureUrlString = try homeStoreItemContainer.decodeIfPresent(String.self, forKey: .pictureUrlString) ?? ""
                    homeStoreItems[index].isBuy = try homeStoreItemContainer.decodeIfPresent(Bool.self, forKey: .isBuy) ?? false
                }
            }
        } catch {}
        
        do {
            var bestSellerContainer = try mainContainer.nestedUnkeyedContainer(forKey: .bestSellerItems)
            let countItems = bestSellerContainer.count ?? 0
            if countItems > 0 {
                for index in 0..<countItems {
                    let bestSellerItemContainer = try bestSellerContainer.nestedContainer(keyedBy: BestSellerCodingKeys.self)
                    bestSellerItems.append(BestSellerItem())
                    bestSellerItems[index].id = try bestSellerItemContainer.decodeIfPresent(Int.self, forKey: .id) ?? 0
                    bestSellerItems[index].isFavorites = try bestSellerItemContainer.decodeIfPresent(Bool.self, forKey: .isFavorites) ?? false
                    bestSellerItems[index].title = try bestSellerItemContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
                    bestSellerItems[index].priceWithoutDiscount = try bestSellerItemContainer.decodeIfPresent(Decimal.self, forKey: .priceWithoutDiscount) ?? 0
                    bestSellerItems[index].discountPrice = try bestSellerItemContainer.decodeIfPresent(Decimal.self, forKey: .discountPrice) ?? 0
                    bestSellerItems[index].pictureUrlString = try bestSellerItemContainer.decodeIfPresent(String.self, forKey: .pictureUrlString) ?? ""
                }
            }
        } catch {}
    }
}
