//
//  FortuneMapview.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//

import SwiftUI

struct FortuneMapview: View {
    let ViewType: ViewTypeModel
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var coreDataVM = CoreDataViewModel(coreDataModel: CoreDataModel())
    var body: some View {
        VStack {
            Text("何も")
            ForEach(coreDataVM.fortuneData) { data in
                VStack {
                    Text(data.name )
                    Text(data.dateString)
                    Text(data.prefecture)
                }
            }
        }
        .onAppear {
            print("アピ")
            coreDataVM.fetchData(context: context)
        }

    }
}

