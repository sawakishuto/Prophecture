//
//  APIClientError.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//

import Foundation

enum APIClientError: Error {
    case urlError
    case responseError
    case parseError
    case sessionError
    case unknownError
}
