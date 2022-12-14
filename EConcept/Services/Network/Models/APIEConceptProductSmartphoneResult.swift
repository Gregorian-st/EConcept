//
//  APIEConceptProductSmartphoneResult.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct APIEConceptProductSmartphoneResult: Decodable {
    
    var productSmartphone = ProductSmartphone()
    
    enum ProductCodingKeys: String, CodingKey {
        case id
        case title
        case cpuType = "CPU"
        case cameraType = "camera"
        case capacityVariants = "capacity"
        case colorVariantsString = "color"
        case imagesUrlStrings = "images"
        case isFavorites
        case price
        case rating
        case sd
        case ssd
    }
    
    init(from decoder: Decoder) throws {
        
        let productContainer = try decoder.container(keyedBy: ProductCodingKeys.self)
        
        do {
            productSmartphone.id = try productContainer.decodeIfPresent(String.self, forKey: .id) ?? ""
            productSmartphone.title = try productContainer.decodeIfPresent(String.self, forKey: .title) ?? ""
            productSmartphone.cpuType = try productContainer.decodeIfPresent(String.self, forKey: .cpuType) ?? ""
            productSmartphone.cameraType = try productContainer.decodeIfPresent(String.self, forKey: .cameraType) ?? ""
            productSmartphone.capacityVariants = try productContainer.decodeIfPresent([String].self, forKey: .capacityVariants) ?? []
            productSmartphone.colorVariantsString = try productContainer.decodeIfPresent([String].self, forKey: .colorVariantsString) ?? []
            productSmartphone.imagesUrlStrings = try productContainer.decodeIfPresent([String].self, forKey: .imagesUrlStrings) ?? []
            productSmartphone.isFavorites = try productContainer.decodeIfPresent(Bool.self, forKey: .isFavorites) ?? false
            productSmartphone.price = try productContainer.decodeIfPresent(Decimal.self, forKey: .price) ?? 0
            productSmartphone.rating = try productContainer.decodeIfPresent(Decimal.self, forKey: .rating) ?? 0
            productSmartphone.sd = try productContainer.decodeIfPresent(String.self, forKey: .sd) ?? ""
            productSmartphone.ssd = try productContainer.decodeIfPresent(String.self, forKey: .ssd) ?? ""
        } catch {}
    }
}
