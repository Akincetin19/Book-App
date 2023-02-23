//
//  TableViewFooter.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import UIKit


class TableFooter: UITableViewHeaderFooterView {
    static let identifier = "TableFooter"
    
    private let label: UILabel = {
       
        let label = UILabel()
        label.text = "Deneme"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .left
        return label
        
    }()
    private let subLabel: UILabel = {
       
        let label = UILabel()
        label.text = "Deneme2"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .left
        return label
        
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(subLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        subLabel.sizeToFit()
        let height = contentView.frame.size.height
        let width = contentView.frame.size.width
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height / 2)
        subLabel.frame = CGRect(x: 0, y: height / 2, width: width, height: height / 2)
    }
}
