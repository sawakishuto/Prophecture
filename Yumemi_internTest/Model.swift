//
//  Model.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//

import Foundation

struct APIPostInfo: Codable {
    var id: String = UUID().uuidString
    let name: String
    let birthday: YearMonthDay
}

struct YearMonthDay: Codable {
    let year: Int
    let month: Int
    let day: Int
}

struct APIResponseInfo: Identifiable, Decodable {
    let id: Int
    let name: String
    let 

}

