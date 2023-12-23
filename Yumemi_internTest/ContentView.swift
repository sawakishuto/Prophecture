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
    @State private var year: Int = 2022
    @State private var month: Int = 11
    @State private var day: Int = 11
    @State private var blood_type: String = "a"
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
                ViewModel.executionFortune(name: name,
                                           birthday: YearMonthDay(
                                            year: year,
                                            month: month,
                                            day: day
                                           ),
                                           blood_type: blood_type,
                                           today: YearMonthDay(year: 2021, month: 12, day: 12)
                )
            }, label: {
                Text("送信")
            })
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
