//
//  SearchModel.swift
//  GithubSearch
//
//  Created by 심지원 on 03/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchObject : Mappable {
    var total_count : Int?
    var incomplete_results : Bool?
    var items : [SearchItem]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items <- map["items"]
    }
    
}
