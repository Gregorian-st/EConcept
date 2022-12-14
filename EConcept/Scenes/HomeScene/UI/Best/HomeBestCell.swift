//
//  HomeBestCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit
import SnapKit

protocol HomeBestCellDelegate: AnyObject {
    
    func buyBest(id: Int)
    func changeFavorites(id: Int, isFavorites: Bool)
}

final class HomeBestCell: UITableViewCell {
    
    weak var delegate: HomeBestCellDelegate?
    
    static var cellId = "homeBestCell"
    
    var bestSellerItems: [BestSellerItem] = [] {
        didSet {
            bestCollectionView.reloadData()
        }
    }
    
    lazy var bestCollectionView: UICollectionView = {
        let compositionalLayout: UICollectionViewCompositionalLayout = {
            let fraction: CGFloat = 0.5
            let inset: CGFloat = 0
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .absolute(230))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            let groupHSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(230))
            let groupH = NSCollectionLayoutGroup.horizontal(layoutSize: groupHSize, subitems: [item])
            let groupVSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let groupV = NSCollectionLayoutGroup.vertical(layoutSize: groupVSize, subitems: [groupH, groupH])
            let section = NSCollectionLayoutSection(group: groupV)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            section.orthogonalScrollingBehavior = .groupPaging
            return UICollectionViewCompositionalLayout(section: section)
        }()
        let makeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                                  collectionViewLayout: compositionalLayout)
        makeCollectionView.showsHorizontalScrollIndicator = false
        makeCollectionView.showsVerticalScrollIndicator = false
        makeCollectionView.backgroundColor = UIColor.backgroundThemeColor
        return makeCollectionView
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
        
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        bestCollectionView.register(BestCollectionCell.self, forCellWithReuseIdentifier: BestCollectionCell.cellId)
        contentView.addSubview(bestCollectionView)
        bestCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeBestCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        bestSellerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = bestCollectionView.dequeueReusableCell(withReuseIdentifier: BestCollectionCell.cellId,
                                                          for: indexPath) as! BestCollectionCell
        cell.bestSellerItem = bestSellerItems[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: - Delegates

extension HomeBestCell: BestCollectionCellDelegate {
    
    func buyBest(id: Int) {
        
        delegate?.buyBest(id: id)
    }
    
    func changeFavorites(id: Int, isFavorites: Bool) {
        
        delegate?.changeFavorites(id: id, isFavorites: isFavorites)
    }
}
