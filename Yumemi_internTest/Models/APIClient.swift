//
//  APIClient.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//　実際にAPI通信を行うModel

import Foundation

struct APIClient {
    private let baseURL = URL(string: "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud")!
    func StartSession(name: String, birthday: YearMonthDay, blood_type: String, today: YearMonthDay) async -> Result<APIResponseInfo, APIClientError> {
//        パスの追加
        let urlComponents = URLComponents(
            url: baseURL.appending(path: "/my_fortune"),
            resolvingAgainstBaseURL: true
        )
//　　　　URLに不具合が出た場合
        guard let url = urlComponents?.url else {
            print("❌invalidURL")
            return .failure(.urlError)
        }
        let body = try? JSONSerialization.data(withJSONObject: [
            "name": name,
                        "birthday": [
                            "year": birthday.year,
                            "month": birthday.month,
                            "day": birthday.day
                        ],
                        "blood_type": blood_type,
                        "today":[
                            "year": today.year,
                            "month": today.month,
                            "day": today.day
                        ]
        ])

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = ["API-Version": "v1"]

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                guard let response = response as? HTTPURLResponse else {
                    print("❌invalidResponse")
//                  responseの失敗
                    return .failure(.responseError)
                }

                if response.statusCode == 200 {
                    do {
                        print("⭕️session succeed")
                        let decodedData: APIResponseInfo = try JSONDecoder().decode(APIResponseInfo.self, from: data)
                        return .success(decodedData)
                    } catch {
                        print("❌parse failure")
//                        パースの失敗
                        return .failure(.parseError)
                    }
                } else {
                    print("❌session failure")
//                    通信に何かしらの失敗があった場合
                    return .failure(.sessionError)
                }
        } catch {
            return .failure(.unknownError)
        }
    }

}
