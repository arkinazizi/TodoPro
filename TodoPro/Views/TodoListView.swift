//
//  TodoListView.swift .swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation
import SwiftUI
import Combine

struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                // Subtle background
                LinearGradient(
                    colors: [.primary.opacity(0.03), .primary.opacity(0.01)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 12) {
                    header

                    if viewModel.visibleItems.isEmpty {
                        Spacer()
                        EmptyStateView(
                            title: viewModel.searchText.isEmpty ? "No tasks yet" : "No results",
                            subtitle: viewModel.searchText.isEmpty
                                ? "Add your first todo and keep things organized."
                                : "Try another keyword or change filters.",
                            actionTitle: "Add Todo",
                            action: { viewModel.openCreate() }
                        )
                        Spacer()
                    } else {
                        list
                    }
                }
                .padding(.top, 8)
            }
            .navigationTitle("Todos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.openCreate()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isEditorPresented) {
                TodoEditorView(initial: viewModel.editingItem) { item in
                    viewModel.upsert(item)
                }
            }
            .safeAreaInset(edge: .bottom) {
                FooterAttributionView()
                    .background(.thinMaterial)
            }
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.seal.fill")
                    .symbolRenderingMode(.hierarchical)
                    .font(.title3)

                TextField("Search todos…", text: $viewModel.searchText)
                    .textFieldStyle(.plain)

                Menu {
                    Picker("Sort", selection: $viewModel.sort) {
                        ForEach(TodoListViewModel.Sort.allCases) { s in
                            Text(s.rawValue).tag(s)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.headline)
                        .padding(8)
                }
                .buttonStyle(.plain)
            }

            HStack(spacing: 10) {
                ForEach(TodoListViewModel.Filter.allCases) { f in
                    Button {
                        withAnimation(.easeInOut) { viewModel.filter = f }
                    } label: {
                        Pill(text: f.rawValue, isSelected: viewModel.filter == f)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
        }
        .glassHeader()
        .padding(.horizontal, 14)
    }

    private var list: some View {
        List {
            ForEach(viewModel.visibleItems) { item in
                TodoRowView(item: item) {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                        viewModel.toggleDone(item)
                    }
                }
                .onTapGesture { viewModel.openEdit(item) }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        viewModel.toggleDone(item)
                    } label: {
                        Label(item.isDone ? "Undone" : "Done",
                              systemImage: item.isDone ? "arrow.uturn.left" : "checkmark")
                    }
                    .tint(.green)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        viewModel.delete(item)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .onDelete(perform: viewModel.delete)
        }
        .listStyle(.insetGrouped)
    }
}

