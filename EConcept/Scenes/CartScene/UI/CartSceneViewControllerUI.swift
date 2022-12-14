//
//  CartSceneViewControllerUI.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 08.12.2022.
//

import UIKit
import SnapKit

extension CartSceneViewController {
 
    func setupUI() {
        
        view.backgroundColor = UIColor.backgroundThemeColor
        
        setupCartDetailsView()
        drawLines()
        setupButtons()
        setupLabels()
        setupTableView()
    }

    private func setupCartDetailsView() {
        
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.top.equalToSuperview().offset(260)
        }
    }
    
    private func drawLines() {
        
        view.addSubview(lineView1)
        lineView1.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(self.view.snp.bottom).inset(215)
        }
        
        view.addSubview(lineView2)
        lineView2.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(self.view.snp.bottom).inset(125)
        }
    }
    
    private func setupButtons() {
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalToSuperview().offset(79)
            make.leading.equalToSuperview().offset(42)
        }
        
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalToSuperview().offset(79)
            make.trailing.equalToSuperview().inset(42)
        }
        
        view.addSubview(checkoutButton)
        checkoutButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(44)
            make.leading.equalToSuperview().offset(44)
        }
    }
    
    private func setupLabels() {
        
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.trailing.equalTo(locationButton.snp.leading).offset(-9)
            make.centerY.equalTo(locationButton.snp.centerY)
        }
        
        view.addSubview(myCartLabel)
        myCartLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(42)
            make.top.equalToSuperview().offset(166)
        }
        
        view.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(55)
            make.top.equalTo(lineView1.snp.top).offset(15)
        }
        
        view.addSubview(deliveryLabel)
        deliveryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(55)
            make.top.equalTo(lineView1.snp.top).offset(46)
        }
        
        view.addSubview(totalValueLabel)
        totalValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(31)
            make.bottom.equalTo(totalLabel.snp.bottom)
        }
        
        view.addSubview(deliveryValueLabel)
        deliveryValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(totalValueLabel.snp.leading)
            make.bottom.equalTo(deliveryLabel.snp.bottom)
        }
    }
    
    private func setupTableView() {
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(CartCustomCell.self, forCellReuseIdentifier: CartCustomCell.cellId)
        view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints { (make) in
            make.horizontalEdges.equalTo(detailsView.snp.horizontalEdges)
            make.top.equalTo(detailsView.snp.top).inset(30)
            make.bottom.equalTo(lineView1.snp.top)
        }
    }
}

// MARK: - Delegates

extension CartSceneViewController: CartCustomCellDelegate {
    
    func deleteItem(itemNo: Int?) {
        
        // TODO: In the production here must be the logic to delete item from the cart
        print(#function)
    }
    
    func increaseItemCount(itemNo: Int?) {
        
        // TODO: In the production here must be the logic to increase item count in the cart
        print(#function)
    }
    
    func decreaseItemCount(itemNo: Int?) {
        
        // TODO: In the production here must be the logic to decrease item count in the cart
        print(#function)
    }
}
