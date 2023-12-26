//
//  menuView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//

import SwiftUI

struct menuView: View {
    let ViewType: ViewTypeModel
    @State private var opacity: Double = 0.0
    var body: some View {
        ZStack {
            Image("menuImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onTapGesture {
                    ViewType.viewType = .tabPage
                }
        }
            .opacity(self.opacity)
            .onAppear {
                withAnimation(.linear(duration: 1.0)) {
                               self.opacity = 1.0
                           }
            }
    }
}
