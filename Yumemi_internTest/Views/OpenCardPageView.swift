//
//  OpenCardPageView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/31.
//

import SwiftUI

struct OpenCardPageView: View {
    @ObservedObject var ShareOnXvm: ShareOnXViewModel = ShareOnXViewModel()
    @Binding var isShowDetail: Bool
    let returnName: String
    let returnCapital: String
    let returnCitizen_day: MonthDay
    let returnHas_coast_line: Bool
    let returnLogo_url: String?
    let returnBrief: String
    let ViewType: ViewTypeModel

    var body: some View {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .scaleEffect(1.01)
                Text("あなたにぴったりの都道府県は・・")
                    .padding(.bottom, 550)
                    .fontWeight(.black)
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                CardFront(isShowDetail: $isShowDetail, returnName: returnName, returnCapital: returnCapital, returnCitizen_day: returnCitizen_day, returnHas_coast_line: returnHas_coast_line, returnLogo_url: returnLogo_url, returnBrief: returnBrief)
                if isShowDetail {
                    Image("x_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding()
                        .background(.white)
                        .cornerRadius(50)
                        .padding(EdgeInsets(top: 550, leading: 200, bottom: 0, trailing: 0))
                        .onTapGesture {
                            self.ShareOnXvm.ShareOnX(name: returnName)
                        }
                }
                if isShowDetail {
                    Text("メニュー画面へ戻る")
                        .padding()
                        .background(Color.white.cornerRadius(20))
                        .fontWeight(.black)
                        .padding(EdgeInsets(top: 550, leading: 0, bottom: 0, trailing: 150))
                        .onTapGesture {
                            ViewType.viewType = .menuPage
                        }
                }

            }
    }
}


