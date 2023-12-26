//
//  FirstPageView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//

import SwiftUI

struct FirstPageView: View {
    let ViewType: ViewTypeModel
    @State private var isShowComment: Bool = false
    @State private var isShowTitle: Bool = false
    @State private var bounceMessage: Bool = false
    @State private var expandImage: Bool = false
    @State private var isClose: Bool = true

    var body: some View {

        ZStack {
            Image("firstviewImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Image("firstViewTitleImage")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 450)
                .scaleEffect(isShowtitle ? 0.8 : 0.0)
                .animation(.spring(duration: 2.4, bounce: 0.45), value: isShowtitle)

            Image("titleCommentImage")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.7)
                .padding(EdgeInsets(top: 0, leading: 240, bottom: 550, trailing: 0))


            Text("Tap To Start!")
                .fontWeight(.black)
                .font(.system(size: 35))
                .padding(.top, 300)
                .scaleEffect(isShowtitle ? 1.0 : 0.8)
                .animation(.spring(duration: 1.0).repeatForever(), value: bounceMessage)

        }
        .onAppear{
            isShowtitle.toggle()
            bounceMessage.toggle()
        }
        .onTapGesture {
                self.ViewType.viewType = .tabPage
            }

    }
}


