//
//  BookCell.swift
//  Book-App
//
//  Created by Akın Çetin on 20.02.2023.
//

import UIKit
import SDWebImage

class BookCell: UICollectionViewCell {
    
    
    private var book: Book?
    let imageView = UIImageView(image: UIImage(named: "book2")?.withRenderingMode(.alwaysOriginal))
    
    let bookNameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Kitap ismiasdkaodpadkoapdk"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    let bookAuthorNameLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Kitap Yazarı"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    let bookPriceLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "100TL"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [bookNameLabel, bookAuthorNameLabel, bookPriceLabel])
    
    let addBasketButton: UIButton = {
       
        let button = UIButton(frame: .zero)
        button.setTitle("Sepete Ekle", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = CGFloat(1)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 8, bottom: 0, right: 8),size: .init(width: 0, height: 270))
        addSubview(stackView)
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        addBasketButton.addTarget(self, action: #selector(addBasket), for: .touchUpInside)
        
        addSubview(addBasketButton)
        addBasketButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 16, right: 8), size: .init(width: 0, height: 50))
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(book: Book) {
        
        self.book = book
        let url = URL(string: book.Url!)
        guard let url = url else {return}
        imageView.sd_setImage(with: url)
        self.bookNameLabel.text = book.BookName
        self.bookPriceLabel.text = ("\(book.Price!) TL")
        self.bookAuthorNameLabel.text = book.Author
        
    }
    @objc fileprivate func addBasket() {
        guard let book = self.book else {
            return
        }
        print(book.BookName!)
        print("xx")
    }
    
}
