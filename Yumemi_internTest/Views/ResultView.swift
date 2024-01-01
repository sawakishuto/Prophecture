//
//  ResultView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/27.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
    enum cardState {
        case normal
        case large
        case small
        var UpcardSituation: Double {
            switch self {
            case .normal: return 1.0
            case .large: return 1.5
            case .small: return 0.7

            }
        }
        var downcardSituation: Double {
            switch self {
            case .normal: return 1.0
            case .large: return 0.7
            case .small: return 1.5
            }
        }
        var upCardPlusOffset: CGFloat {
            switch self {
            case .normal: return 0
            case .large: return 200
            case .small: return 200
            }
        }
        var downCardPlusOffset: CGFloat {
            switch self {
            case .normal: return 0
            case .large: return -300
            case .small: return -300
            }
        }
    }

    @ObservedObject var ViewModel = FortuneViewModel()
    let returnName: String
    let returnCapital: String
    let returnCitizen_day: MonthDay
    let returnHas_coast_line: Bool
    let returnLogo_url: String?
    let returnBrief: String
    private let CardAppear = try! AVAudioPlayer(data: NSDataAsset(name: "cardApear")!.data)
    @State private var appearOffset: Double = 0.0
    @State private var isappearA: Bool = false
    @State private var isappearB: Bool = false
    @State private var isSmallEffect: Bool = false
    @State private var islargeEffect: Bool = false
    @State private var upCardZ_Index: Double = 10
    @State private var downCardZ_Index: Double = 10
    @State private var upCardOffset: CGFloat = -2000
    @State private var downCardOffset: CGFloat = -2000
    @State private var goOpenCard: Bool = false
    @State private var cardStates: cardState = .normal
    @State var isShowDetail: Bool = false
    let ViewType: ViewTypeModel
    
    var body: some View {
        if !goOpenCard {
            GeometryReader { geometory in

                ZStack(alignment: .center) {
                    Image("tableImage")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .scaleEffect(1.01)
                        .frame(width: geometory.size.width, height: geometory.size.height)
                    VStack(alignment: .center, spacing: 150) {
                        upCardView
                        downCardView
                    }
                    if cardStates != .normal {
                        Text("このカードにする！")
                            .padding(20)
                            .background(Color.white.cornerRadius(20))
                            .shadow(radius: 50)
                            .onTapGesture {
                                goOpenCard = true
                            }
                            .padding(.top, 500)
                            .fontWeight(.black)
                    }

                }
                .onTapGesture {
                    cardStates = .normal
                }
                .animation(.easeInOut(duration: 0.7), value: upCardOffset)
                .animation(.easeInOut(duration: 0.7), value: downCardOffset)
                .animation(.easeInOut(duration: 0.3), value: cardStates)
                .animation(.easeInOut(duration: 0.3), value: cardStates)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    CardAppear.play()
                    upCardOffset = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    CardAppear.play()
                    isappearB = true
                    downCardOffset = 0
                }
            }
        } else {
            OpenCardPageView(
                isShowDetail: $isShowDetail, returnName: returnName,
                returnCapital: returnCapital,
                returnCitizen_day: returnCitizen_day,
                returnHas_coast_line: returnHas_coast_line,
                returnLogo_url: returnLogo_url,
                returnBrief: returnBrief,
                ViewType: ViewType)
        }
    }
}
private extension ResultView {
    var upCardView: some View {
        Image("cardImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .scaleEffect(cardStates.UpcardSituation)
            .offset(y: upCardOffset + cardStates.upCardPlusOffset)
            .zIndex(upCardZ_Index)
            .onTapGesture {
                cardStates = .large
                downCardZ_Index = 9
                upCardZ_Index = 10
            }
    }
    var downCardView: some View {
        Image("cardImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .scaleEffect(cardStates.downcardSituation)
            .offset(y: downCardOffset + cardStates.downCardPlusOffset)
            .zIndex(downCardZ_Index)
            .onTapGesture {
                cardStates = .small
                upCardZ_Index = 9
                downCardZ_Index = 10
            }
    }
}

