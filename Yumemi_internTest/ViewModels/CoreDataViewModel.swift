//
//  CoreDataViewModel.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2024/01/04.
//

import Foundation
import CoreData
final class CoreDataViewModel: ObservableObject {
    let coreDataModel: CoreDataModel
    init(coreDataModel: CoreDataModel) {
        self.coreDataModel = coreDataModel
    }
    @Published var fortuneData:[ItemData]  = []

    func saveData(name: String, timeStamp: Date, prefecture: String) {
        coreDataModel.addData(name: name, timeStamp: Date(), prefecture: prefecture)
    }
    func fetchData() {
        var fetchedData: [ItemData]  = []
        let datas = coreDataModel.fetchData()
        if !datas.isEmpty {
            for data in datas {
                fetchedData.append(ItemData(
                    name: data.name ?? "Unknown",
                    timeStamp: data.timestamp ?? Date(),
                    prefecture: data.prefecture ?? "Unknown"
                ))
            }
        }

    }
}
