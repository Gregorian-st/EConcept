//
//  SalesCarouselCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit
import SnapKit

protocol SalesCarouselCellDelegate: AnyObject {
    
    func buySales(id: Int)
}

final class SalesCarouselCell: UICollectionViewCell {
    
    weak var delegate: SalesCarouselCellDelegate?
    
    static var cellId = "salesCarouselCell"
    
    var homeStoreItem: HomeStoreItem? {
        didSet{
            updateCell()
        }
    }
    
    lazy var itemImageBackground: UIView = {
        let makeView = UIView()
        makeView.layer.cornerRadius = 10
        makeView.layer.masksToBounds = false
        makeView.layer.backgroundColor = UIColor.backgroundThemeColor?.cgColor
        makeView.layer.shadowColor = UIColor.backgroundThemeColor?.cgColor
        makeView.layer.shadowOpacity = 0
        makeView.layer.shadowRadius = 0
        makeView.layer.shadowOffset = .zero
        return makeView
    }()
    
    lazy var itemImage: UIImageView = {
        let makeImageView = UIImageView()
        makeImageView.layer.cornerRadius = 10
        makeImageView.layer.masksToBounds = true
        makeImageView.layer.backgroundColor = UIColor.white.cgColor
        makeImageView.contentMode = .scaleAspectFill
        return makeImageView
    }()
    
    lazy var dimView: UIView = {
        let makeView = UIView()
        makeView.layer.cornerRadius = 10
        makeView.layer.masksToBounds = false
        makeView.layer.backgroundColor = UIColor.black.cgColor
        makeView.alpha = 0.5
        return makeView
    }()
    
    lazy var buyButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = UIColor.backThemeColor
        config.background.cornerRadius = 5
        var container = AttributeContainer()
        container.font = UIFont.themeMarkProBold!.withSize(11.0)
        config.attributedTitle = AttributedString("Buy now!", attributes: container)
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var newView: NewLabelView = {
        let makeView = NewLabelView(isNew: false)
        makeView.shadowRadius = 0
        makeView.shadowColor = UIColor.backThemeColor ?? .black
        makeView.labelFont = UIFont.themeMarkProBold!.withSize(10.0)
        makeView.labelFontColor = .white
        makeView.backColor = UIColor.highlightThemeColor ?? .black
        return makeView
    }()
    
    lazy var newTitleLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProBold!.withSize(25.0)
        return makeLabel
    }()
    
    lazy var newSubtitleLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkPro!.withSize(11.0)
        return makeLabel
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
            make.size.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(itemImage)
        itemImage.snp.makeConstraints { (make) in
            make.size.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(dimView)
        dimView.snp.makeConstraints { (make) in
            make.size.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(newView)
        newView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 27, height: 27))
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.addSubview(newTitleLabel)
        newTitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalTo(newView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(newSubtitleLabel)
        newSubtitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(15)
            make.top.equalTo(newTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(buyButton)
        buyButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 98, height: 23))
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        buyButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
    }
    
    private func updateCell() {
        
        if let homeStoreItem = homeStoreItem {
            if let productImage = homeStoreItem.pictureUrl {
                itemImage.sd_setImage(with: productImage)
            }
            (newView as NewLabelView).isNew = homeStoreItem.isNew
            newTitleLabel.text = homeStoreItem.title
            newSubtitleLabel.text = homeStoreItem.subtitle
        }
    }
}

private extension SalesCarouselCell {
    
    @objc func buyButtonAction() {
        
        if let id = homeStoreItem?.id {
            delegate?.buySales(id: id)
        }
    }
}
