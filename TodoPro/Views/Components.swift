//
//  Components.swift
//  TodoPro
//
//  Created by Arkin Azizi on 12.02.2026.
//

import Foundation

import SwiftUI

struct GlassHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(.white.opacity(0.08))
            )
            .shadow(radius: 10, y: 4)
    }
}

extension View {
    func glassHeader() -> some View { modifier(GlassHeader()) }
}

struct Pill: View {
    let text: String
    var isSelected: Bool

    var body: some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.primary.opacity(0.12) : Color.secondary.opacity(0.08),
                        in: Capsule())
            .overlay(Capsule().strokeBorder(.primary.opacity(isSelected ? 0.22 : 0.10)))
    }
}

struct PriorityDot: View {
    let priority: TodoPriority
    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .opacity(0.95)
            .overlay(Circle().strokeBorder(.white.opacity(0.25)))
            .foregroundStyle(style(for: priority))
    }

    private func style(for p: TodoPriority) -> some ShapeStyle {
        switch p {
        case .low: return AnyShapeStyle(.green)
        case .medium: return AnyShapeStyle(.orange)
        case .high: return AnyShapeStyle(.red)
        }
    }
}

struct EmptyStateView: View {
    let title: String
    let subtitle: String
    let actionTitle: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checklist")
                .font(.system(size: 44, weight: .semibold))
                .padding(.bottom, 6)

            Text(title)
                .font(.title2.weight(.bold))

            Text(subtitle)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 26)

            Button(actionTitle, action: action)
                .buttonStyle(.borderedProminent)
                .padding(.top, 6)
        }
        .padding(28)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(.white.opacity(0.08))
        )
        .padding(.horizontal, 20)
    }
}
struct FooterAttributionView: View {
    var body: some View {
        Text("Designed by Arkin")
            .font(.footnote.weight(.semibold))
            .foregroundStyle(.secondary)
            .padding(.vertical, 1)
            .frame(maxWidth: .infinity)
    }
}

