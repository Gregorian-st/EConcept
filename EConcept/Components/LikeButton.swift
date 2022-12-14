//
//  LikeButton.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import UIKit

protocol LikeButtonDelegate: AnyObject {
    
    func didLike(isLiked: Bool)
}

final class LikeButton: UIView {
    
    weak var delegate: LikeButtonDelegate?
    
    private var imageView = UIImageView()
    private var backgroundView = UIView()
    private var likedImage: UIImage = UIImage(systemName: "heart.fill")!
    private var unlikedImage: UIImage = UIImage(systemName: "heart")!
    
    var id: Int = 0
    
    var backColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var imageColor: UIColor = .red {
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
    
    var isLiked: Bool = false {
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
    
    init(isLiked: Bool) {
        
        self.isLiked = isLiked
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
        imageView.image = isLiked
            ? likedImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
            : unlikedImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = imageColor
        
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
        imageView.image = isLiked
            ? likedImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
            : unlikedImage.resizeImageTo(size: CGSize(width: imageWidth, height: imageHeight))?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = imageColor
    }
    
    @objc func colorButtonAction() {
        
        isLiked.toggle()
        delegate?.didLike(isLiked: isLiked)
    }
}
