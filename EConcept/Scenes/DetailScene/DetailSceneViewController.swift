//
//  DetailSceneViewController.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 06.12.2022.
//

import UIKit

protocol DetailSceneViewControllerInput: AnyObject {
    
    func showProductDetails(product: ProductSmartphone)
}

protocol DetailSceneViewControllerOutput: AnyObject {
    
    func showProductDetails()
    func addToCart(product: ProductSmartphone)
}

final class DetailSceneViewController: UIViewController {
    
    var interactor: DetailSceneInteractorInput?
    var router: DetailSceneRoutingProtocol?
    
    private let currencyFormatter: NumberFormatter = {
        let makeFormatter = NumberFormatter()
        makeFormatter.maximumFractionDigits = 2
        makeFormatter.minimumFractionDigits = 2
        makeFormatter.currencyCode = "USD"
        makeFormatter.numberStyle = .currency
        return makeFormatter
    }()
    
    var containerButton: AttributeContainer = {
        let makeContainer = AttributeContainer()
        return makeContainer
    }()
    
    private var product: ProductSmartphone?
    
    lazy var backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.backThemeColor
        config.background.cornerRadius = 10
        config.image = UIImage(named: "back")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var cartButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.highlightThemeColor
        config.background.cornerRadius = 10
        config.image = UIImage(named: "bag")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var heartButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.backThemeColor
        config.background.cornerRadius = 10
        config.image = UIImage(named: "heart")?.resizeImageTo(size: CGSizeMake(17.0, 17.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var addToCartButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.highlightThemeColor
        config.baseForegroundColor = .white
        config.background.cornerRadius = 10
        config.buttonSize = .large
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        makeButton.titleLabel?.font = UIFont.themeMarkProBold!.withSize(20.0)
        return makeButton
    }()
    
    lazy var colorButton1 = ColorSelectButton()
    lazy var colorButton2 = ColorSelectButton()
    
    lazy var capacityButton1 = CapacitySelectButton()
    lazy var capacityButton2 = CapacitySelectButton()
    
    lazy var tabButton1 = TabButton()
    lazy var tabButton2 = TabButton()
    lazy var tabButton3 = TabButton()
    
    lazy var cpuImage = UIImageView()
    lazy var cpuText: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.grayThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "cpu"
        makeLabel.font = UIFont.themeMarkPro!.withSize(11.0)
        return makeLabel
    }()
    
    lazy var cameraImage = UIImageView()
    lazy var cameraText: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.grayThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "camera"
        makeLabel.font = UIFont.themeMarkPro!.withSize(11.0)
        return makeLabel
    }()
    
    lazy var ramImage = UIImageView()
    lazy var ramText: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.grayThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "ram"
        makeLabel.font = UIFont.themeMarkPro!.withSize(11.0)
        return makeLabel
    }()
    
    lazy var memoryImage = UIImageView()
    lazy var memoryText: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.grayThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "memory"
        makeLabel.font = UIFont.themeMarkPro!.withSize(11.0)
        return makeLabel
    }()
    
    lazy var captionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "Product Details"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(18.0)
        return makeLabel
    }()
    
    lazy var detailsCaptionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "Product Name"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(24.0)
        return makeLabel
    }()
    
    lazy var detailsOptionsLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "Select color and capacity"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(16.0)
        return makeLabel
    }()
    
    lazy var detailsView: RoundedView = {
        let makeView = RoundedView()
        makeView.backColor = .white
        makeView.cornerRadius = 30
        makeView.shadowColor = UIColor.backThemeColor ?? .black
        makeView.shadowOpacity = 0.05
        makeView.shadowRadius = 10
        makeView.visualEffect = nil
        return makeView
    }()
    
    lazy var starRatingView: StarRatingView = {
        let makeView = StarRatingView()
        makeView.starColor = UIColor.starThemeColor ?? .yellow
        makeView.starRounding = .roundToHalfStar
        makeView.isUserInteractionEnabled = false
        return makeView
    }()
    
    lazy var detailCarouselView: UICollectionView = {
        let makeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300),
                                                  collectionViewLayout: UICollectionViewLayout())
        makeCollectionView.showsHorizontalScrollIndicator = false
        makeCollectionView.backgroundColor = UIColor.backgroundThemeColor
        return makeCollectionView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(cartButtonAction), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonAction), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(heartButtonAction), for: .touchUpInside)
        
        interactor?.showProductDetails()
    }
}

private extension DetailSceneViewController {
    
    @objc func backButtonAction() {
        
        router?.closeDetailView()
    }
    
    @objc func cartButtonAction() {
        
        print(#function)
    }
    
    @objc func heartButtonAction() {
        
        print(#function)
    }
    
    @objc func addToCartButtonAction() {
        
        print(#function)
    }
    
    func showProduct() {
        
        guard let product = product
        else { return }
        
        let addToCartButtonCaption: String = "Add to cart \t" + (currencyFormatter.string(for: product.price) ?? "0.00")
        containerButton.font = UIFont.themeMarkProBold!.withSize(20.0)
        addToCartButton.configuration?.attributedTitle = AttributedString(addToCartButtonCaption,
                                                                          attributes: containerButton)
        detailsCaptionLabel.text = product.title
        starRatingView.rating = NSDecimalNumber(decimal: product.rating).floatValue
        if product.colorVariants.count > 0 {
            let color = product.colorVariants[0]
            colorButton1.selectedByUser = true
            colorButton1.backColor = color
        }
        if product.colorVariants.count > 1 {
            let color = product.colorVariants[1]
            colorButton2.selectedByUser = false
            colorButton2.backColor = color
        }
        if product.capacityVariants.count > 0 {
            let capacity = product.capacityVariants[0]
            capacityButton1.selectedByUser = true
            capacityButton1.capacityText = capacity + " GB"
        }
        if product.capacityVariants.count > 1 {
            let capacity = product.capacityVariants[1]
            capacityButton2.selectedByUser = false
            capacityButton2.capacityText = capacity + " GB"
        }
        tabButton1.selectedByUser = true
        cpuText.text = product.cpuType
        cameraText.text = product.cameraType
        ramText.text = product.ssd
        memoryText.text = product.sd
        
        detailCarouselView.reloadData()
    }
}

extension DetailSceneViewController: DetailSceneViewControllerInput {
    
    func showProductDetails(product: ProductSmartphone) {
        
        self.product = product
        showProduct()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DetailSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        product?.imagesUrl.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = detailCarouselView.dequeueReusableCell(withReuseIdentifier: DetailCarouselCell.cellId,
                                                          for: indexPath) as! DetailCarouselCell
        if let productImage = product?.imagesUrl[indexPath.row] {
            cell.itemImage.sd_setImage(with: productImage)
        }
        return cell
    }
}
