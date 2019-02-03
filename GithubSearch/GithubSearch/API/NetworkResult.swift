//
//  NetworkResult.swift
//  GithubSearch
//
//  Created by 심지원 on 03/02/2019.
//  Copyright © 2019 심지원. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}
