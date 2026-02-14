//
//  ContentView.swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import SwiftUI
import Foundation
import Combine

struct ContentView: View {
    @State private var showingSettings = false
    @StateObject private var viewModel = TodoListViewModel(store: TodoStore())
    var body: some View {
        NavigationStack {
            TodoListView(viewModel: viewModel)
                .navigationTitle("Todos")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .accessibilityLabel("Settings")
                    }
                }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
}

#Preview {
    ContentView()
}
