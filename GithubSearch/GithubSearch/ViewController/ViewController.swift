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
    var tempList = [SearchItem]()
    var limit = 20
    var page = 0
    
    var spinner : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTF.setLeftPaddingPoints(10)
        searchTF.layer.cornerRadius = 8
        searchTF.delegate = self
        
        searchTV.delegate = self
        searchTV.dataSource = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tempList.removeAll()
        getSearchRes()
        
        return true
    }
    
    func getSearchRes() {
        SearchService.shared.getSearchResult(searchTag: searchTF.text!) { [weak self] (data) in
            guard let `self` = self else { return }
            let searchItem = data as [SearchItem]
            self.userList = searchItem
            
            print("userList개수 : \(self.userList.count)")
            var index = 0
            if self.userList.count > self.limit {
                while index < self.limit {
                    self.tempList.append(self.userList[index])
                    index = index + 1
                }
            }
            else {
                while index < self.userList.count {
                    self.tempList.append(self.userList[index])
                    index = index + 1
                }
            }
            self.searchTV.reloadData()
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVCell") as! SearchTVCell
        let data = tempList[indexPath.row]
        cell.selectionStyle = .none
        
        SingleUserService.shared.getUserRepoCntResult(username: data.login!) { (repoCnt) in
            cell.userImg.imageFromUrl(self.gsno(data.avatar_url), defaultImgPath: "")
            cell.userIdLb.text = data.login
            cell.repoCntLb.text = "Number of repos: " + String(repoCnt)
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tempList.count - 1 {
            //마지막 셀에 있다!
            page = page + 1
            if tempList.count < userList.count {
                //더 불러올 수 있어!
                var index = tempList.count
                if userList.count % 20 * page > 20 {
                    limit = index + 20
                }
                else {
                    limit = index + userList.count % 20 * page
                }
                while index < limit {
                    
                    tempList.append(userList[index])
                    index = index + 1
                    
                    self.spinner = UIActivityIndicatorView.init(style: .gray)
                    self.spinner.startAnimating()
                    self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                    self.searchTV.tableFooterView = spinner
                }
                self.perform(#selector(loadTable), with: nil, afterDelay: 2.0)
            }
        }
    }
    @objc func loadTable() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        self.searchTV.reloadData()
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
