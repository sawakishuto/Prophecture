//
//  FortuneViewModel.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//

import Foundation

final class FortuneViewModel: ObservableObject {
    @Published var fortuneResults: APIResponseInfo?
    private let apiClient = APIClient()
    init() {
        self.fortuneResults = nil
    }

    func executionFortune(name: String, birthday: YearMonthDay, blood_type: String, today: YearMonthDay) {
        Task {
            let executionResult = await self.apiClient.StartSession(name: name, birthday: birthday, blood_type: blood_type, today: today)
            switch executionResult {
            case .success(let fortuneResult):
                await MainActor.run {
                    self.fortuneResults = fortuneResult
                }
            case .failure(let APIError):
                print("\(APIError)")
            }
        }
    }
}
