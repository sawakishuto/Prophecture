//
//  Yumemi_internTestApp.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/21.
//

import SwiftUI

@main
struct Yumemi_internTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
