//
//  TodoRowView.swift .swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation
import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .symbolRenderingMode(.hierarchical)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    PriorityDot(priority: item.priority)

                    Text(item.title)
                        .font(.headline)
                        .strikethrough(item.isDone, color: .secondary)
                        .foregroundStyle(item.isDone ? .secondary : .primary)
                        .lineLimit(1)
                }

                HStack(spacing: 10) {
                    if !item.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(item.notes)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }

                    if let due = item.dueDate {
                        Label(due.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .labelStyle(.titleAndIcon)
                    }
                }
            }

            Spacer()
            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 10)
        .contentShape(Rectangle())
    }
}
