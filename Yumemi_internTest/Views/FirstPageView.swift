//
//  FirstPageView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//

import SwiftUI

struct FirstPageView: View {
    let ViewType: ViewTypeModel
    var body: some View {
        Button(action: {
            self.ViewType.viewType = .tabPage
        }, label: {
            Text("遷移")
        })

    }
}


