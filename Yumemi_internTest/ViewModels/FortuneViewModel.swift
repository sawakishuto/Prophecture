//
//  FortuneViewModel.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/23.
//

import Foundation

final class FortuneViewModel: ObservableObject {
    @Published var fortuneResults: APIResponseInfo = APIResponseInfo(name: "しゅうと", capital: "滋賀県", citizen_day: MonthDay(month: 11, day: 12), has_coast_line: true, logo_url: nil, brief: "特になし")
    private let apiClient = APIClient()

    func executionFortune(name: String, birthday: YearMonthDay, blood_type: String, today: YearMonthDay) {
        Task {
            let executionResult = await self.apiClient.StartSession(name: name, birthday: birthday, blood_type: blood_type, today: today)
            switch executionResult {
            case .success(let fortuneResult):
                self.fortuneResults = APIResponseInfo(
                    name: fortuneResult.name,
                    capital: fortuneResult.capital,
                    citizen_day: MonthDay(
                        month: fortuneResult.citizen_day?.month ?? 0,
                        day: fortuneResult.citizen_day?.day ?? 0
                                         ),
                    has_coast_line: fortuneResult.has_coast_line,
                    logo_url: fortuneResult.logo_url,
                    brief: fortuneResult.brief)

            case .failure(let APIError):
                print("\(APIError)")
            }
        }
        print(fortuneResults)
    }
}
