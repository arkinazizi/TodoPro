//
//  TodoListViewModel.swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class TodoListViewModel: ObservableObject {
    enum Filter: String, CaseIterable, Identifiable {
        case all = "All"
        case active = "Active"
        case done = "Done"
        var id: String { rawValue }
    }

    enum Sort: String, CaseIterable, Identifiable {
        case smart = "Smart"
        case dueDate = "Due Date"
        case priority = "Priority"
        case created = "Created"
        var id: String { rawValue }
    }

    @Published private(set) var items: [TodoItem] = []
    @Published var searchText: String = ""
    @Published var filter: Filter = .all
    @Published var sort: Sort = .smart

    @Published var isEditorPresented = false
    @Published var editingItem: TodoItem? = nil

    private let store: TodoStoreProtocol

    init(store: TodoStoreProtocol) {
        self.store = store
        Task { await load() }
    }

    var visibleItems: [TodoItem] {
        var result = items

        // filter
        switch filter {
        case .all: break
        case .active: result = result.filter { !$0.isDone }
        case .done: result = result.filter { $0.isDone }
        }

        // search
        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !q.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(q) ||
                $0.notes.localizedCaseInsensitiveContains(q)
            }
        }

        // sort
        switch sort {
        case .smart:
            // Active first, then dueDate soonest, then updatedAt desc
            result.sort {
                if $0.isDone != $1.isDone { return !$0.isDone && $1.isDone }
                let d0 = $0.dueDate ?? .distantFuture
                let d1 = $1.dueDate ?? .distantFuture
                if d0 != d1 { return d0 < d1 }
                return $0.updatedAt > $1.updatedAt
            }
        case .dueDate:
            result.sort { ($0.dueDate ?? .distantFuture) < ($1.dueDate ?? .distantFuture) }
        case .priority:
            result.sort { priorityRank($0.priority) > priorityRank($1.priority) }
        case .created:
            result.sort { $0.createdAt > $1.createdAt }
        }

        return result
    }

    func openCreate() {
        editingItem = nil
        isEditorPresented = true
    }

    func openEdit(_ item: TodoItem) {
        editingItem = item
        isEditorPresented = true
    }

    func upsert(_ item: TodoItem) {
        var newItem = item
        newItem.touch()

        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = newItem
        } else {
            items.insert(newItem, at: 0)
        }
        persist()
    }

    func toggleDone(_ item: TodoItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        var updated = items[idx]
        updated.isDone.toggle()
        updated.touch()
        items[idx] = updated
        persist()
    }

    func delete(at offsets: IndexSet) {
        let current = visibleItems
        let idsToDelete = offsets.map { current[$0].id }
        items.removeAll { idsToDelete.contains($0.id) }
        persist()
    }

    func delete(_ item: TodoItem) {
        items.removeAll { $0.id == item.id }
        persist()
    }

    func load() async {
        do {
            items = try await store.load()
        } catch {
            items = []
        }
    }

    private func persist() {
        let snapshot = items
        Task {
            do { try await store.save(snapshot) } catch { /* ignore */ }
        }
    }

    private func priorityRank(_ p: TodoPriority) -> Int {
        switch p {
        case .low: 1
        case .medium: 2
        case .high: 3
        }
    }
}

