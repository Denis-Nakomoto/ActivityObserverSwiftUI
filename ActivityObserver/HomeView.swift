//
//  HomeView.swift
//  ActivityObserver
//
//  Created by Denis Svetlakov on 12.01.2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var dataController: DataCotroller
    
    var body: some View {
        NavigationView {
            VStack{
                Button ("Add data"){
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
                .navigationTitle("Home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
