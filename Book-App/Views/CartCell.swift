//
//  CartCell.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import UIKit

class CartCell: UITableViewCell {

    var bindableBookCount = Bindable<Int>()
    let bookImage = UIImageView()
    
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
        label.font = UIFont.systemFont(ofSize: 30)
        return label
        
    }()
    let bookCountLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "5"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    
    let plusButton: UIButton = {
       
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "plus.square", withConfiguration: config), for: .normal)
        return button
    }()
    let minusButton: UIButton = {
       
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "minus.square", withConfiguration: config), for: .normal)
        return button
    }()
    
    let countStackView = UIStackView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bookImage)
        contentView.addSubview(bookNameLabel)
        contentView.addSubview(bookAuthorNameLabel)
        contentView.addSubview(bookPriceLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(bookCountLabel)
        contentView.addSubview(minusButton)
        
        
        bookImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 275))
        
        bookNameLabel.anchor(top: topAnchor, leading: bookImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        bookNameLabel.numberOfLines = 2
        bookAuthorNameLabel.anchor(top: bookNameLabel.bottomAnchor, leading: bookNameLabel.leadingAnchor, bottom: nil, trailing: bookNameLabel.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        bookAuthorNameLabel.numberOfLines = 2
        
        bookPriceLabel.anchor(top: bookAuthorNameLabel.bottomAnchor, leading: bookAuthorNameLabel.leadingAnchor, bottom: nil, trailing: bookAuthorNameLabel.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 150))
       
        plusButton.anchor(top: bookPriceLabel.topAnchor, leading: bookPriceLabel.trailingAnchor, bottom: bookPriceLabel.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 0))
        
        bookCountLabel.anchor(top: plusButton.topAnchor, leading: plusButton.trailingAnchor, bottom: plusButton.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 4, bottom: 0, right: 4))
        
        minusButton.anchor(top: bookCountLabel.topAnchor, leading: bookCountLabel.trailingAnchor, bottom: bookCountLabel.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 4, bottom: 0, right: 0), size: .init(width: 50, height: 0))
        
        plusButton.addTarget(self, action: #selector(increaseCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(reduceCount), for: .touchUpInside)
       
    }
    @objc func benpress(sender: UIButton) {
        print("sapodkaspd")
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
extension CartCell {
    
    @objc func increaseCount() {
        let count = Int(bookCountLabel.text!) ?? 0
        bookCountLabel.text = "\(count + 1)"
        bindableBookCount.value = count + 1
    }
    @objc func reduceCount() {
        
        var count = Int(bookCountLabel.text!) ?? 0
        
        if(count >= 1)
        {
            
            count = count - 1
            bindableBookCount.value = count
            bookCountLabel.text = "\(count)"
            
        }
        else{
            bookCountLabel.text = "\(count)"
            bindableBookCount.value = count
            
        }
    }
    func configureCell(book: CartBook) {
        
        self.bookAuthorNameLabel.text = book.author
        self.bookCountLabel.text = book.count
        self.bookNameLabel.text = book.name
        self.bookPriceLabel.text = "\(book.bookPrice!) TL"
        
        guard let url = URL(string: book.url!) else {return}
        self.bookImage.sd_setImage(with: url)
    }
}
