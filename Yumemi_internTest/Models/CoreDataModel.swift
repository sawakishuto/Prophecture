//
//  CoreDataModel.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2024/01/04.
//

import Foundation
import CoreData

 struct CoreDataModel {
     func addData(name: String, prefecture: String, logoUrl: String, context: NSManagedObjectContext) {
        let newItem = Item(context: context)
        newItem.name = name
        newItem.timestamp = Date()
         newItem.logourl = logoUrl
        newItem.prefecture = prefecture
        do {
            print("保存中")
            try context.save()
            print("成功")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
     func fetchData(context: NSManagedObjectContext) -> [Item] {
         let request = NSFetchRequest<Item>(entityName: "Item")
         request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
         do {
             print("取得します")
              return try context.fetch(request)
          } catch {
              fatalError("取得失敗")
          }
     }
}
