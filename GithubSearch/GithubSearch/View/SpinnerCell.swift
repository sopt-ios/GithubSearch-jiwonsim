//
//  SpinnerCell.swift
//  GithubSearch
//
//  Created by 심지원 on 08/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

import UIKit

class SpinnerCell: UITableViewCell {

    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: super.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: super.centerYAnchor).isActive = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
