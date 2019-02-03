//
//  SearchTVCell.swift
//  GithubSearch
//
//  Created by 심지원 on 03/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

import UIKit

class SearchTVCell: UITableViewCell {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userIdLb: UILabel!
    @IBOutlet weak var repoCntLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImg.circleImageView()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
