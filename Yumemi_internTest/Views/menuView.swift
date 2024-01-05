//
//  menuView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//  占いかMapかを選ぶView

import SwiftUI
import AVFoundation
struct menuView: View {
    let ViewType: ViewTypeModel
    private let TapMusic = try! AVAudioPlayer(data: NSDataAsset(name: "tapMusic")!.data)
    private let CancelMusic = try! AVAudioPlayer(data: NSDataAsset(name: "cancelMusic")!.data)
    @State private var isFront: Bool = false
    @State private var opacity: Double = 0.0
    @State private var isShowFortuneAlert: Bool = false
    @State private var isShowMapAlert: Bool = false
    @State private var imgOffset: Double = UIScreen.main.bounds.width * 2
    var body: some View {
        ZStack {
            menus
                .padding(.trailing, 30)
            
            Image("kartenImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: imgOffset)
                .scaleEffect(1.2)
        }
    }
}
private extension menuView {
    var menus: some View {
        ZStack {
            
            Image("menuImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .scaleEffect(1.01)
            
            Button(action: {
                isShowFortuneAlert = true
                TapMusic.play()
            }, label: {
                Image("menuMessage")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.2)
                    .padding(.leading, 20)
            })
            .padding(.bottom, 450)
            .alert("占いを始めますか？", isPresented: $isShowFortuneAlert) {
                Button("いいえ") {
                    CancelMusic.play()
                    isShowFortuneAlert = false
                    
                    
                }
                Button("はい") {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.imgOffset = 0.0
                    }
                    TapMusic.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.ViewType.viewType = .tabPage
                    }
                }
            }
            Button {
                TapMusic.play()
                isShowMapAlert = true
            } label: {
                Image("fortuneMapImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                
            }
            .padding(.top, 350)
            .alert("占いマップを見ますか？", isPresented: $isShowMapAlert) {
                Button("いいえ") {
                    withAnimation{
                        isShowMapAlert = false}
                }
                Button("はい") {
                    TapMusic.play()
                    ViewType.viewType = .mapPage
                }
            }
        }
        .opacity(self.opacity)
        .onTapGesture {
            TapMusic.play()
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0)) {
                self.opacity = 1.0
            }
        }
    }
}
