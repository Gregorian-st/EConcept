//
//  CartCustomCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 09.12.2022.
//

import UIKit
import SnapKit

protocol CartCustomCellDelegate: AnyObject {
    
    func deleteItem(itemNo: Int?)
    func increaseItemCount(itemNo: Int?)
    func decreaseItemCount(itemNo: Int?)
}

final class CartCustomCell: UITableViewCell {
    
    weak var delegate: CartCustomCellDelegate?
    
    static var cellId = "cartCustomCell"
    var cellNo: Int?

    lazy var itemImage: UIImageView = {
        let makeImageView = UIImageView()
        makeImageView.layer.cornerRadius = 10
        makeImageView.layer.masksToBounds = true
        makeImageView.layer.backgroundColor = UIColor.white.cgColor
        makeImageView.contentMode = .scaleAspectFit
        return makeImageView
    }()
    
    lazy var deleteButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "trash")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var incDecView: RoundedView = {
        let makeView = RoundedView()
        makeView.backColor = UIColor.backButtonThemeColor ?? .black
        makeView.cornerRadius = 13
        makeView.shadowOpacity = 0
        makeView.shadowRadius = 0
        makeView.visualEffect = nil
        return makeView
    }()
    
    lazy var increaseButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "plus")?.resizeImageTo(size: CGSizeMake(9.0, 9.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var decreaseButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "minus")?.resizeImageTo(size: CGSizeMake(9.0, 9.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var itemNameLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 2
        makeLabel.textColor = .white
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(20.0)
        return makeLabel
    }()
    
    lazy var itemPriceLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.highlightThemeColor
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(20.0)
        return makeLabel
    }()
    
    lazy var itemCountLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .center
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(20.0)
        return makeLabel
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.backThemeColor
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Program Logic

    private func setupUI() {
        
        self.addSubview(itemImage)
        itemImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 88, height: 88))
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().offset(33)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalToSuperview().inset(23)
        }
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        
        contentView.addSubview(incDecView)
        incDecView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 26, height: 68))
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-10)
        }
        
        contentView.addSubview(increaseButton)
        increaseButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self.snp.centerY).offset(20)
            make.centerX.equalTo(incDecView.snp.centerX)
        }
        increaseButton.addTarget(self, action: #selector(increaseButtonAction), for: .touchUpInside)
        
        contentView.addSubview(decreaseButton)
        decreaseButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(self.snp.centerY).offset(-20)
            make.centerX.equalTo(incDecView.snp.centerX)
        }
        decreaseButton.addTarget(self, action: #selector(decreaseButtonAction), for: .touchUpInside)
        
        self.addSubview(itemCountLabel)
        itemCountLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(incDecView.snp.centerX)
        }
        
        self.addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(itemImage.snp.top).offset(-5)
            make.leading.equalTo(itemImage.snp.trailing).offset(17)
            make.trailing.equalTo(incDecView.snp.leading).offset(-10)
            make.bottom.equalTo(itemImage.snp.bottom).inset(30)
        }
        
        self.addSubview(itemPriceLabel)
        itemPriceLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(itemImage.snp.trailing).offset(17)
            make.trailing.equalTo(incDecView.snp.leading).offset(-10)
            make.bottom.equalTo(itemImage.snp.bottom).inset(5)
        }
    }
}

private extension CartCustomCell {
    
    @objc func deleteButtonAction() {
        
        delegate?.deleteItem(itemNo: cellNo)
    }
    
    @objc func increaseButtonAction() {
        
        delegate?.increaseItemCount(itemNo: cellNo)
    }
    
    @objc func decreaseButtonAction() {
        
        delegate?.decreaseItemCount(itemNo: cellNo)
    }
}
