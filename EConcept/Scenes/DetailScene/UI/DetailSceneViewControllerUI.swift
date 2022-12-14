//
//  DetailSceneViewControllerUI.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 09.12.2022.
//

import UIKit
import SnapKit

extension DetailSceneViewController {
    
    func setupUI() {
        
        view.backgroundColor = UIColor.backgroundThemeColor
        
        setupDetailsView()
        setupButtons()
        setupLabels()
        setupOptions()
        setupStarRatingView()
        setupCarouselView()
    }
    
    private func setupDetailsView() {
        
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: Int(view.bounds.width), height: 400))
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupStarRatingView() {
        
        view.addSubview(starRatingView)
        starRatingView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 140, height: 18))
            make.leading.equalToSuperview().offset(37)
            make.top.equalTo(detailsCaptionLabel.snp.bottom).offset(5)
        }
    }
    
    private func setupCarouselView() {
        
        detailCarouselView.delegate = self
        detailCarouselView.dataSource = self
        detailCarouselView.register(DetailCarouselCell.self, forCellWithReuseIdentifier: DetailCarouselCell.cellId)
        view.addSubview(detailCarouselView)
        detailCarouselView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(cartButton.snp.bottom).offset(10)
            make.bottom.equalTo(detailsView.snp.top).offset(-15)
        }
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: detailCarouselView.bounds.width, height: detailCarouselView.bounds.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 0.4
        flowLayout.spacingMode = .fixed(spacing: 5)
        detailCarouselView.collectionViewLayout = flowLayout
    }
    
    private func setupButtons() {
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalToSuperview().offset(79)
            make.leading.equalToSuperview().offset(42)
        }
        
        view.addSubview(cartButton)
        cartButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalToSuperview().offset(79)
            make.trailing.equalToSuperview().inset(42)
        }
        
        view.addSubview(heartButton)
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalTo(detailsView.snp.top).offset(25)
            make.trailing.equalTo(detailsView.snp.trailing).inset(42)
        }
        
        view.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(29)
            make.leading.equalToSuperview().offset(29)
        }
        
        view.addSubview(colorButton1)
        colorButton1.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.leading.equalToSuperview().offset(29)
            make.bottom.equalTo(addToCartButton.snp.top).offset(-20)
        }
        colorButton1.id = 0
        colorButton1.shadowRadius = 0
        colorButton1.delegate = self
        
        view.addSubview(colorButton2)
        colorButton2.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.leading.equalTo(colorButton1.snp.trailing).offset(20)
            make.bottom.equalTo(addToCartButton.snp.top).offset(-20)
        }
        colorButton2.id = 1
        colorButton2.shadowRadius = 0
        colorButton2.delegate = self
        
        view.addSubview(capacityButton2)
        capacityButton2.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 71, height: 30))
            make.trailing.equalToSuperview().offset(-49)
            make.centerY.equalTo(colorButton1.snp.centerY)
        }
        capacityButton2.id = 1
        capacityButton2.shadowRadius = 0
        capacityButton2.capacityFont = UIFont.themeMarkProBold!.withSize(13.0)
        capacityButton2.selectedFontColor = .white
        capacityButton2.unselectedFontColor = UIColor.grayThemeColor ?? .gray
        capacityButton2.selectedBackColor = UIColor.highlightThemeColor ?? .black
        capacityButton2.unselectedBackColor = .white
        capacityButton2.delegate = self
        
        view.addSubview(capacityButton1)
        capacityButton1.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 71, height: 30))
            make.trailing.equalTo(capacityButton2.snp.leading).offset(-15)
            make.centerY.equalTo(colorButton1.snp.centerY)
        }
        capacityButton1.id = 0
        capacityButton1.shadowRadius = 0
        capacityButton1.shadowColor = .white
        capacityButton1.capacityFont = UIFont.themeMarkProBold!.withSize(13.0)
        capacityButton1.selectedFontColor = .white
        capacityButton1.unselectedFontColor = UIColor.grayThemeColor ?? .gray
        capacityButton1.selectedBackColor = UIColor.highlightThemeColor ?? .black
        capacityButton1.unselectedBackColor = .white
        capacityButton1.delegate = self
        
        view.addSubview(tabButton1)
        tabButton1.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 90, height: 35))
            make.leading.equalTo(detailsView.snp.leading).offset(30)
            make.top.equalTo(detailsView.snp.top).offset(100)
        }
        tabButton1.id = 0
        tabButton1.selectedFont = UIFont.themeMarkProBold!.withSize(20.0)
        tabButton1.unselectedFont = UIFont.themeMarkPro!.withSize(20.0)
        tabButton1.selectedFontColor = UIColor.backThemeColor ?? .black
        tabButton1.unselectedFontColor = UIColor.grayThemeColor ?? .gray
        tabButton1.selectedLineColor = UIColor.highlightThemeColor ?? .black
        tabButton1.unselectedLineColor = .white
        tabButton1.selectedBackColor = .white
        tabButton1.unselectedBackColor = .white
        tabButton1.tabText = "Shop"
        tabButton1.delegate = self
        
        view.addSubview(tabButton2)
        tabButton2.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 90, height: 35))
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabButton1.snp.centerY)
        }
        tabButton2.id = 1
        tabButton2.selectedFont = UIFont.themeMarkProBold!.withSize(20.0)
        tabButton2.unselectedFont = UIFont.themeMarkPro!.withSize(20.0)
        tabButton2.selectedFontColor = UIColor.backThemeColor ?? .black
        tabButton2.unselectedFontColor = UIColor.grayThemeColor ?? .gray
        tabButton2.selectedLineColor = UIColor.highlightThemeColor ?? .black
        tabButton2.unselectedLineColor = .white
        tabButton2.selectedBackColor = .white
        tabButton2.unselectedBackColor = .white
        tabButton2.tabText = "Details"
        tabButton2.delegate = self
        
        view.addSubview(tabButton3)
        tabButton3.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 90, height: 35))
            make.trailing.equalTo(detailsView.snp.trailing).inset(30)
            make.centerY.equalTo(tabButton1.snp.centerY)
        }
        tabButton3.id = 2
        tabButton3.selectedFont = UIFont.themeMarkProBold!.withSize(20.0)
        tabButton3.unselectedFont = UIFont.themeMarkPro!.withSize(20.0)
        tabButton3.selectedFontColor = UIColor.backThemeColor ?? .black
        tabButton3.unselectedFontColor = UIColor.grayThemeColor ?? .gray
        tabButton3.selectedLineColor = UIColor.highlightThemeColor ?? .black
        tabButton3.unselectedLineColor = .white
        tabButton3.selectedBackColor = .white
        tabButton3.unselectedBackColor = .white
        tabButton3.tabText = "Features"
        tabButton3.delegate = self
    }
    
    private func setupLabels() {
        
        view.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(cartButton.snp.centerY)
        }
        
        view.addSubview(detailsCaptionLabel)
        detailsCaptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(detailsView.snp.leading).offset(37)
            make.trailing.equalTo(heartButton.snp.leading).offset(-10)
            make.centerY.equalTo(heartButton.snp.centerY)
        }
        
        view.addSubview(detailsOptionsLabel)
        detailsOptionsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(29)
            make.bottom.equalTo(colorButton1.snp.top).offset(-15)
        }
    }
    
    private func setupOptions() {
        
        let imageWidth = 24
        
        let optionsStackView = UIStackView()
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.axis = .horizontal
        
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .equalCentering
        
        let stackViewCPU = UIStackView()
        stackViewCPU.translatesAutoresizingMaskIntoConstraints = false
        stackViewCPU.axis = .vertical
        stackViewCPU.spacing = 5
        cpuImage.contentMode = .center
        cpuImage.image = UIImage(named: "cpu")?.resizeImageTo(size: CGSize(width: imageWidth, height: imageWidth))
        stackViewCPU.addArrangedSubview(cpuImage)
        stackViewCPU.addArrangedSubview(cpuText)
        
        let stackViewCamera = UIStackView()
        stackViewCamera.translatesAutoresizingMaskIntoConstraints = false
        stackViewCamera.axis = .vertical
        stackViewCamera.spacing = 5
        cameraImage.contentMode = .center
        cameraImage.image = UIImage(named: "camera")?.resizeImageTo(size: CGSize(width: imageWidth, height: imageWidth))
        stackViewCamera.addArrangedSubview(cameraImage)
        stackViewCamera.addArrangedSubview(cameraText)
        
        let stackViewRam = UIStackView()
        stackViewRam.translatesAutoresizingMaskIntoConstraints = false
        stackViewRam.axis = .vertical
        stackViewRam.spacing = 5
        ramImage.contentMode = .center
        ramImage.image = UIImage(named: "ram")?.resizeImageTo(size: CGSize(width: imageWidth, height: imageWidth))
        stackViewRam.addArrangedSubview(ramImage)
        stackViewRam.addArrangedSubview(ramText)
        
        let stackViewMemory = UIStackView()
        stackViewMemory.translatesAutoresizingMaskIntoConstraints = false
        stackViewMemory.axis = .vertical
        stackViewMemory.spacing = 5
        memoryImage.contentMode = .center
        memoryImage.image = UIImage(named: "memory")?.resizeImageTo(size: CGSize(width: imageWidth, height: imageWidth))
        stackViewMemory.addArrangedSubview(memoryImage)
        stackViewMemory.addArrangedSubview(memoryText)
        
        optionsStackView.addArrangedSubview(stackViewCPU)
        optionsStackView.addArrangedSubview(stackViewCamera)
        optionsStackView.addArrangedSubview(stackViewRam)
        optionsStackView.addArrangedSubview(stackViewMemory)
        
        view.addSubview(optionsStackView)
        optionsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(tabButton1.snp.bottom).offset(25)
            make.centerX.equalTo(detailsView.snp.centerX)
        }
    }
}

// MARK: - Delegates

extension DetailSceneViewController: ColorSelectButtonDelegate {
    
    func didSelect(id: Int, color: UIColor) {
        
        // TODO: In the production here must be the logic to change and store selected product settings
        switch id {
        case 0: colorButton2.selectedByUser = false
        case 1: colorButton1.selectedByUser = false
        default: return
        }
    }
}

extension DetailSceneViewController: CapacitySelectButtonDelegate {
    
    func didSelect(id: Int, capacity: String) {
        
        // TODO: In the production here must be the logic to change and store selected product settings
        switch id {
        case 0: capacityButton2.selectedByUser = false
        case 1: capacityButton1.selectedByUser = false
        default: return
        }
    }
}

extension DetailSceneViewController: TabButtonDelegate {
    
    func didSelect(id: Int) {
        
        // TODO: In the production here must be the logic to show product details etc.
        switch id {
        case 0:
            tabButton2.selectedByUser = false
            tabButton3.selectedByUser = false
        case 1:
            tabButton1.selectedByUser = false
            tabButton3.selectedByUser = false
        case 2:
            tabButton1.selectedByUser = false
            tabButton2.selectedByUser = false
        default: return
        }
    }
}
