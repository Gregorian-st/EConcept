//
//  BestCollectionCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit
import SnapKit

protocol BestCollectionCellDelegate: AnyObject {
    
    func buyBest(id: Int)
    func changeFavorites(id: Int, isFavorites: Bool)
}

final class BestCollectionCell: UICollectionViewCell {
    
    weak var delegate: BestCollectionCellDelegate?
    
    static var cellId = "bestCollectionCell"
    
    private let currencyFormatter: NumberFormatter = {
        let makeFormatter = NumberFormatter()
        makeFormatter.maximumFractionDigits = 0
        makeFormatter.minimumFractionDigits = 0
        makeFormatter.currencyCode = "USD"
        makeFormatter.numberStyle = .currency
        return makeFormatter
    }()
    
    var bestSellerItem: BestSellerItem? {
        didSet{
            updateCell()
        }
    }
    
    lazy var itemBackground: UIView = {
        let makeView = UIView()
        makeView.layer.cornerRadius = 10
        makeView.layer.masksToBounds = false
        makeView.layer.backgroundColor = UIColor.white.cgColor
        makeView.layer.shadowColor = UIColor.backThemeColor?.cgColor
        makeView.layer.shadowOpacity = 0.04
        makeView.layer.shadowRadius = 4
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
    
    lazy var likeButton: LikeButton = {
        let makeButton = LikeButton(isLiked: false)
        makeButton.imageColor = UIColor.highlightThemeColor ?? .red
        makeButton.imageWidth = 14
        makeButton.imageHeight = 12
        makeButton.shadowColor = UIColor.backThemeColor ?? .black
        makeButton.shadowOpacity = 0.1
        makeButton.shadowRadius = 5
        makeButton.shadowOffset = .zero
        return makeButton
    }()
    
    lazy var discountPriceLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor ?? .black
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProBold!.withSize(16.0)
        return makeLabel
    }()
    
    lazy var priceLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .systemGray4
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(10.0)
        return makeLabel
    }()
    
    lazy var titleLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor ?? .black
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkPro!.withSize(10.0)
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
        
        self.addSubview(itemBackground)
        itemBackground.snp.makeConstraints { (make) in
            make.size.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(itemImage)
        itemImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(30)
            make.height.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(itemBackground.snp.top).offset(10)
            make.trailing.equalTo(itemBackground.snp.trailing).offset(-10)
        }
        likeButton.delegate = self
        
        self.addSubview(discountPriceLabel)
        discountPriceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(itemImage.snp.bottom)
        }
        
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(discountPriceLabel.snp.trailing).offset(5)
            make.bottom.equalTo(discountPriceLabel.snp.bottom)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.width.equalToSuperview().inset(20)
            make.top.equalTo(discountPriceLabel.snp.bottom)
        }
    }
    
    private func updateCell() {
        
        if let bestSellerItem = bestSellerItem {
            if let productImage = bestSellerItem.pictureUrl {
                itemImage.sd_setImage(with: productImage)
            }
            likeButton.isLiked = bestSellerItem.isFavorites
            discountPriceLabel.text = currencyFormatter.string(for: bestSellerItem.priceWithoutDiscount) ?? "0.00"
            let price = currencyFormatter.string(for: bestSellerItem.discountPrice) ?? "0.00"
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: price)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: 1,
                                         range: NSRange(location: 0, length: attributeString.length))
            priceLabel.attributedText = attributeString
            titleLabel.text = bestSellerItem.title
        }
    }
}

extension BestCollectionCell: LikeButtonDelegate {
    
    func didLike(isLiked: Bool) {
        
        guard let _ = bestSellerItem
        else { return }
        bestSellerItem?.isFavorites = isLiked
        if let id = bestSellerItem?.id,
           let isFavorites = bestSellerItem?.isFavorites {
            delegate?.changeFavorites(id: id, isFavorites: isFavorites)
        }
    }
}
