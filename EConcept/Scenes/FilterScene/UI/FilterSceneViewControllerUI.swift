//
//  FilterSceneViewControllerUI.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 13.12.2022.
//

import UIKit
import SnapKit

extension FilterSceneViewController {
    
    func setupUI() {
        
        view.backgroundColor = UIColor.backgroundThemeColor
        
        setupButtons()
        setupLabels()
        setupBrand()
        setupPrice()
        setupSize()
    }
    
    private func setupButtons() {
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(44)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 86, height: 37))
            make.centerY.equalTo(backButton.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupLabels() {
        
        view.addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing)
            make.trailing.equalTo(doneButton.snp.leading)
            make.centerY.equalTo(backButton.snp.centerY)
        }
    }
    
    private func setupBrand() {
        
        view.addSubview(brandCaptionLabel)
        brandCaptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(46)
            make.top.equalTo(backButton.snp.bottom).offset(40)
        }
        
        view.addSubview(brandBevelView)
        brandBevelView.snp.makeConstraints { make in
            make.height.equalTo(37)
            make.leading.equalTo(brandCaptionLabel.snp.leading)
            make.trailing.equalToSuperview().inset(30)
            make.top.equalTo(brandCaptionLabel.snp.bottom).offset(5)
        }
        
        view.addSubview(brandButton)
        brandButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.trailing.equalTo(brandBevelView.snp.trailing).inset(5)
            make.centerY.equalTo(brandBevelView.snp.centerY)
        }
        
        view.addSubview(brandLabel)
        brandLabel.snp.makeConstraints { make in
            make.leading.equalTo(brandBevelView.snp.leading).offset(15)
            make.trailing.equalTo(brandButton.snp.leading).inset(15)
            make.centerY.equalTo(brandBevelView.snp.centerY)
        }
    }
    
    private func setupPrice() {
        
        view.addSubview(priceCaptionLabel)
        priceCaptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(46)
            make.top.equalTo(backButton.snp.bottom).offset(120)
        }
        
        view.addSubview(priceBevelView)
        priceBevelView.snp.makeConstraints { make in
            make.height.equalTo(37)
            make.leading.equalTo(priceCaptionLabel.snp.leading)
            make.trailing.equalToSuperview().inset(30)
            make.top.equalTo(priceCaptionLabel.snp.bottom).offset(5)
        }
        
        view.addSubview(priceButton)
        priceButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.trailing.equalTo(priceBevelView.snp.trailing).inset(5)
            make.centerY.equalTo(priceBevelView.snp.centerY)
        }
        
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceBevelView.snp.leading).offset(15)
            make.trailing.equalTo(priceButton.snp.leading).inset(15)
            make.centerY.equalTo(priceBevelView.snp.centerY)
        }
    }
    
    private func setupSize() {
        
        view.addSubview(sizeCaptionLabel)
        sizeCaptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(46)
            make.top.equalTo(backButton.snp.bottom).offset(200)
        }
        
        view.addSubview(sizeBevelView)
        sizeBevelView.snp.makeConstraints { make in
            make.height.equalTo(37)
            make.leading.equalTo(sizeCaptionLabel.snp.leading)
            make.trailing.equalToSuperview().inset(30)
            make.top.equalTo(sizeCaptionLabel.snp.bottom).offset(5)
        }
        
        view.addSubview(sizeButton)
        sizeButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 37, height: 37))
            make.trailing.equalTo(sizeBevelView.snp.trailing).inset(5)
            make.centerY.equalTo(sizeBevelView.snp.centerY)
        }
        
        view.addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints { make in
            make.leading.equalTo(sizeBevelView.snp.leading).offset(15)
            make.trailing.equalTo(sizeButton.snp.leading).inset(15)
            make.centerY.equalTo(sizeBevelView.snp.centerY)
        }
    }
}
