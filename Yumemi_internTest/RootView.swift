//
//  RootView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//

import SwiftUI

struct RootView: View {
    @State private var viewType: ViewType = .firstPage
    @StateObject var viewTypeModel = ViewTypeModel()

    var body: some View {
        switch viewType {
        case .firstPage:
            FirstPageView()
        case .tabPage:
            ContentView()
        }
    }
}

#Preview {
    RootView()
}
