//
//      TodoItem.swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation
enum TodoPriority: String, Codable, CaseIterable, Identifiable {
    case low, medium, high
    var id: String { rawValue }

    var title: String {
        switch self {
        case .low: "Low"
        case .medium: "Medium"
        case .high: "High"
        }
    }
}

struct TodoItem: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var notes: String = ""
    var isDone: Bool = false
    var priority: TodoPriority = .medium
    var dueDate: Date? = nil
    var createdAt: Date = Date()
    var updatedAt: Date = Date()

    mutating func touch() { updatedAt = Date() }
}
