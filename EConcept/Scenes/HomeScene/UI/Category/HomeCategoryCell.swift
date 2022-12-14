//
//  HomeCategoryCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit
import SnapKit

protocol HomeCategoryCellDelegate: AnyObject {
    
    func startQR()
}

final class HomeCategoryCell: UITableViewCell {
    
    weak var delegate: HomeCategoryCellDelegate?
    
    static var cellId = "homeCategoryCell"
    
    var shopCategory: [ShopCategory] = [] {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    
    lazy var categoryCollectionView: UICollectionView = {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let fraction: CGFloat = 0.25
            let inset: CGFloat = 2
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .absolute(80))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            let groupHSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
            let groupH = NSCollectionLayoutGroup.horizontal(layoutSize: groupHSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: groupH)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            section.orthogonalScrollingBehavior = .continuous
            return UICollectionViewCompositionalLayout(section: section)
        }()
        let makeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                                  collectionViewLayout: compositionalLayout)
        makeCollectionView.showsHorizontalScrollIndicator = false
        makeCollectionView.showsVerticalScrollIndicator = false
        makeCollectionView.backgroundColor = UIColor.backgroundThemeColor
        return makeCollectionView
    }()
    
    lazy var searchView: RoundedView = {
        let makeView = RoundedView()
        makeView.backColor = .white
        makeView.cornerRadius = 17
        makeView.shadowOpacity = 0.02
        makeView.shadowRadius = 5
        makeView.shadowColor = UIColor.backThemeColor ?? .black
        makeView.visualEffect = nil
        return makeView
    }()
    
    lazy var searchImage: UIImageView = {
        let makeView = UIImageView()
        makeView.contentMode = .scaleAspectFit
        makeView.image = UIImage(named: "search")
        return makeView
    }()
    
    lazy var searchLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.grayThemeColor ?? .black
        makeLabel.textAlignment = .left
        makeLabel.text = "Search"
        makeLabel.font = UIFont.themeMarkPro!.withSize(12.0)
        return makeLabel
    }()
    
    lazy var qrButton: ColorSelectButton = {
        let makeButton = ColorSelectButton()
        makeButton.shadowOpacity = 0.02
        makeButton.shadowRadius = 5
        makeButton.shadowColor = UIColor.backThemeColor ?? .black
        makeButton.checkImage = UIImage(named: "qrcode")!
        makeButton.backColor = UIColor.highlightThemeColor ?? .black
        makeButton.selectedByUser = true
        return makeButton
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.backgroundThemeColor
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Program Logic
    
    private func setupUI() {
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.cellId)
        contentView.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        contentView.addSubview(qrButton)
        qrButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 34, height: 34))
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(10)
        }
        qrButton.delegate = self
        
        self.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.height.equalTo(34)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalTo(qrButton.snp.leading).offset(-10)
            make.centerY.equalTo(qrButton.snp.centerY)
        }
        
        self.addSubview(searchImage)
        searchImage.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.leading.equalTo(searchView.snp.leading).offset(26)
            make.centerY.equalTo(searchView.snp.centerY)
        }
        
        self.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(searchImage.snp.trailing).offset(15)
            make.centerY.equalTo(searchImage.snp.centerY)
        }
    }

}

private extension HomeCategoryCell {
    
    func qrButtonAction() {
        
        delegate?.startQR()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        shopCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.cellId,
                                                          for: indexPath) as! CategoryCollectionCell
        cell.shopCategory = shopCategory[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: - Delegates

extension HomeCategoryCell: ColorSelectButtonDelegate {
    
    func didSelect(id: Int, color: UIColor) {
        
        qrButtonAction()
    }
}

extension HomeCategoryCell: CategoryCollectionCellDelegate {
    
    func didSelectCategory(id: Int) {
        
        for i in 0..<shopCategory.count {
            shopCategory[i].selected = (shopCategory[i].id == id)
        }
        categoryCollectionView.reloadData()
    }
}
