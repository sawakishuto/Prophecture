//
//  CardFront.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/27.
//

import SwiftUI

struct CardFront: View {
    @State private var fingerMove: Bool = false
    @State private var isSmallEffect: Bool = false
    @State private var islargeEffect: Bool = false
    @State private var returnimage: UIImage? = nil
    @State var isFront: Bool = false
    @Binding var isShowDetail: Bool
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
                    if let returnimage = returnimage {
                       Image(uiImage: returnimage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                    }


                    Rectangle()
                        .fill(.gray)
                        .frame(width:300, height: 2)

                    Text(returnName)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(returnCapital)
                        .font(.subheadline)
                        .fontWeight(.light)
                    returnHas_coast_line ?
                        Text("海岸沿い：あり")
                            .font(.subheadline)
                            .fontWeight(.thin) :
                        Text("海岸：なし")
                            .font(.subheadline)
                            .fontWeight(.thin)
                    HStack {
                        Text("県民の日:")
                            .font(.subheadline)
                            .fontWeight(.thin)
                        if returnCitizen_day.day * returnCitizen_day.month == 0 {
                            Text("なし")
                                .font(.subheadline)
                                .fontWeight(.thin)
                        } else {
                            Text("\(returnCitizen_day.month)月\(returnCitizen_day.day)日")
                                .font(.subheadline)
                                .fontWeight(.thin)
                        }
                    }

                    ScrollView {
                        Text(returnBrief)
                            .font(.caption2)
                            .fontWeight(.thin)
                            .foregroundStyle(.black)
                            .frame(width: 230)
                            .padding(.bottom, 20)
                    }

                }
                .padding(.top, 30)
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
        },
             back: {
            ZStack {
                Image("cardImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)

                    Image("fingerImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .scaleEffect(fingerMove ? 0.9: 1)
                        .rotationEffect(Angle(degrees: 25))
                        .animation(.spring(duration: 0.4).repeatForever(), value: fingerMove)
            }
            .task {
                returnimage = await loadImage()
            }
            .onTapGesture {
                isShowDetail = true
                isFront = true
            }
            .onAppear {
                    withAnimation {
                        fingerMove.toggle()
                    }
                }
        }
        )


    }
    func loadImage() async -> UIImage? {
      guard let url = URL(string: returnLogo_url ?? "") else { return nil}

        guard let data = try? await URLSession.shared.data(from: url).0 else { return nil }
        let image = UIImage(data: data)
        return image

    }
}

#Preview {
    CardFront(isShowDetail: .constant(false), returnName: "滋賀県", returnCapital: "大津", returnCitizen_day: MonthDay(month: 11, day: 11), returnHas_coast_line: false, returnLogo_url: "", returnBrief: "特になし")
}
