//
//  ItemTableViewCell.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        userAvatarImageView.layer.cornerRadius = 40
        userAvatarImageView.layer.masksToBounds = true
    }
    
    func setData(avatar: String,
                 firstName: String,
                 lastName: String) {
        userAvatarImageView.getOrDownloadImage(from: avatar)
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }

}
