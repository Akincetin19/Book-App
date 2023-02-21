//
//  BookDetailPage.swift
//  Book-App
//
//  Created by Akın Çetin on 21.02.2023.
//

import UIKit

class BookDetailPage: UIViewController {

    
    var selectedBook: Book?
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = selectedBook?.Description
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    fileprivate let bookImage = UIImageView()
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
                
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        configureNavigationItems()
        let url = URL(string: selectedBook?.Url ?? "")
        guard let url = url else {return}
        bookImage.sd_setImage(with: url)
        bookImage.contentMode = .scaleAspectFit
        scrollView.addSubview(contentView)
        contentView.addSubview(bookImage)
        contentView.addSubview(descriptionLabel)
    
        bookImage.translatesAutoresizingMaskIntoConstraints = false

        bookImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.anchor(top: bookImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
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
        let heart = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: nil)
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        navigationItem.rightBarButtonItems = [heart, search]
    }
}
