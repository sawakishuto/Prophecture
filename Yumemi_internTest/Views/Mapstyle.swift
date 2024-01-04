//
//  Mapstyle.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2024/01/05.
//

import SwiftUI

struct Mapstyle: View {
    let logoUrl: String
    let prefecture: String
    let timeStamp: String
    let name: String
    
    var body: some View {
        HStack {
        AsyncImage(url: URL(string: logoUrl)) { image in
            image.image?
                .resizable()
                .scaledToFit()
                .frame(width: 60)
        }
            VStack(alignment: .leading) {

                Text(timeStamp)
                    .font(.caption2)
                Text(name)
                    .font(.headline)
                    .fontWeight(.black)

                HStack(spacing: 0) {
                    Text("相性が良い")
                    Text("都道府県")
                        .foregroundStyle(.green)
                        .padding(.trailing)
                    Text(prefecture)
                        .fontWeight(.black)
                }
            }
    }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(Color.white.cornerRadius(20))
        .shadow(radius: 6)

    }
}


