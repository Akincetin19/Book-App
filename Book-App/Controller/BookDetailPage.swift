//
//  BookDetailPage.swift
//  Book-App
//
//  Created by Akın Çetin on 21.02.2023.
//

import UIKit

class BookDetailPage: UIViewController {

    
    var selectedBook: Book?
    var control: Bool?
    var isFavorited: Bool = true
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = selectedBook?.Description
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var bookAuthorLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = selectedBook?.Author
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
        
    }()
    lazy var bookPriceLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "Fiyat - \(selectedBook?.Price ?? "") TL"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        return label
        
    }()
    
    fileprivate var addBasketButton = {
        
        let button = UIButton(frame: .zero)
        button.setTitle("Sepete Ekle", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    fileprivate let bookImage = UIImageView()
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupScrollview()
        setupContentView()
        configureNavigationItems()
        configureBookImage()
        configureDescriptionLabel()
        configureBookAuthorLabel()
        configureBookPriceLabel()
        configureAddBasketButton()
        configureFavoritedbutton()
    }
    
    fileprivate func configureView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
    }
    fileprivate func configureAddBasketButton() {
        
        addBasketButton.layer.cornerRadius = 8
        addBasketButton.addTarget(self, action: #selector(addBasketClicked), for: .touchUpInside)
        addBasketButton.anchor(top: bookPriceLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        
    }
    @objc fileprivate func addBasketClicked() {
        UserService.shared.addShoppingCart(book: selectedBook!)
        self.makeInfoAlert(view: self, info: "Ürün Başarıyla Sepenite Eklendi", title: "")
    }
    
    fileprivate func configureBookAuthorLabel() {
     
        bookAuthorLabel.text = "Yazar - \(bookAuthorLabel.text!)"
        bookAuthorLabel.textColor = .blue
        bookAuthorLabel.anchor(top: bookImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        let gesture = UITapGestureRecognizer(target: self, action: #selector(authorClicked))
        bookAuthorLabel.isUserInteractionEnabled = true
        bookAuthorLabel.addGestureRecognizer(gesture)
    }
    @objc func authorClicked(sender:UITapGestureRecognizer) {
        
        guard let _ = control else {
            let view = AuthorDetailScreen()
            view.author = selectedBook?.Author
            navigationController?.pushViewController(view, animated: true)
            return
        }
    }
    fileprivate func configureDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.anchor(top: addBasketButton.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    fileprivate func configureBookPriceLabel() {
        
        bookPriceLabel.anchor(top: bookAuthorLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func configureBookImage() {
        
        let url = URL(string: selectedBook?.Url ?? "")
        guard let url = url else {return}
        bookImage.sd_setImage(with: url)
        bookImage.contentMode = .scaleAspectFit
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        bookImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
    }
    fileprivate func setupScrollview() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    }
    fileprivate func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.addSubview(bookImage)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bookAuthorLabel)
        contentView.addSubview(bookPriceLabel)
        contentView.addSubview(addBasketButton)
    }

    fileprivate func configureNavigationItems() {
        
        let border: UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = .black
            return view
        }()
        view.addSubview(border)
        border.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 1))
        title = selectedBook?.BookName
        let heart = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoritedClicked))
        navigationItem.rightBarButtonItem = heart
    }
    @objc func favoritedClicked() {
        
        if(!isFavorited) {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            UserService.shared.addFavoritedBook(book: selectedBook!)
            self.isFavorited = true
        }
        else{
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            UserService.shared.removeFromFavorited(book: selectedBook!)
            self.isFavorited = false
        }
        
    }
    func configureFavoritedbutton() {
        UserService.shared.isFavorited(book: selectedBook!) { flag in
            if(flag) {
                self.isFavorited = true
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            }
            else {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
                self.isFavorited = false
            }
        }
    }
}
