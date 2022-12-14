//
//  HomeSalesCell.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit
import SnapKit

protocol HomeSalesCellDelegate: AnyObject {
    
    func buySales(id: Int)
}

final class HomeSalesCell: UITableViewCell {
    
    weak var delegate: HomeSalesCellDelegate?
    
    static var cellId = "homeSalesCell"
    
    var homeStoreItems: [HomeStoreItem] = [] {
        didSet {
            salesCarouselView.reloadData()
        }
    }
    
    lazy var salesCarouselView: UICollectionView = {
        let makeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                                  collectionViewLayout: UICollectionViewLayout())
        makeCollectionView.showsHorizontalScrollIndicator = false
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
        
        salesCarouselView.delegate = self
        salesCarouselView.dataSource = self
        salesCarouselView.register(SalesCarouselCell.self, forCellWithReuseIdentifier: SalesCarouselCell.cellId)
        contentView.addSubview(salesCarouselView)
        salesCarouselView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: salesCarouselView.bounds.width * 1.2, height: 182)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.95
        flowLayout.sideItemAlpha = 0.8
        flowLayout.spacingMode = .fixed(spacing: 20)
        salesCarouselView.collectionViewLayout = flowLayout
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeSalesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        homeStoreItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = salesCarouselView.dequeueReusableCell(withReuseIdentifier: SalesCarouselCell.cellId,
                                                          for: indexPath) as! SalesCarouselCell
        cell.homeStoreItem = homeStoreItems[indexPath.row]
        cell.delegate = self
        return cell
    }
}

// MARK: - Delegates

extension HomeSalesCell: SalesCarouselCellDelegate {
    
    func buySales(id: Int) {
        
        delegate?.buySales(id: id)
    }
}
