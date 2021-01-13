//
//  ActivityObserverApp.swift
//  ActivityObserver
//
//  Created by Denis Svetlakov on 12.01.2021.
//

import SwiftUI

@main
struct ActivityObserverApp: App {
    
    @StateObject var dataController: DataCotroller
    
    init() {
        let dataController = DataCotroller()
        _dataController = StateObject(wrappedValue: dataController)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
