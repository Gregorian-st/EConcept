//
//  DetailCarouselCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 10.12.2022.
//

import UIKit
import SnapKit

final class DetailCarouselCell: UICollectionViewCell {
    
    static var cellId = "detailCarouselCell"
    
    lazy var itemImage: UIImageView = {
        let makeImageView = UIImageView()
        makeImageView.layer.cornerRadius = 20
        makeImageView.layer.masksToBounds = true
        makeImageView.layer.backgroundColor = UIColor.white.cgColor
        makeImageView.contentMode = .scaleAspectFit
        return makeImageView
    }()
    
    lazy var itemImageBackground: UIView = {
        let makeView = UIView()
        makeView.layer.cornerRadius = 20
        makeView.layer.masksToBounds = false
        makeView.layer.backgroundColor = UIColor.backgroundThemeColor?.cgColor
        makeView.layer.shadowColor = UIColor.backThemeColor?.cgColor
        makeView.layer.shadowOpacity = 0.1
        makeView.layer.shadowRadius = 8
        makeView.layer.shadowOffset = .zero
        return makeView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Program Logic
    
    private func setupUI() {
        
        self.addSubview(itemImageBackground)
        itemImageBackground.snp.makeConstraints { (make) in
            make.size.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(itemImage)
        itemImage.snp.makeConstraints { (make) in
            make.size.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
