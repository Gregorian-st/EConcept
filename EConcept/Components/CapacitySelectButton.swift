//
//  CapacitySelectButton.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 10.12.2022.
//

import UIKit

protocol CapacitySelectButtonDelegate: AnyObject {
    
    func didSelect(id: Int, capacity: String)
}

final class CapacitySelectButton: UIView {
    
    weak var delegate: CapacitySelectButtonDelegate?
    
    private var capacityLabel = UILabel()
    private var backgroundView = UIView()
    
    var id: Int = 0
    
    var cornerRadius: CGFloat = 10 {
        didSet {
            setupView()
        }
    }
    
    var capacityText: String = "cap" {
        didSet {
            updateView()
        }
    }
    
    var capacityFont: UIFont = UIFont() {
        didSet {
            updateView()
        }
    }
    
    var selectedBackColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var unselectedBackColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var selectedFontColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var unselectedFontColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var selectedByUser: Bool = false {
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
    
    init(selectedByUser: Bool) {
        
        self.selectedByUser = selectedByUser
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
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.masksToBounds = false
        backgroundView.backgroundColor = selectedByUser ? selectedBackColor : unselectedBackColor
        backgroundView.layer.shadowColor = shadowColor.cgColor
        backgroundView.layer.shadowOpacity = shadowOpacity
        backgroundView.layer.shadowRadius = shadowRadius
        backgroundView.layer.shadowOffset = shadowOffset
        
        capacityLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        capacityLabel.numberOfLines = 1
        capacityLabel.textAlignment = .center
        capacityLabel.font = capacityFont
        capacityLabel.textColor = selectedByUser ? selectedFontColor : unselectedFontColor
        capacityLabel.text = capacityText
        
        self.addSubview(backgroundView)
        self.addSubview(capacityLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(capacityButtonAction))
        addGestureRecognizer(tap)
     }
    
    private func updateView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.backgroundColor = selectedByUser ? selectedBackColor : unselectedBackColor
        capacityLabel.font = capacityFont
        capacityLabel.textColor = selectedByUser ? selectedFontColor : unselectedFontColor
        capacityLabel.text = capacityText
    }
    
    @objc func capacityButtonAction() {
        
        selectedByUser = true
        delegate?.didSelect(id: id, capacity: capacityText)
    }
}
