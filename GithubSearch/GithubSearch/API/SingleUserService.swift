//
//  SingleUserService.swift
//  GithubSearch
//
//  Created by 심지원 on 03/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

import Foundation
import Alamofire

struct SingleUserService: APIManager, Requestable{
    typealias NetworkData = SingleUserObject
    
    static let shared = SingleUserService()
    var searchURL = url("users")
    let header: HTTPHeaders = [
        //        "Content-Type" : "application/json",
        "Authorization" : ""
    ]
    
    
    
    func getUserRepoCntResult(username: String, completion: @escaping (Int) -> Void) {
        let queryURL = searchURL + "/\(username)"
        guard let searchURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        gettable(searchURL, body: nil, header: header) {
            (res) in
//            print(res)
            switch res{
            case .success(let value):
                guard let searchData = value.public_repos else{return}
                completion(searchData)
            case .error(let error):
                print(error)
            }
        }
    }
}
