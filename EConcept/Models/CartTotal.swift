//
//  CartTotal.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 05.12.2022.
//

import Foundation

struct CartTotal {
    
    var id: String = ""
    var total: Decimal = 0
    var delivery: String = "Free"
    var items: [CartItem] = []
}
