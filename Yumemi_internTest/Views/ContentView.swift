//
//  ContentView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var ViewModel = FortuneViewModel()
    @State private var name: String = ""
    @State private var year: Int = 0000
    @State private var month: Int = 0
    @State private var day: Int = 0
    @State private var blood_type: Blood_type = .a
    @State private var returnName: String = ""
    @State private var returnCapital: String = ""
    @State private var returnCitizen_day: MonthDay = MonthDay(month: 12, day: 25)
    @State private var returnHas_coast_line: Bool = false
    @State private var returnLogo_url: String? = nil
    @State private var returnBrief: String = ""
    @State private var opacity: Double = 0.0
    @State private var imgOffset: Double = 0.0
    let ViewType: ViewTypeModel

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var body: some View {
        ZStack {
            VStack {
                Text("名前を入力してください")
                TextField("しゅうと", text: $name)

                Text("血液型を入力してください")
                Picker(selection: $blood_type, label: Text("")) {
                    ForEach(Blood_type.allCases) { blood in
                        Text("\(blood.blood_type)")
                    }
                }
                    .pickerStyle(.menu)
                    .padding(.top, 40)
                    Text("生年月日を入力してください")
                    HStack {
                        Picker(selection: self.$year, label: Text("年")){
                            ForEach(1950..<2025){ _x in
                                Text("\(_x)")
                            }
                        }
                        Picker(selection: self.$month, label: Text("月")){
                            ForEach(1..<12){ _x in
                                Text("\(_x)")
                            }
                        }
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
                    Button(action: {
                        let currentDate: Date = Date()
                        let calender = Calendar.current
                        let calComponent = calender.dateComponents([
                            Calendar.Component.year, Calendar.Component.month, Calendar.Component.day
                        ], from: currentDate)

                        ViewModel.executionFortune(
                            name: name,
                            birthday: YearMonthDay(
                                year: year + 1950,
                                month: month + 1,
                                day: day + 1
                            ),
                            blood_type: blood_type.blood_type,
                            today: YearMonthDay(
                                year: calComponent.year ?? 1995,
                                month: calComponent.month ?? 12,
                                day: calComponent.day ?? 25
                            )
                        )

                        //                self.ViewType.viewType = .firstPage
                    }, label: {
                        Text("送信")
                    })
                    if ViewModel.fortuneResults?.logo_url != nil {
                        AsyncImage(url: URL(string: (ViewModel.fortuneResults?.logo_url)!))
                    }
                }
            .padding(.trailing, 30)
            Image("kartenImage")
                .resizable()
                .offset(x: imgOffset)
                .scaledToFill()
                .ignoresSafeArea()
                .scaleEffect(1.2)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.7)) {
                   self.imgOffset = -UIScreen.main.bounds.width * 2
                 }
        }
        }

        //    private func addItem() {
        //        withAnimation {
        //            let newItem = Item(context: viewContext)
        //            newItem.timestamp = Date()
        //
        //            do {
        //                try viewContext.save()
        //            } catch {
        //                let nsError = error as NSError
        //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        //            }
        //        }
        //    }

        //    private func deleteItems(offsets: IndexSet) {
        //        withAnimation {
        //            offsets.map { items[$0] }.forEach(viewContext.delete)
        //
        //            do {
        //                try viewContext.save()
        //            } catch {
        //                let nsError = error as NSError
        //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        //            }
        //        }
        //    }
        //}

        //private let itemFormatter: DateFormatter = {
        //    let formatter = DateFormatter()
        //    formatter.dateStyle = .short
        //    formatter.timeStyle = .medium
        //    return formatter
        //}()
    }
