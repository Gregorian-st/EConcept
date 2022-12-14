//
//  NewLabelView.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit

final class NewLabelView: UIView {
    
    private var labelView = UILabel()
    private var backgroundView = UIView()
    
    var backColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var isNew: Bool = false {
        didSet {
            self.isHidden = !isNew
        }
    }
    
    var labelFont: UIFont = UIFont() {
        didSet {
            updateView()
        }
    }
    
    var labelFontColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var shadowColor: UIColor = .black {
        didSet {
            setupView()
        }
    }
    
    var shadowRadius: CGFloat = 10 {
        didSet {
            setupView()
        }
    }
    
    var shadowOpacity: Float = 0.5 {
        didSet {
            if shadowOpacity > 1 || shadowOpacity < 0 {
                shadowOpacity = oldValue
            } else {
                setupView()
            }
        }
    }
    
    var shadowOffset: CGSize = .zero {
        didSet {
            setupView()
        }
    }
    
    init(isNew: Bool) {
        
        self.isNew = isNew
        super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    override init(frame: CGRect) {
        
        super.init (frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder ) {
        
        super.init (coder: aDecoder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        setupView()
    }
    
    private func setupView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        backgroundView.layer.cornerRadius = self.frame.width / 2
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shadowColor = shadowColor.cgColor
        backgroundView.layer.shadowOpacity = shadowOpacity
        backgroundView.layer.shadowRadius = shadowRadius
        backgroundView.layer.shadowOffset = shadowOffset
        backgroundView.backgroundColor = backColor
        
        labelView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        labelView.numberOfLines = 1
        labelView.textAlignment = .center
        labelView.font = labelFont
        labelView.textColor = labelFontColor
        labelView.text = "New"
        
        self.addSubview(backgroundView)
        self.addSubview(labelView)
     }
    
    private func updateView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.backgroundColor = backColor
        labelView.font = labelFont
        labelView.textColor = labelFontColor
        self.isHidden = !isNew
    }
}
