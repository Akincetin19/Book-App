//
//  TableViewFooter.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import UIKit


class TableFooter: UITableViewHeaderFooterView {
    static let identifier = "TableFooter"
    var bindIsClicked = Bindable<Bool>()
    private let view: UIView = {
       
        let view = UIView(frame: .zero)
        view.layer.borderColor = CGColor.init(red: 71/255, green: 78/255, blue: 104/255, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let label: UILabel = {
       
        let label = UILabel()
        label.text = "Sipariş Özeti"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
        
    }()
    var subLabel: UILabel = {
       
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
        
    }()
    
    private var priceLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Ödenecek Tutar"
        label.font = .systemFont(ofSize: 16)
        return label
        
    }()
    var totalPriceLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .red
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .right
        return label
        
    }()
    
    private let lineView: UIView = {
       
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(red: 71/255, green: 78/255, blue: 104/255, alpha: 1)
        
        return view
    }()
    private let buyButton: UIButton = {
       
        let button = UIButton(frame: .zero)
        button.setTitle("Satın Al", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(view)
        view.addSubview(label)
        view.addSubview(subLabel)
        view.addSubview(lineView)
        view.addSubview(priceLabel)
        view.addSubview(totalPriceLabel)
        view.addSubview(buyButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        label.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        subLabel.anchor(top: label.bottomAnchor, leading: label.leadingAnchor, bottom: nil, trailing: label.trailingAnchor)
        lineView.anchor(top: subLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 1))
        priceLabel.anchor(top: lineView.bottomAnchor, leading: lineView.leadingAnchor, bottom: nil, trailing: lineView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 200))
        totalPriceLabel.anchor(top: lineView.bottomAnchor, leading: priceLabel.trailingAnchor, bottom: nil, trailing: lineView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        buyButton.anchor(top: priceLabel.bottomAnchor, leading: lineView.leadingAnchor, bottom: view.bottomAnchor, trailing: lineView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 0), size: .init(width: 0, height: 50))
        
        buyButton.addTarget(self, action: #selector(buyButtonClicked), for: .touchUpInside)
        
    }
    @objc fileprivate func buyButtonClicked() {
        self.bindIsClicked.value = true
    }
}
