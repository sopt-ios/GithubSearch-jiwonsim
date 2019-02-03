//
//  SearchService.swift
//  GithubSearch
//
//  Created by 심지원 on 03/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

import Foundation
import Alamofire

struct SearchService: APIManager, Requestable{
    typealias NetworkData = SearchObject
    
    static let shared = SearchService()
    var searchURL = url("search/users")
    let header: HTTPHeaders = [
//        "Content-Type" : "application/json",
        "Authorization" : ""
    ]
    
    
    
    func getSearchResult(searchTag: String, completion: @escaping ([SearchItem]) -> Void) {
        let queryURL = searchURL + "?q=\(searchTag)"
        guard let searchURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        gettable(searchURL, body: nil, header: header) {
            (res) in
            switch res{
            case .success(let value):
                guard let searchData = value.items else{return}
                completion(searchData)
            case .error(let error):
                print(error)
            }
        }
    }
}
