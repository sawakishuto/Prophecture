//
//  ContentView.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2023/12/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var ViewModel = FortuneViewModel()
    @State private var name: String = ""
    @State private var year: Int = 0000
    @State private var month: Int = 0
    @State private var day: Int = 0
    @State private var blood_type: String = "a"
    @State private var returnName: String = ""
    @State private var returnCapital: String = ""
    @State private var returnCitizen_day: MonthDay = MonthDay(month: 12, day: 25)
    @State private var returnHas_coast_line: Bool = false
    @State private var returnLogo_url: String? = nil
    @State private var returnBrief: String = ""
    let ViewType: ViewTypeModel

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var body: some View {
        VStack {
            Text("名前を入力してください")
            TextField("しゅうと", text: $name)
            Text("血液型を入力してください")
            TextField("しゅうと", text: $blood_type)
            Text("生まれた年を入力してください")
            TextField("", value: $year, format: .number)
                .keyboardType(.numberPad)
            Text("生まれた月を入力してください")
            TextField("", value: $month, format: .number)
                .keyboardType(.numberPad)
            Text("生まれた日を入力してください")
            TextField("", value: $day, format: .number)
                .keyboardType(.numberPad)
            Button(action: {
                let currentDate: Date = Date()
                let calender = Calendar.current
                let calComponent = calender.dateComponents([
                    Calendar.Component.year, Calendar.Component.month, Calendar.Component.day
                ], from: currentDate)

                ViewModel.executionFortune(name: name,
                                           birthday: YearMonthDay(
                                            year: year,
                                            month: month,
                                            day: day
                                           ),
                                           blood_type: blood_type,
                                           today: YearMonthDay(
                                            year: calComponent.year ?? 1995,
                                            month: calComponent.month ?? 12,
                                            day: calComponent.day ?? 25
                                                              )
                )
                returnLogo_url = ViewModel.fortuneResults.logo_url
            }, label: {
                Text("送信")
            })

            if let Logo_url = returnLogo_url {
                AsyncImage(url: URL(string: Logo_url))
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
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
