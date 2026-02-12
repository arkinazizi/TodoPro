//
//  TodoStore.swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation
protocol TodoStoreProtocol {
    func load() async throws -> [TodoItem]
    func save(_ items: [TodoItem]) async throws
}

final class TodoStore: TodoStoreProtocol {
    private let fileName = "todos.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(fileName)
    }

    func load() async throws -> [TodoItem] {
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            return []
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([TodoItem].self, from: data)
    }

    func save(_ items: [TodoItem]) async throws {
        let data = try JSONEncoder().encode(items)
        try data.write(to: fileURL, options: [.atomic])
    }
}
