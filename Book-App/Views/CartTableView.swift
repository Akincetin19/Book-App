//
//  CartTableView.swift
//  Book-App
//
//  Created by Akın Çetin on 23.02.2023.
//

import UIKit

class CartTableView: UITableView {

    
    var books: [CartBook] = []
    var bindableIsDelete = Bindable<Bool>()
    var bindIsUserCreateNewOrder = Bindable<Bool>()
    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: style)
        register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "TableHeader")
        register(TableFooter.self, forHeaderFooterViewReuseIdentifier: "TableFooter")
        register(CartCell.self, forCellReuseIdentifier: "cartCell")
        
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CartTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as? CartCell else{return UITableViewCell()}
        cell.configureCell(book: books[indexPath.item])
        cell.bindableBookCount.bind {[weak self] count in

            guard let self = self else {return}
            if(count == 0){
                
                UserService.shared.deleteBookFromChart(book: self.books[indexPath.item])
                self.books.remove(at: indexPath.item)
                self.reloadData()
                self.bindableIsDelete.value = true
            }
            else{
                self.books[indexPath.item].count = "\(count!)"
                UserService.shared.updateChart(book: self.books[indexPath.item])
                self.reloadData()
            }
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as? TableHeader
        header?.label.text = "Sepetim (\(self.books.count) Ürün)"
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableFooter") as? TableFooter
        footer?.subLabel.text = "\(self.books.count) Ürün"
        let totalPrice = self.calculateTotalPrice()
        footer?.totalPriceLabel.text = "\(totalPrice) TL"
        footer?.bindIsClicked.bind(observer: {[weak self] bool in
            guard let self = self else {return}
            UserService.shared.createNewOrder(books: self.books, totalPrice: totalPrice)
            self.bindIsUserCreateNewOrder.value = true
        })
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 220
    }
}
extension CartTableView {
    func calculateTotalPrice() -> Int {
        
        var totalPrice = 0
        
        self.books.forEach { book in
            totalPrice = totalPrice + Int(book.bookPrice!)! * Int(book.count!)!
        }
        
        return totalPrice
    }
}
