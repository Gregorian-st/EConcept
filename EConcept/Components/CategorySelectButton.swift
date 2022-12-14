//
//  CategorySelectButton.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import UIKit

protocol CategorySelectButtonDelegate: AnyObject {

    func didSelect(id: Int)
}

final class CategorySelectButton: UIView {
    
    weak var delegate: CategorySelectButtonDelegate?
    
    private var imageView = UIImageView()
    private var backgroundView = UIView()
    
    var id: Int = 0
    
    var selectedBackColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    
    var unselectedBackColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var selectedImageColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var unselectedImageColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }
    
    var imageWidth: Int = 5 {
        didSet {
            updateView()
        }
    }
    
    var imageHeight: Int = 3 {
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
    
    var buttonImage: UIImage = UIImage(named: "check")! {
        didSet{
            setupView()
        }
    }
    
    init(selectedByUser: Bool) {
        
        self.selectedByUser = selectedByUser
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    override init(frame: CGRect) {
        
        super.init (frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder ) {
        
        super.init (coder: aDecoder)
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
            ? buttonImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
            : buttonImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = selectedByUser ? selectedImageColor : unselectedImageColor
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        backgroundView.layer.cornerRadius = imageView.frame.width / 2
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.shadowColor = shadowColor.cgColor
        backgroundView.layer.shadowOpacity = shadowOpacity
        backgroundView.layer.shadowRadius = shadowRadius
        backgroundView.layer.shadowOffset = shadowOffset
        backgroundView.backgroundColor = selectedByUser ? selectedBackColor : unselectedBackColor
        
        self.addSubview(backgroundView)
        self.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(categoryButtonAction))
        addGestureRecognizer(tap)
    }
    
    private func updateView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.backgroundColor = selectedByUser ? selectedBackColor : unselectedBackColor
        imageView.image = selectedByUser
            ? buttonImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
            : buttonImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = selectedByUser ? selectedImageColor : unselectedImageColor
    }
    
    @objc func categoryButtonAction() {
        
        selectedByUser = true
        delegate?.didSelect(id: id)
    }
}
