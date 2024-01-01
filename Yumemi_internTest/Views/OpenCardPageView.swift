//
//  OpenCardPageView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/31.
//

import SwiftUI

struct OpenCardPageView: View {
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
                CardFront(returnName: returnName, returnCapital: returnCapital, returnCitizen_day: returnCitizen_day, returnHas_coast_line: returnHas_coast_line, returnLogo_url: returnLogo_url, returnBrief: returnBrief)

            }
    }
}


