//
//  CoreDataModel.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2024/01/04.
//

import Foundation
import CoreData

 struct CoreDataModel {
     let context: NSManagedObjectContext
    func addData(name: String, timeStamp: Date, prefecture: String) {
        let newItem = Item(context: context)
        newItem.name = name
        newItem.timestamp = Date()
        newItem.prefecture = prefecture
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
     func fetchData() -> [Item] {
         let request = NSFetchRequest<Item>(entityName: "Item")
         request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
         do {
              return try context.fetch(request)
          } catch {
              fatalError("取得失敗")
          }
     }
}
