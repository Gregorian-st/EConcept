//
//  FilterSceneViewController.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//
//  ----------------------------------------------------------------------------------------
//  Important! As per specification it's required only to draw values.
//  In the production here must be defined pop-up buttons do let user select filter options.
//  ----------------------------------------------------------------------------------------

import UIKit

protocol FilterSceneViewControllerInput: AnyObject {
    
    func showFilterParameters(filterParameters: FilterParameters)
}

protocol FilterSceneViewControllerOutput: AnyObject {
    
    func showFilterParameters()
}

final class FilterSceneViewController: UIViewController {
    
    var interactor: FilterSceneInteractorInput?
    var router: FilterSceneRoutingProtocol?
    
    private var filterParameters: FilterParameters?
    
    lazy var backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.backThemeColor
        config.background.cornerRadius = 10
        config.image = UIImage(named: "cross")?.resizeImageTo(size: CGSizeMake(11.0, 11.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var doneButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.highlightThemeColor
        config.baseForegroundColor = .white
        config.background.cornerRadius = 10
        var container = AttributeContainer()
        container.font = UIFont.themeMarkProMedium!.withSize(18.0)
        config.attributedTitle = AttributedString("Done", attributes: container)
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var captionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .center
        makeLabel.text = "Filter options"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(18.0)
        return makeLabel
    }()
    
    lazy var brandCaptionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.text = "Brand"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(18.0)
        return makeLabel
    }()
    
    var brandBevelView: UIView = {
        let makeView = UIView()
        makeView.layer.borderWidth = 1.0
        makeView.layer.borderColor = UIColor.bevelThemeColor?.cgColor
        makeView.layer.cornerRadius = 5
        return makeView
    }()
    
    lazy var brandButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "dropDown")?.resizeImageTo(size: CGSizeMake(16.0, 16.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var brandLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkPro!.withSize(18.0)
        return makeLabel
    }()
    
    lazy var priceCaptionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.text = "Price"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(18.0)
        return makeLabel
    }()
    
    var priceBevelView: UIView = {
        let makeView = UIView()
        makeView.layer.borderWidth = 1.0
        makeView.layer.borderColor = UIColor.bevelThemeColor?.cgColor
        makeView.layer.cornerRadius = 5
        return makeView
    }()
    
    lazy var priceButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "dropDown")?.resizeImageTo(size: CGSizeMake(16.0, 16.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var priceLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkPro!.withSize(18.0)
        return makeLabel
    }()
    
    lazy var sizeCaptionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.text = "Size"
        makeLabel.font = UIFont.themeMarkProMedium!.withSize(18.0)
        return makeLabel
    }()
    
    var sizeBevelView: UIView = {
        let makeView = UIView()
        makeView.layer.borderWidth = 1.0
        makeView.layer.borderColor = UIColor.bevelThemeColor?.cgColor
        makeView.layer.cornerRadius = 5
        return makeView
    }()
    
    lazy var sizeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "dropDown")?.resizeImageTo(size: CGSizeMake(16.0, 16.0))
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    lazy var sizeLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkPro!.withSize(18.0)
        return makeLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        
        interactor?.showFilterParameters()
    }
}

private extension FilterSceneViewController {
    
    @objc func backButtonAction() {
        
        router?.closeFilterView()
    }
    
    @objc func doneButtonAction() {
        
        router?.closeFilterView()
    }
    
    func showFilter() {
        
        guard let filterParameters = filterParameters
        else { return }
        brandLabel.text = filterParameters.brand.first?.description ?? "-"
        priceLabel.text = filterParameters.price.first?.description ?? "-"
        sizeLabel.text = filterParameters.size.first?.description ?? "-"
    }
}

extension FilterSceneViewController: FilterSceneViewControllerInput {
    
    func showFilterParameters(filterParameters: FilterParameters) {
        
        self.filterParameters = filterParameters
        showFilter()
    }
}
