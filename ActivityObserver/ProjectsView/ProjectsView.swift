//
//  ProjectsView.swift
//  ActivityObserver
//
//  Created by Denis Svetlakov on 13.01.2021.
//

import SwiftUI

struct ProjectsView: View {
    
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingSortOrder = false
    
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool){
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors:[NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects)
        )
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(items(for: project)) { item in
                            ItemRowView(item: item)
                                .imageScale(.large)
                        }
                        .onDelete { offsets in
                            let allItems = project.projectItems
                            for offset in offsets {
                                let item = allItems[offset]
                                dataController.delete(item)
                            }
                            dataController.save()
                        }
                        if showClosedProjects == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label: {
                                Label("Add new item", systemImage: "plus")
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed projects" : "Opened projects")
            .toolbar {
                if showClosedProjects == false {
                    Button {
                        withAnimation {
                            let project = Project(context: managedObjectContext)
                            project.closed = false
                            project.creationDate = Date()
                            dataController.save()
                        }
                    } label: {
                        Label("Add project", systemImage: "plus")
                    }
                }
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                                .default(Text("Optimized"))  { }
                
                ])
            }
        }
    }
    
    func items(for project: Project) -> [Item] {
        []
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
