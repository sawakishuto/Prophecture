//
//  APIClient.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//

import Foundation

struct APIClient {
    private let baseURL = URL(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud")!
    func StartSession(name: String, birthday: YearMonthDay, blood_type: String, today: YearMonthDay) async -> Result<APIResponse, APIClientError> {

        let urlComponents = URLComponents(
            url: baseURL.appending(path: "/my_fortune"),
            resolvingAgainstBaseURL: true
        )

        guard let url = urlComponents?.url else {
            return .failure()
        }
        let body = try? JSONSerialization.data(withJSONObject: [
            "name": name,
            "birthDay": birthday,
            "blood_type": blood_type,
            "today": today
        ])

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = ["API-Version": "v1"]



    }

}
