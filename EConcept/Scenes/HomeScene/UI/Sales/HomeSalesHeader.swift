//
//  HomeSalesHeader.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 12.12.2022.
//

import UIKit
import SnapKit

protocol HomeSalesHeaderDelegate: AnyObject {
    
    func seeMoreSales()
}

class HomeSalesHeader: UITableViewHeaderFooterView {
    
    weak var delegate: HomeSalesHeaderDelegate?

    static var headerId = "homeSalesHeader"
    
    lazy var captionBackground: UIView = {
        let makeView = UIView()
        makeView.layer.masksToBounds = false
        makeView.layer.backgroundColor = UIColor.backgroundThemeColor?.cgColor
        return makeView
    }()
    
    lazy var captionLabel: UILabel = {
        var makeLabel = UILabel()
        makeLabel.numberOfLines = 1
        makeLabel.textColor = UIColor.backThemeColor
        makeLabel.textAlignment = .left
        makeLabel.font = UIFont.themeMarkProBold!.withSize(25.0)
        makeLabel.text = "Hot Sales"
        return makeLabel
    }()
    
    lazy var captionButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor.highlightThemeColor
        var container = AttributeContainer()
        container.font = UIFont.themeMarkPro!.withSize(15.0)
        config.attributedTitle = AttributedString("see more", attributes: container)
        let makeButton = UIButton(type: .custom)
        makeButton.configuration = config
        return makeButton
    }()
    
    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Program Logic
    
    private func setupUI() {
        
        self.addSubview(captionBackground)
        captionBackground.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        captionBackground.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.leading.equalToSuperview().offset(20)
            make.verticalEdges.equalToSuperview()
        }
        
        captionBackground.addSubview(captionButton)
        captionButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.trailing.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview()
        }
        captionButton.addTarget(self, action: #selector(captionButtonAction), for: .touchUpInside)
    }
}

private extension HomeSalesHeader {
    
    @objc func captionButtonAction() {
        
        delegate?.seeMoreSales()
    }
}
