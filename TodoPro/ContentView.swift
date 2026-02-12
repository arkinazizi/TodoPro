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
    @StateObject private var viewModel = TodoListViewModel(store: TodoStore())
    var body: some View {
        TodoListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
