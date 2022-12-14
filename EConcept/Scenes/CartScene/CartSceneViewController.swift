//
//  CartSceneViewController.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 07.12.2022.
//

import UIKit
import SnapKit

protocol CartSceneViewControllerInput: AnyObject {
    
    func showCart(cartTotal: CartTotal)
}

protocol CartSceneViewControllerOutput: AnyObject {
    
    func showCart()
}

final class CartSceneViewController: UIViewController {
    
    var interactor: CartSceneInteractorInput?
    var router: CartSceneRoutingProtocol?
    
    private let currencyFormatter: NumberFormatter = {
        let makeFormatter = NumberFormatter()
        makeFormatter.maximumFractionDigits = 2
        makeFormatter.minimumFractionDigits = 2
        makeFormatter.currencyCode = "USD"
        makeFormatter.numberStyle = .currency
        return makeFormatter
    }()
    
    private var cartTotal: CartTotal?
    
    lazy var backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.backThemeColor
        config.background.cornerRadius = 10
        config.image = UIImage(named: "back")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var locationButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.highlightThemeColor
        config.background.cornerRadius = 10
        config.image = UIImage(named: "pin")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var locationLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .right
        makeLabel.text = "Add address"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(15.0)
        return makeLabel
    }()
    
    lazy var myCartLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.text = "My Cart"
        makeLabel.font = UIFont.themeMarkProBold!.withSize(35.0)
        return makeLabel
    }()
    
    lazy var totalLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .left
        makeLabel.text = "Total"
        makeLabel.font = UIFont.themeMarkPro!.withSize(15.0)
        return makeLabel
    }()
    
    lazy var deliveryLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .left
        makeLabel.text = "Delivery"
        makeLabel.font = UIFont.themeMarkPro!.withSize(15.0)
        return makeLabel
    }()
    
    lazy var totalValueLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .right
        makeLabel.font = UIFont.themeMarkProBold!.withSize(15.0)
        return makeLabel
    }()
    
    lazy var deliveryValueLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = .white
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProBold!.withSize(15.0)
        return makeLabel
    }()
    
    lazy var detailsView: RoundedView = {
        let makeView = RoundedView()
        makeView.backColor = UIColor.backThemeColor ?? .black
        makeView.cornerRadius = 30
        makeView.shadowOpacity = 0
        makeView.shadowRadius = 0
        makeView.visualEffect = nil
        return makeView
    }()
    
    lazy var cartTableView: UITableView = {
        let makeTableView = UITableView()
        makeTableView.rowHeight = 134
        makeTableView.separatorStyle = .none
        makeTableView.showsVerticalScrollIndicator = false
        makeTableView.backgroundColor = UIColor.backThemeColor
        return makeTableView
    }()
    
    var lineView1: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 2))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.lineThemeColor?.cgColor
        return lineView
    }()
    
    var lineView2: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 2))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.lineThemeColor?.cgColor
        return lineView
    }()
    
    lazy var checkoutButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.highlightThemeColor
        config.baseForegroundColor = .white
        config.background.cornerRadius = 10
        config.buttonSize = .large
        var container = AttributeContainer()
        container.font = UIFont.themeMarkProBold!.withSize(20.0)
        config.attributedTitle = AttributedString("Checkout", attributes: container)
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        makeButton.titleLabel?.font = UIFont.themeMarkProBold!.withSize(20.0)
        return makeButton
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonAction), for: .touchUpInside)
        
        interactor?.showCart()
    }
}

private extension CartSceneViewController {
    
    @objc func backButtonAction() {
        
        router?.closeCartView()
    }
    
    @objc func locationButtonAction() {
        
        print(#function)
    }
    
    @objc func checkoutButtonAction() {
        
        print(#function)
    }
    
    func showCartTotal() {
        
        guard let cartTotal = cartTotal
        else { return }
        totalValueLabel.text = (currencyFormatter.string(for: cartTotal.total) ?? "0.00") + " us"
        deliveryValueLabel.text = cartTotal.delivery
        cartTableView.reloadData()
    }
}

extension CartSceneViewController: CartSceneViewControllerInput {
    
    func showCart(cartTotal: CartTotal) {
        
        self.cartTotal = cartTotal
        showCartTotal()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CartSceneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        cartTotal?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCustomCell.cellId, for: indexPath) as! CartCustomCell
        cell.delegate = self
        if let cartItem = cartTotal?.items[indexPath.row] {
            cell.cellNo = indexPath.row
            cell.itemImage.sd_setImage(with: cartItem.imageUrl)
            cell.itemNameLabel.text = cartItem.title
            cell.itemPriceLabel.text = currencyFormatter.string(for: cartItem.price) ?? "0.00"
            cell.itemCountLabel.text = String(format: "%1d", 1) // Count must be provided by API!
        }
        return cell
    }
}
