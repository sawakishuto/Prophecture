//
//  ResultView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/27.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
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


    let ViewType: ViewTypeModel
    var body: some View {
        ZStack {
            CardBack()
                .offset(y: isappearA ? -150: -2000)

           CardBack()
                .offset(y: isappearB ? 150: -2000)

        }
        .animation(.easeInOut(duration: 0.7), value: isappearA)
        .animation(.easeInOut(duration: 0.7), value: isappearB)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                CardAppear.play()
                isappearA = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                CardAppear.play()
                isappearB = true

            }
        }
    }
}

