//
//  CardFront.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/27.
//

import SwiftUI

struct CardFront: View {
    @State private var isSmallEffect: Bool = false
    @State private var islargeEffect: Bool = false
    @State var isFront: Bool = false
    let returnName: String
    let returnCapital: String
    let returnCitizen_day: MonthDay
    let returnHas_coast_line: Bool
    let returnLogo_url: String?
    let returnBrief: String
    var body: some View {
        Flip(isFront: isFront, // 先に作っておいた変数 isFront
             front: {
            ZStack{
                VStack {
                    Text(returnName)
                    Text(returnCapital)
                    if (returnHas_coast_line) {
                        Text("海岸沿い：ある")
                    }
                    Text(String(returnCitizen_day.month))
                    Text(String(returnCitizen_day.day))
                    AsyncImage(url: URL(string: returnLogo_url ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                            .cornerRadius(40)
                            .border(.black)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .backgroundStyle(.white)
            .frame(width: 300,height: 420)
            .overlay( RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color(
                        red: 0.17,
                        green: 0.17,
                        blue: 0.9
                    ), lineWidth: 10
                )
                            )
            .onTapGesture {
                isFront = false
            }
        },
             back: {
            Image("cardImage")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .onTapGesture {
                    isFront = true
                }
        }
        )


    }
}

#Preview {
    CardFront(returnName: "滋賀県", returnCapital: "大津", returnCitizen_day: MonthDay(month: 11, day: 11), returnHas_coast_line: false, returnLogo_url: "", returnBrief: "特になし")
}
