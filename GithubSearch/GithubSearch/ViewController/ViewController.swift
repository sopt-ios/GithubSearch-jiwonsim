//
//  ViewController.swift
//  GithubSearch
//
//  Created by 심지원 on 03/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTV: UITableView!
    
    var userList = [SearchItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTF.layer.cornerRadius = 8
        
        searchTF.delegate = self
        searchTV.delegate = self
        searchTV.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getSearchRes()
        return true
    }
    
    func getSearchRes() {
        SearchService.shared.getSearchResult(searchTag: searchTF.text!) { [weak self] (data) in
            guard let `self` = self else { return }
            let searchItem = data as [SearchItem]
            self.userList = searchItem
            self.searchTV.reloadData()
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVCell") as! SearchTVCell
        let data = userList[indexPath.row]
        cell.selectionStyle = .none
        
        cell.userImg.imageFromUrl(gsno(data.avatar_url), defaultImgPath: "")
        cell.userIdLb.text = data.login
        return cell
        
    }
    
    
}
