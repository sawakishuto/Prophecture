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
    @Published var fortuneData: [ItemData] = []

    func saveData(name: String, prefecture: String, context: NSManagedObjectContext) {
        coreDataModel.addData(name: name, prefecture: prefecture, context: context)
    }
    func fetchData(context: NSManagedObjectContext) {
        print("start")
        let datas = coreDataModel.fetchData(context: context)
        if !datas.isEmpty {
            print("now..")
            for data in datas {
                var ItemDatas = ItemData(
                    name: data.name ?? "Unknown",
                    timeStamp: data.timestamp ?? Date(),
                    prefecture: data.prefecture ?? "Unknown"
                )
                fortuneData.append(ItemDatas)
            }
        } else {
            print("失敗")
        }
        print("end")
    }
}
