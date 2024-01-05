//
//  FortuneMapview.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/26.
//  占いマップのView

import SwiftUI

struct FortuneMapview: View {
    let ViewType: ViewTypeModel
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var coreDataVM = CoreDataViewModel(coreDataModel: CoreDataModel())
    var body: some View {
        VStack  {
            ScrollView {
                VStack {
                    ForEach(coreDataVM.fortuneData) { data in
                        Mapstyle(logoUrl: data.logo_url, prefecture: data.prefecture, timeStamp: data.dateString, name: data.name)
                            .padding(.bottom, 30)
                    }
                }
                .padding(.top, 30)
                .frame(maxWidth: .infinity)
                
                .onAppear {
                    print("アピ")
                    coreDataVM.fetchData(context: context)
                }
                
            }
            .padding(.top, 50)
            .frame(height: 550)
            Text("メニュー画面へ戻る")
                .padding()
                .background(Color.white.cornerRadius(20))
                .fontWeight(.black)
                .onTapGesture {
                    ViewType.viewType = .menuPage
                }
        }
        .background {
            Image("rankingImage")
                .resizable()
                .scaledToFill()
            
        }
    }
}

