//
//  PriceFilterParameters.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import Foundation

struct PriceFilterParameters: CustomStringConvertible {
    
    var id: Int = 0
    var minPrice: Decimal = 0
    var maxPrice: Decimal = 0
    var description: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.currencyCode = "USD"
        currencyFormatter.numberStyle = .currency
        return "\(currencyFormatter.string(for: minPrice) ?? "0") - \(currencyFormatter.string(for: maxPrice) ?? "0")"
    }
}
