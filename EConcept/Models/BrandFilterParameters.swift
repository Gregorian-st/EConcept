//
//  BrandFilterParameters.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

struct BrandFilterParameters: CustomStringConvertible {
    
    var id: Int = 0
    var name: String = ""
    var description: String {
        return "\(name)"
    }
}
