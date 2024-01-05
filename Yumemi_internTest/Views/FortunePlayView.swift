//
//  FortunePlayView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/21.
//　情報を入力して占いを実行するView

import SwiftUI
import CoreData
import AVFoundation
//　血液型のパターン定義
enum Blood_type: String, CaseIterable, Identifiable {
    case a
    case b
    case o
    case ab
    var blood_type: String {
        switch self {
        case .a: return "a"
        case .b: return "b"
        case .o: return "o"
        case .ab: return "ab"
        }
    }
    var id: Self {
        self
    }
}

struct FortunePlayView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var ViewModel = FortuneViewModel()
    @State private var isShowSwipe: Bool = false
    @State private var message: String = ""
    @State private var name: String = ""
    @State private var year: Int = 0000
    @State private var month: Int = 0
    @State private var day: Int = 0
    @State private var blood_type: Blood_type = .a
    @State private var opacity: Double = 0.0
    @State private var imgOffset: Double = 0.0
    @State private var slideOffset: Double = 0.0
    @State private var goUpSlide: Bool = false
    @State private var isResult: Bool = false
    private let PaperMusic = try! AVAudioPlayer(data: NSDataAsset(name: "submitPaperMusic")!.data)
    let ViewType: ViewTypeModel
    let viewModel: FortuneViewModel
    let coreDataModel = CoreDataModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var body: some View {
        if !isResult {
            ZStack {
                mainView
                    .onChange(of: slideOffset) { newValue in
                        if newValue > -400 {
                            if name.isEmpty {
                                message = "名前を入力してください"
                            } else {
                                withAnimation(.easeInOut(duration: 0.7)) {

                                    self.slideOffset = -1000
                                    PaperMusic.play()
                                    isShowSwipe = true
                                }
                                // 占いの実行
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    ViewModel.executionFortune(
                                        name: name,
                                        birthday: YearMonthDay(
                                            year: year + 1950,
                                            month: month + 1,
                                            day: day + 1
                                        ),
                                        blood_type: blood_type.blood_type,
                                        today: YearMonthDay(
                                            year: getCurrentTime().year ?? 1995,
                                            month: getCurrentTime().month ?? 12,
                                            day: getCurrentTime().day ?? 25
                                        )
                                    )

                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                                    実行できたらカードを表示させる
                                    isResult = true
                                }
                            }
                        }
                    }
                if !isShowSwipe {
                    Image("swipeImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(.top, 600)

                }

                Image("kartenImage")
                    .resizable()
                    .scaleEffect(1.2)
                    .offset(x: imgOffset)
                    .scaledToFill()
                    .ignoresSafeArea()
                    .padding(.top, 25)

            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    self.imgOffset = -UIScreen.main.bounds.width * 2
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isShowSwipe)

            .background(alignment: .center) {
                Image("tableImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .scaleEffect(1.01)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
        } else {
            ResultView(
                returnName: self.ViewModel.fortuneResults?.name ?? "滋賀県",
                returnCapital: self.ViewModel.fortuneResults?.capital ?? "大津市",
                returnCitizen_day: self.ViewModel.fortuneResults?.citizen_day ?? MonthDay(month: 0, day: 0),
                returnHas_coast_line: self.ViewModel.fortuneResults?.has_coast_line ?? false,
                returnLogo_url: self.ViewModel.fortuneResults?.logo_url,
                returnBrief: self.ViewModel.fortuneResults?.brief ?? "特になし",
                userName: name,
                ViewType: ViewType
            )
        }
    }
}

private extension FortunePlayView {
    //    占いの情報を入力するパーツ
    var mainView: some View {
        ZStack {
            Image("karteImage")
                .resizable()
                .scaledToFit()
                .padding(.leading, 40)

            VStack {
                TextField("田中太郎", text: $name)
                    .frame(width: 150, height: 35, alignment: .center)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 250)
                    .padding(.leading, 30)
                Text(message)
                    .foregroundStyle(.red)
                    .fontWeight(.black)
                    .padding(.leading, 30)
            }

            Picker(selection: $blood_type, label: Text("")) {
                ForEach(Blood_type.allCases) { blood in
                    Text("\(blood.blood_type)")
                }
            }
            .pickerStyle(.menu)
            .padding(.top, 240)
            birthday
                .frame(width: 300)
                .padding(.leading, 50)
                .fontWeight(.black)
        }
        .padding(.trailing, 30)
        .offset(y: slideOffset)
        .gesture(
            DragGesture().onChanged { value in
                self.slideOffset = value.translation.height
            }
        )
    }
    var birthday: some View {
        //        誕生日を入力するパーツ（長くなってしまったので切り出し）
        HStack {
            Picker(selection: self.$year, label: Text("年")){
                ForEach(1950..<2025){ _x in
                    Text("\(_x)")
                }
            }
            .foregroundStyle(.black)
            Picker(selection: self.$month, label: Text("月")){
                ForEach(1..<12){ _x in
                    Text("\(_x)")
                }
            }
            .frame(width: 100)
            .foregroundStyle(.black)
            Picker(selection: self.$day, label: Text("日")){
                if self.month != 1 {
                    ForEach(1..<32){ _x  in
                        Text("\(_x)")
                    }
                } else {
                    ForEach(1..<29){ _x in
                        Text("\(_x)")
                    }
                }
            }
        }
    }
    func getCurrentTime() -> DateComponents {
        //　　現在時刻を取得する
        let currentDate: Date = Date()
        let calender = Calendar.current
        let calComponent = calender.dateComponents([
            Calendar.Component.year,
            Calendar.Component.month,
            Calendar.Component.day
        ], from: currentDate)
        return calComponent
    }
}
