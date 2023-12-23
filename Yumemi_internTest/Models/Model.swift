//
//  Model.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//

import Foundation

struct APIPostInfo: Codable {
    let name: String
    let birthday: YearMonthDay
    let blood_type: String
    let today: YearMonthDay
}

struct YearMonthDay: Codable {
    let year: Int
    let month: Int
    let day: Int
}

struct APIResponseInfo: Decodable {
    let name: String
    let capital: String
    let citizen_day: MonthDay?
    let has_coast_line: Bool
    let logo_url: String?
    let brief: String
}

struct MonthDay: Decodable {
    let month: Int
    let day: Int
}

