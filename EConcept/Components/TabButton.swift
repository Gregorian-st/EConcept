//
//  TabButton.swift
//  EConcept
//
//  Created by Grigory Stolyarov on 11.12.2022.
//

import UIKit

protocol TabButtonDelegate: AnyObject {
    
    func didSelect(id: Int)
}

final class TabButton: UIView {
    
    weak var delegate: TabButtonDelegate?
    
    private var tabLabel = UILabel()
    private var backgroundView = UIView()
    private var lineView = UIView()
    
    var id: Int = 0
    
    var tabText: String = "Tab" {
        didSet {
            updateView()
        }
    }
    
    var selectedFont: UIFont = UIFont() {
        didSet {
            updateView()
        }
    }
    
    var unselectedFont: UIFont = UIFont() {
        didSet {
            updateView()
        }
    }
    
    var selectedLineColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var unselectedLineColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var selectedBackColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var unselectedBackColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    var selectedFontColor: UIColor = .black {
        didSet {
            updateView()
        }
    }
    
    var unselectedFontColor: UIColor = .gray {
        didSet {
            updateView()
        }
    }
    
    var selectedByUser: Bool = false {
        didSet {
            updateView()
        }
    }
    
    init(selectedByUser: Bool) {
        
        self.selectedByUser = selectedByUser
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override init(frame: CGRect) {
        
        super.init (frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder ) {
        
        super.init (coder: aDecoder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        setupView()
    }
    
    private func setupView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        backgroundView.layer.cornerRadius = 0
        backgroundView.layer.masksToBounds = false
        backgroundView.backgroundColor = selectedByUser ? selectedBackColor : unselectedBackColor
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.layer.borderWidth = 5
        let lineColor = selectedByUser ? selectedLineColor : unselectedLineColor
        lineView.layer.borderColor = lineColor.cgColor
        backgroundView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor),
            lineView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -2),
            lineView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        tabLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        tabLabel.numberOfLines = 1
        tabLabel.textAlignment = .center
        tabLabel.font = selectedByUser ? selectedFont : unselectedFont
        tabLabel.textColor = selectedByUser ? selectedFontColor : unselectedFontColor
        tabLabel.text = tabText
        
        self.addSubview(backgroundView)
        self.addSubview(tabLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tabButtonAction))
        addGestureRecognizer(tap)
     }
    
    private func updateView() {
        
        if self.frame == .zero {
            return
        }
        
        backgroundView.backgroundColor = selectedByUser ? selectedBackColor : unselectedBackColor
        tabLabel.font = selectedByUser ? selectedFont : unselectedFont
        tabLabel.textColor = selectedByUser ? selectedFontColor : unselectedFontColor
        tabLabel.text = tabText
        let lineColor = selectedByUser ? selectedLineColor : unselectedLineColor
        lineView.layer.borderColor = lineColor.cgColor
    }
    
    @objc func tabButtonAction() {
        
        selectedByUser = true
        delegate?.didSelect(id: id)
    }
}
