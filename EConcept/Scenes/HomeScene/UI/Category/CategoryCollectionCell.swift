//
//  CategoryCollectionCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import UIKit
import SnapKit

protocol CategoryCollectionCellDelegate: AnyObject {
    
    func didSelectCategory(id: Int)
}

final class CategoryCollectionCell: UICollectionViewCell {
    
    weak var delegate: CategoryCollectionCellDelegate?
    
    static var cellId = "categoryCollectionCell"
    
    var shopCategory: ShopCategory? {
        didSet {
            updateCell()
        }
    }
    
    lazy var categoryButton: CategorySelectButton = {
        let makeButton = CategorySelectButton()
        makeButton.selectedBackColor = UIColor.highlightThemeColor ?? .red
        makeButton.unselectedBackColor = .white
        makeButton.selectedImageColor = .white
        makeButton.unselectedImageColor = UIColor.iconThemeColor ?? .gray
        makeButton.imageWidth = 28
        makeButton.imageHeight = 28
        makeButton.shadowColor = UIColor.backThemeColor ?? .black
        makeButton.shadowOpacity = 0.05
        makeButton.shadowRadius = 5
        makeButton.shadowOffset = .zero
        return makeButton
    }()
    
    lazy var categoryLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textAlignment = .center
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(12.0)
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
        
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 71, height: 71))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        categoryButton.delegate = self
        
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryButton.snp.bottom).offset(10)
        }
        categoryButton.delegate = self
    }
    
    private func updateCell() {
        
        if let shopCategory = shopCategory {
            categoryButton.id = shopCategory.id
            categoryButton.selectedByUser = shopCategory.selected
            categoryLabel.text = shopCategory.description
            categoryLabel.textColor = shopCategory.selected ? UIColor.highlightThemeColor : UIColor.backThemeColor
            if let image = UIImage(named: shopCategory.imageString) {
                categoryButton.buttonImage = image
            }
        }
    }
}

extension CategoryCollectionCell : CategorySelectButtonDelegate {
    
    func didSelect(id: Int) {
        
        if let _ = shopCategory {
            shopCategory?.selected = true
            delegate?.didSelectCategory(id: shopCategory?.id ?? 0)
        }
    }
}
