//
//  ColorSelectButton.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 10.12.2022.
//

import UIKit

protocol ColorSelectButtonDelegate: AnyObject {
    
    func didSelect(id: Int, color: UIColor)
}

final class ColorSelectButton: UIView {
    
    weak var delegate: ColorSelectButtonDelegate?
    
    private var imageView = UIImageView()
    private var backgroundView = UIView()
    
    var id: Int = 0
    
    var backColor: UIColor = .white {
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
    
    var checkImage: UIImage = UIImage(named: "check")! {
        didSet{
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
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .center
        
        imageView.image = selectedByUser
            ? checkImage.resizeImageTo(size: CGSize(width: self.frame.width / 2, height: self.frame.height / 2))
            : nil
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        backgroundView.layer.cornerRadius = imageView.frame.width / 2
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shadowColor = shadowColor.cgColor
        backgroundView.layer.shadowOpacity = shadowOpacity
        backgroundView.layer.shadowRadius = shadowRadius
        backgroundView.layer.shadowOffset = shadowOffset
        backgroundView.backgroundColor = backColor
        
        self.addSubview(backgroundView)
        self.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(colorButtonAction))
        addGestureRecognizer(tap)
     }
    
    private func updateView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.backgroundColor = backColor
        imageView.image = selectedByUser
            ? checkImage.resizeImageTo(size: CGSize(width: self.frame.width / 2, height: self.frame.height / 2))
            : nil
    }
    
    @objc func colorButtonAction() {
        
        selectedByUser = true
        delegate?.didSelect(id: id, color: backColor)
    }
}
