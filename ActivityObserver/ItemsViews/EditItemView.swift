//
//  EditItemView.swift
//  ActivityObserver
//
//  Created by Denis Svetlakov on 15.01.2021.
//

import SwiftUI

struct EditItemView: View {
    
    let item: Item
    
    @EnvironmentObject var dataController: DataController
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var competed: Bool
    
    init(item: Item){
        self.item = item
        _title = State(wrappedValue:  item.itemTitle)
        _detail = State(wrappedValue:  item.itemDetail)
        _priority = State(wrappedValue:  Int(item.priority))
        _competed = State(wrappedValue: item.completed)
    }
    
    var body: some View {
        Form {
            Section (header: Text("Basic settings")) {
                TextField("Item Name", text: $title.onChange(update))
                TextField("Description", text: $detail.onChange(update))
            }
            
            Section (header: Text("Priority")) {
                Picker("Priority", selection: $priority.onChange(update)) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Toggle ("Mark completed", isOn: $competed.onChange(update))
            }
        }
        .navigationTitle("Edit item")
        .onDisappear(perform: dataController.save)
    }
    
    func update() {
        item.project?.objectWillChange.send()
        
        item.title = title
        item.detail = detail
        item.priority = Int16(item.priority)
        item.completed = competed
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
