//
//  RootView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewTypeModel = ViewTypeModel()

    var body: some View {
        switch viewTypeModel.viewType {
        case .firstPage:
            FirstPageView(ViewType: viewTypeModel)
        case .tabPage:
            ContentView(ViewType: viewTypeModel)
        case .menuPage:
            menuView(ViewType: viewTypeModel)
        }
    }
}
