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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ResultView()
}
