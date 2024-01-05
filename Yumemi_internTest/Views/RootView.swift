//
//  RootView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//　大元のView

import SwiftUI
import AVFoundation
struct RootView: View {
    private let AppMusic = try! AVAudioPlayer(data: NSDataAsset(name: "appMusic")!.data)
    @StateObject var viewTypeModel = ViewTypeModel()
    @StateObject var viewModel = FortuneViewModel()
    init() {
        AppMusic.numberOfLoops = -1
        AppMusic.play()
    }

    var body: some View {
        switch viewTypeModel.viewType {
        case .firstPage:
            FirstPageView(ViewType: viewTypeModel)
        case .tabPage:
            FortunePlayView(ViewType: viewTypeModel, viewModel: viewModel)
        case .menuPage:
            menuView(ViewType: viewTypeModel)
        case .mapPage:
            FortuneMapview(ViewType: viewTypeModel)
        }
    }
}
