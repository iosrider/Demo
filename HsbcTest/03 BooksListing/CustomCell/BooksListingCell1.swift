//
//  BooksListingCell1.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 11/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import UIKit

class BooksListingCell1: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
