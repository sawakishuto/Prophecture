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
    @State private var isShowFortuneAlert: Bool = false
    @State private var isShowMapAlert: Bool = false
    var body: some View {
        ZStack {

            Image("menuImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .scaleEffect(1.01)

            Button(action: {
                isShowFortuneAlert = true
            }, label: {
                Image("menuMessage")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.2)
                    .padding(.leading, 20)
            })
            .padding(.bottom, 450)
            .alert("占いを始めますか？", isPresented: $isShowFortuneAlert) {
                Button("いいえ") {
                    isShowFortuneAlert = false
                }
                Button("はい") {
                    ViewType.viewType = .tabPage
                }
            }
            Button {
                isShowMapAlert = true
            } label: {
                Image("fortuneMapImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)

            }
            .padding(.top, 350)
            .alert("占いマップを見ますか？", isPresented: $isShowMapAlert) {
                Button("いいえ") {
                    isShowMapAlert = false
                }
                Button("はい") {
                    ViewType.viewType = .mapPage
                }
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
