//
//  ProductSmartphone.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation
import UIKit

struct ProductSmartphone {
    
    var id: String = ""
    var cpuType: String = ""
    var cameraType: String = ""
    var capacityVariants: [String] = []
    var colorVariantsString: [String] = [] {
        didSet {
            var colorsArray: [UIColor] = []
            colorVariantsString.forEach { colorString in
                colorsArray.append(UIColor.init(rgbHex: colorString))
            }
            colorVariants = colorsArray
        }
    }
    var colorVariants: [UIColor] = []
    var imagesUrlStrings: [String] = [] {
        didSet {
            var urls: [URL] = []
            imagesUrlStrings.forEach { urlString in
                if let url = URL(string: urlString) {
                    urls.append(url)
                }
            }
            imagesUrl = urls
        }
    }
    var imagesUrl: [URL] = []
    var isFavorites: Bool = false
    var price: Decimal = 0
    var rating: Decimal = 0
    var sd: String = ""
    var ssd: String = ""
    var title: String = ""
}
