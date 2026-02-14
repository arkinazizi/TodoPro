import SwiftUI

struct SettingsView: View {
    @AppStorage("showCompletedTasks") private var showCompletedTasks: Bool = true
    @AppStorage("enableNotifications") private var enableNotifications: Bool = false
    @AppStorage("appTheme") private var appTheme: String = "system" // values: system, light, dark

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("General") {
                    Toggle("Show Completed Tasks", isOn: $showCompletedTasks)
                }

                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $enableNotifications)
                        .tint(.accentColor)
                    if enableNotifications {
                        Text("Manage notification settings in iOS Settings > Notifications if needed.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Appearance") {
                    Picker("Theme", selection: $appTheme) {
                        Text("System").tag("system")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                }

                Section("About") {
                    LabeledContent("App") { Text("TodoPro") }
                    LabeledContent("Version") { Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-") }
                    LabeledContent("Build") { Text(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-") }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
