//
//  CartCell.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import UIKit

class CartCell: UITableViewCell {

    let bookImage = UIImageView(image: UIImage(named: "book2")?.withRenderingMode(.alwaysOriginal))
    
    let bookNameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Kitap ismiasdkaodpadkoapdkismiasdkaodpadkoapdkismiasdkaodpadkoapdk"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    let bookAuthorNameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Kitap Yazarı"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        return label
        
    }()
    let bookPriceLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "100TL"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    
    let deleteButton: UIButton = {
       
        let button = UIButton(frame: .zero)
        button.setTitle("Sil", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bookImage)
        addSubview(bookNameLabel)
        addSubview(bookAuthorNameLabel)
        addSubview(bookPriceLabel)
        addSubview(deleteButton)
        
        
        let height = frame.height
        let width = frame.size.width
        
        bookImage.frame = CGRect(x: 16, y: 16, width: 100, height: 150)
        
        bookNameLabel.frame = CGRect(x: bookImage.frame.maxX + 16, y: 16, width: 200, height: 50)
        
        deleteButton.frame = CGRect(x: bookNameLabel.frame.maxX + 8, y: 16, width: 50, height: 50)
        bookAuthorNameLabel.frame = CGRect(x: bookNameLabel.frame.minX, y: bookNameLabel.frame.maxY, width: 200, height: 50)
        bookPriceLabel.frame = CGRect(x: bookAuthorNameLabel.frame.minX, y: bookAuthorNameLabel.frame.maxY, width: 100, height: 50)
        
        print("fdffsdf")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
