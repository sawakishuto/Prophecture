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
        ZStack {
            Image("firstviewImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Image("firstViewTitleImage")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.8)
                .padding(.bottom, 450)

            Image("titleCommentImage")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.7)
                .padding(EdgeInsets(top: 0, leading: 240, bottom: 550, trailing: 0))

            Text("Tap To Start!")
                .fontWeight(.black)
                .font(.system(size: 35))
                .padding(.top, 300)
        }
            .onTapGesture {
                self.ViewType.viewType = .tabPage
            }

    }
}


