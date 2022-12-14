//
//  SwipeableNavigationController.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import UIKit

class SwipeableNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}
extension SwipeableNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return viewControllers.count > 1
    }
}

