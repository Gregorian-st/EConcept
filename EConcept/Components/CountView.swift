//
//  CountView.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 11.12.2022.
//

import UIKit

final class CountView: UIView {
    
    private var countView = UILabel()
    private var backgroundView = UIView()
    
    var backColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var count: Int = 0 {
        didSet {
            updateView()
        }
    }
    
    var countFont: UIFont = UIFont() {
        didSet {
            updateView()
        }
    }
    
    var countFontColor: UIColor = .white {
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
    
    init(count: Int) {
        
        self.count = count
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
        
        countView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        countView.numberOfLines = 1
        countView.textAlignment = .center
        countView.font = countFont
        countView.textColor = countFontColor
        countView.text = String(count)
        
        self.addSubview(backgroundView)
        self.addSubview(countView)
     }
    
    private func updateView() {
        
        if self.frame == .zero {
            return
        }
        
        if count == 0 {
            self.isHidden = true
            return
        }
        backgroundView.backgroundColor = backColor
        countView.font = countFont
        countView.textColor = countFontColor
        countView.text = String(count)
        self.isHidden = false
    }
}
