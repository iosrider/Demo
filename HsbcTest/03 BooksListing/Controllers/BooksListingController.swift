//
//  BooksListingController.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 11/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import UIKit
import Kingfisher
import KRProgressHUD
import MaterialComponents.MaterialButtons




class BooksListingController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: MDCFloatingButton!
    var dictionary = [String: String]()
    var dataSource = BooksModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNibFile()
        loadData()
    }
    
    private func loadData() {
        let viewModel = BooksListingViewModel()
        KRProgressHUD.show(withMessage: "Loging in...")
        viewModel.getBooks(dictionary: dictionary) { result, error in
            if error == nil {
                if let result = result {
                    self.dataSource = result
                    self.tableView.reloadData()
                    KRProgressHUD.dismiss()
                 }
            } else {
                KRProgressHUD.dismiss()
             }
        }
    }
    
    private func registerNibFile() {
        tableView.register(UINib(nibName: "BooksListingCell1", bundle: nil), forCellReuseIdentifier: "BooksListingCell1")
        tableView.register(UINib(nibName: "BooksListingCell2", bundle: nil), forCellReuseIdentifier: "BooksListingCell2")
    }
    
    @IBAction func addNewBookTapped(_ sender: MDCFloatingButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "createBookSegue") as! AddNewBookController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.headers = dictionary
        self.present(vc, animated: true, completion: nil)
    }
}

extension BooksListingController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = dataSource[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksListingCell1", for: indexPath) as? BooksListingCell1 else { return UITableViewCell() }
            cell.bookAuthorLabel.text = book.author
            cell.bookTitleLabel.text = book.title
            if let imgUrl = URL(string: book.image) {
                cell.bookCoverImage.kf.setImage(with: imgUrl)
            }
            Helper.addAllCornerRadious(cell.bgView, radious: 5.0)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BooksListingCell2", for: indexPath) as? BooksListingCell2 else { return UITableViewCell() }
            Helper.addAllCornerRadious(cell.bgView, radious: 5.0)
            cell.bookAuthorLabel.text = book.author
            cell.bookTitleLabel.text = book.title
            if let imageUrl = URL(string: book.image) {
                cell.bookCoverImage.kf.setImage(with:imageUrl)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row % 2) == 0 ? 130 : 200
    }
}

