//
//  Flip.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/27.
//

import SwiftUI

struct Flip<Front: View, Back: View>: View {
    var isFront: Bool
    @State var canShowFrontView: Bool
    let duration: Double
    let front: () -> Front
    let back: () -> Back
    
    init(isFront: Bool,
         duration: Double = 1.0,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.isFront = isFront
        self._canShowFrontView = State(initialValue: isFront)
        self.duration = duration
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if self.canShowFrontView {
                front()
                    .background(.white)
                    .cornerRadius(20)
            }
            else {
                back()
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                
            }
        }
        .onChange(of: isFront, perform: {
            value in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration/2.0) {
                self.canShowFrontView = value
            }
        })
        .animation(nil)
        .rotation3DEffect(isFront ? Angle(degrees: 0): Angle(degrees: 900), axis: (x: CGFloat(0), y: CGFloat(1), z: CGFloat(0)))
        .animation(.easeInOut(duration: duration))
    }
}

