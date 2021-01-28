//
//  ProjectSummaryView.swift
//  ActivityObserver
//
//  Created by Denis Svetlakov on 21.01.2021.
//

import SwiftUI

struct ProjectSummaryView: View {

    @ObservedObject var project: Project

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(project.projectItems.count) itmes")
                .font(.caption)
                .foregroundColor(.secondary)

            Text((project.projectTitle))
                .font(.caption2)

            ProgressView(value: project.completionAmount)
                .accentColor(Color(project.projectColor))
        }
        .padding()
        .background(Color.secondarySystemGroupedBackground)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(project.label)
    }
}
