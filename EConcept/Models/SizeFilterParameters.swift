//
//  SizeFilterParameters.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

struct SizeFilterParameters: CustomStringConvertible {
    
    var id: Int = 0
    var minSize: Float = 0
    var maxSize: Float = 0
    var description: String {
        return "\(minSize) to \(maxSize) inches"
    }
}
