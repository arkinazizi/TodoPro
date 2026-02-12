//
//  TodoEditorView.swift .swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation
import SwiftUI

struct TodoEditorView: View {
    @Environment(\.dismiss) private var dismiss

    let initial: TodoItem?
    let onSave: (TodoItem) -> Void

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var isDone: Bool = false
    @State private var priority: TodoPriority = .medium
    @State private var hasDueDate: Bool = false
    @State private var dueDate: Date = Date()

    init(initial: TodoItem?, onSave: @escaping (TodoItem) -> Void) {
        self.initial = initial
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Task") {
                    TextField("Title", text: $title)
                    TextField("Notes (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Details") {
                    Picker("Priority", selection: $priority) {
                        ForEach(TodoPriority.allCases) { p in
                            Text(p.title).tag(p)
                        }
                    }

                    Toggle("Completed", isOn: $isDone)

                    Toggle("Due date", isOn: $hasDueDate.animation(.easeInOut))
                    if hasDueDate {
                        DatePicker("",
                                   selection: $dueDate,
                                   displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                    }
                }
            }
            .navigationTitle(initial == nil ? "New Todo" : "Edit Todo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        var item = initial ?? TodoItem(title: title)
                        item.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        item.notes = notes
                        item.isDone = isDone
                        item.priority = priority
                        item.dueDate = hasDueDate ? dueDate : nil
                        onSave(item)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                if let i = initial {
                    title = i.title
                    notes = i.notes
                    isDone = i.isDone
                    priority = i.priority
                    if let d = i.dueDate {
                        hasDueDate = true
                        dueDate = d
                    }
                }
            }
        }
    }
}
