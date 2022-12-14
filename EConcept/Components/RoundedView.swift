//
//  RoundedView.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import UIKit

final class RoundedView: UIView {
    
    var isBlurred: Bool = false {
        didSet {
            setupUI()
        }
    }
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            setupUI()
        }
    }
    
    var backColor: UIColor = .white {
        didSet {
            setupUI()
        }
    }
    
    var shadowColor: UIColor = .black {
        didSet {
            setupUI()
        }
    }
    
    var shadowRadius: CGFloat = 10 {
        didSet {
            setupUI()
        }
    }
    
    var shadowOpacity: Float = 0.5 {
        didSet {
            if shadowOpacity > 1 || shadowOpacity < 0 {
                shadowOpacity = oldValue
            } else {
                setupUI()
            }
        }
    }
    
    var visualEffect: UIVisualEffect? {
        didSet {
            if let effect = visualEffect {
                effectBackground.effect = effect
            } else {
                effectBackground = UIVisualEffectView(effect: .none)
            }
            setupUI()
        }
    }
    private var effectBackground = UIVisualEffectView(effect: .none)
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    func commonInit()  {
        
        setupUI()
        initEffectView()
    }
    
    func setupUI() {
        
        backgroundColor = backColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
    
    func initEffectView() {
        
        effectBackground.frame = bounds
        effectBackground.layer.cornerRadius = cornerRadius
        effectBackground.layer.masksToBounds = true
        
        addSubview(effectBackground)
        sendSubviewToBack(effectBackground)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSizeMake(0.0, 0.0)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath.cgPath
    }
}
