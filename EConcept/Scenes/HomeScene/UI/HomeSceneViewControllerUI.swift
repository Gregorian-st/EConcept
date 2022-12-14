//
//  HomeSceneViewControllerUI.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 11.12.2022.
//

import UIKit
import SnapKit

extension HomeSceneViewController {
    
    func setupUI() {
        
        view.backgroundColor = UIColor.backgroundThemeColor
        
        setupButtons()
        setupLabels()
        setupMainTableView()
        setupBottomMenu()
    }
    
    private func setupBottomMenu() {
        
        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(accountMenuButton)
        accountMenuButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.centerY.equalTo(menuView.snp.centerY)
            make.trailing.equalTo(menuView.snp.trailing).inset(54)
        }
        
        view.addSubview(favoritesMenuButton)
        favoritesMenuButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.centerY.equalTo(menuView.snp.centerY)
            make.trailing.equalTo(accountMenuButton.snp.leading).offset(-30)
        }
        
        view.addSubview(cartMenuButton)
        cartMenuButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.centerY.equalTo(menuView.snp.centerY)
            make.trailing.equalTo(favoritesMenuButton.snp.leading).offset(-30)
        }
        
        view.addSubview(countMenuView)
        countMenuView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.centerX.equalTo(cartMenuButton.snp.centerX).offset(9)
            make.centerY.equalTo(cartMenuButton.snp.centerY).offset(-9)
        }
        countMenuView.shadowRadius = 0
        countMenuView.shadowColor = UIColor.backThemeColor ?? .black
        countMenuView.countFont = UIFont.themeMarkProBold!.withSize(9.0)
        countMenuView.countFontColor = .white
        countMenuView.backColor = UIColor.highlightThemeColor ?? .black
        
        view.addSubview(explorerMenuButton)
        explorerMenuButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 110, height: 37))
            make.centerY.equalTo(menuView.snp.centerY)
            make.leading.equalTo(menuView.snp.leading).offset(44)
        }
    }
    
    private func setupButtons() {
        
        view.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalToSuperview().offset(47)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupLabels() {
        
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(filterButton.snp.centerY)
        }
        
        view.addSubview(locationImage)
        locationImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.trailing.equalTo(locationLabel.snp.leading).offset(-10)
            make.centerY.equalTo(locationLabel.snp.centerY)
        }
        
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.leading.equalTo(locationLabel.snp.trailing)
            make.centerY.equalTo(locationLabel.snp.centerY).offset(2)
        }
    }
    
    private func setupMainTableView() {
     
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(HomeCategoryHeader.self, forHeaderFooterViewReuseIdentifier: HomeCategoryHeader.headerId)
        homeTableView.register(HomeCategoryCell.self, forCellReuseIdentifier: HomeCategoryCell.cellId)
        homeTableView.register(HomeSalesHeader.self, forHeaderFooterViewReuseIdentifier: HomeSalesHeader.headerId)
        homeTableView.register(HomeSalesCell.self, forCellReuseIdentifier: HomeSalesCell.cellId)
        homeTableView.register(HomeBestHeader.self, forHeaderFooterViewReuseIdentifier: HomeBestHeader.headerId)
        homeTableView.register(HomeBestCell.self, forCellReuseIdentifier: HomeBestCell.cellId)
        view.addSubview(homeTableView)
        homeTableView.snp.makeConstraints { (make) in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(filterButton.snp.bottom)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

// MARK: - Delegates

extension HomeSceneViewController: HomeCategoryHeaderDelegate {
    
    func viewAllCategories() {
        
        router?.showNotImplemented(message: #function)
    }
}

extension HomeSceneViewController: HomeCategoryCellDelegate {
    
    func startQR() {
        
        router?.showNotImplemented(message: #function)
    }
}

extension HomeSceneViewController: HomeSalesHeaderDelegate {
    
    func seeMoreSales() {
        
        router?.showNotImplemented(message: #function)
    }
}

extension HomeSceneViewController: HomeSalesCellDelegate {
    
    func buySales(id: Int) {
        
        // FIXME: In production, here we must pass Product ID to get details for the selected product
        interactor?.getProductDetails()
    }
}

extension HomeSceneViewController: HomeBestHeaderDelegate {
    
    func seeMoreBest() {
        
        router?.showNotImplemented(message: #function)
    }
}

extension HomeSceneViewController: HomeBestCellDelegate {
    
    func buyBest(id: Int) {
        
        // FIXME: In production, here we must pass Product ID to get details for the selected product
        interactor?.getProductDetails()
    }
    
    func changeFavorites(id: Int, isFavorites: Bool) {
        
        // FIXME: In production, here we must send to backend favorites change for the product
        print(#function)
    }
}
