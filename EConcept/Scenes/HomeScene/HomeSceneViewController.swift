//
//  HomeSceneViewController.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 04.12.2022.
//

import UIKit
import SDWebImage


protocol HomeSceneViewControllerInput: AnyObject {
    
    func showMainData(homeItems: HomeItems)
    func showMainDataCart(cartTotal: CartTotal)
    func showMainDataFailure(message: String)
    func showProductDetails(product: ProductSmartphone)
    func showProductDetailsFailure(message: String)
    func showCart(cartTotal: CartTotal)
    func showCartFailure(message: String)
    func showNotImplemented(message: String)
}

protocol HomeSceneViewControllerOutput: AnyObject {
    
    func getMainData()
    func getProductDetails()
    func getCart()
}

final class HomeSceneViewController: UIViewController {
    
    var interactor: HomeSceneInteractorInput?
    var router: HomeSceneRoutingProtocol?
    
    private var homeItems: HomeItems?
    private var cartTotal: CartTotal?
    
    private var shopCategories: [ShopCategory] = [
        ShopCategory(id: 0, description: "Phones", imageString: "phone", selected: true),
        ShopCategory(id: 1, description: "Computer", imageString: "computer", selected: false),
        ShopCategory(id: 2, description: "Health", imageString: "health", selected: false),
        ShopCategory(id: 3, description: "Books", imageString: "books", selected: false)]
    
    private var filterParameters: FilterParameters = FilterParameters(
        brand: [BrandFilterParameters(id: 0, name: "Apple"),
                BrandFilterParameters(id: 1, name: "Samsung"),
                BrandFilterParameters(id: 2, name: "Xiaomi")],
        price: [PriceFilterParameters(id: 0, minPrice: 0, maxPrice: 100),
                PriceFilterParameters(id: 1, minPrice: 100, maxPrice: 300),
                PriceFilterParameters(id: 2, minPrice: 300, maxPrice: 500)],
        size: [SizeFilterParameters(id: 0, minSize: 0, maxSize: 3),
               SizeFilterParameters(id: 1, minSize: 3, maxSize: 5),
               SizeFilterParameters(id: 2, minSize: 5, maxSize: 7),
               SizeFilterParameters(id: 3, minSize: 7, maxSize: 11)]
    )
    
    lazy var menuView: RoundedView = {
        let makeView = RoundedView()
        makeView.backColor = UIColor.backThemeColor ?? .black
        makeView.cornerRadius = 30
        makeView.shadowOpacity = 0
        makeView.shadowRadius = 0
        makeView.visualEffect = nil
        return makeView
    }()
    
    lazy var countMenuView = CountView()
    
    lazy var accountMenuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "person")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var favoritesMenuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "heart")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var cartMenuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "bag")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var explorerMenuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "explorer")?.resizeImageTo(size: CGSizeMake(8.0, 8.0))
        config.baseForegroundColor = .white
        config.imagePadding = 8
        var container = AttributeContainer()
        container.font = UIFont.themeMarkProBold!.withSize(15.0)
        config.attributedTitle = AttributedString("Explorer", attributes: container)
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var filterButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "filter")?.resizeImageTo(size: CGSizeMake(13.0, 13.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var locationLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "Location"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(15.0)
        return makeLabel
    }()
    
    lazy var locationImage: UIImageView = {
        var makeImageView = UIImageView()
        makeImageView.image = UIImage(named: "pin")?.maskWithColor(color: UIColor.highlightThemeColor ?? .black)
        makeImageView.contentMode = .scaleAspectFit
        return makeImageView
    }()
    
    lazy var locationButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "dropDown")?.resizeImageTo(size: CGSizeMake(10.0, 10.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var homeTableView: UITableView = {
        let makeTableView = UITableView(frame: CGRectMake(0, 0, 100, 100), style: .grouped)
        makeTableView.separatorStyle = .none
        makeTableView.showsVerticalScrollIndicator = false
        makeTableView.backgroundColor = UIColor.backgroundThemeColor
        return makeTableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
        accountMenuButton.addTarget(self, action: #selector(accountMenuButtonAction), for: .touchUpInside)
        favoritesMenuButton.addTarget(self, action: #selector(favoritesMenuButtonAction), for: .touchUpInside)
        cartMenuButton.addTarget(self, action: #selector(cartMenuButtonAction), for: .touchUpInside)
        explorerMenuButton.addTarget(self, action: #selector(explorerMenuButtonAction), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
        
        interactor?.getMainData()
    }
}

private extension HomeSceneViewController {
    
    @objc func accountMenuButtonAction() {
        
        router?.showNotImplemented(message: #function)
    }
    
    @objc func favoritesMenuButtonAction() {
        
        router?.showNotImplemented(message: #function)
    }
    
    @objc func cartMenuButtonAction() {
        
        interactor?.getCart()
    }
    
    @objc func explorerMenuButtonAction() {
        
        router?.showNotImplemented(message: #function)
    }
    
    @objc func filterButtonAction() {
        
        router?.showFilterParameters(filterParameters: filterParameters)
    }
    
    @objc func locationButtonAction() {
        
        router?.showNotImplemented(message: #function)
    }
    
    func updateMainScreen() {
        
        // FIXME: Location must be acquired from the location service
        locationLabel.text = "Zihuatanejo, Gro"
        homeTableView.reloadData()
    }
    
    func updateMenu() {
        
        guard let cartTotal = cartTotal
        else { return }
        countMenuView.count = cartTotal.items.count
    }
}

extension HomeSceneViewController: HomeSceneViewControllerInput {
    
    func showMainData(homeItems: HomeItems) {
        
        self.homeItems = homeItems
        updateMainScreen()
    }
    
    func showMainDataCart(cartTotal: CartTotal) {
        
        self.cartTotal = cartTotal
        updateMenu()
    }
    
    func showMainDataFailure(message: String) {
        
        router?.showMainDataFailure(message: message)
    }
    
    func showProductDetails(product: ProductSmartphone) {
        
        router?.showProductDetails(product: product)
    }
    
    func showProductDetailsFailure(message: String) {
        
        router?.showProductDetailsFailure(message: message)
    }
    
    func showCart(cartTotal: CartTotal) {
        
        router?.showCart(cartTotal: cartTotal)
    }
    
    func showCartFailure(message: String) {
        
        router?.showCartFailure(message: message)
    }
    
    func showNotImplemented(message: String) {
        
        router?.showNotImplemented(message: message)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeSceneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 190
        case 1:
            return 200
        case 2:
            return 480
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeCategoryHeader.headerId) as? HomeCategoryHeader
            else { return nil }
            headerView.delegate = self
            return headerView
        case 1:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeSalesHeader.headerId) as? HomeSalesHeader
            else { return nil }
            headerView.delegate = self
            return headerView
        case 2:
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeBestHeader.headerId) as? HomeBestHeader
            else { return nil }
            headerView.delegate = self
            return headerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCategoryCell.cellId, for: indexPath) as! HomeCategoryCell
            cell.shopCategory = shopCategories
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeSalesCell.cellId, for: indexPath) as! HomeSalesCell
            if let homeItems = homeItems {
                cell.homeStoreItems = homeItems.homeStoreItems
            } else {
                cell.homeStoreItems = []
            }
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeBestCell.cellId, for: indexPath) as! HomeBestCell
            if let homeItems = homeItems {
                cell.bestSellerItems = homeItems.bestSellerItems
            } else {
                cell.bestSellerItems = []
            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}
