#if canImport(UIKit)
import SwiftUI
import DeviceKit

// MARK: - DeviceInfoView

/// A SwiftUI view that displays all `DeviceInfo` properties in a grouped list.
///
/// Intended for use in dev/debug settings screens. Tap any row to copy its
/// value to the clipboard.
///
/// ```swift
/// // In your dev settings screen:
/// DeviceInfoView()
/// ```
public struct DeviceInfoView: View {

    private let info: DeviceInfo

    /// Creates the view using the current device info snapshot.
    @MainActor
    public init() {
        self.info = DeviceInfo.current
    }

    /// Creates the view with an explicit `DeviceInfo` value.
    ///
    /// Use this overload in previews or tests where you want to supply a
    /// pre-built snapshot rather than reading from the live device.
    public init(info: DeviceInfo) {
        self.info = info
    }

    public var body: some View {
        List {
            Section("Device") {
                InfoRow(label: "Model", value: info.model)
                InfoRow(label: "Model ID", value: info.modelIdentifier)
                InfoRow(label: "System", value: "\(info.systemName) \(info.systemVersion)")
                InfoRow(label: "iPad", value: info.isIPad ? "Yes" : "No")
                InfoRow(label: "Screen", value: "\(Int(info.screenSize.width)) × \(Int(info.screenSize.height)) @\(String(format: "%.0f", info.screenScale))x")
            }

            Section("App") {
                InfoRow(label: "Version", value: info.appVersion)
                InfoRow(label: "Build", value: info.buildNumber)
                InfoRow(label: "Bundle ID", value: info.bundleIdentifier)
            }

            Section("Runtime") {
                InfoRow(label: "Simulator", value: info.isSimulator ? "Yes" : "No")
                InfoRow(label: "Debug Build", value: info.isDebugBuild ? "Yes" : "No")
                InfoRow(label: "TestFlight", value: info.isTestFlight ? "Yes" : "No")
                InfoRow(label: "Language", value: info.preferredLanguage)
                InfoRow(label: "Timezone", value: info.timezone)
            }
        }
        .navigationTitle("Device Info")
    }
}

// MARK: - InfoRow

private struct InfoRow: View {

    let label: String
    let value: String

    @State private var copied = false

    var body: some View {
        Button {
            UIPasteboard.general.string = value
            withAnimation(.easeInOut(duration: 0.15)) { copied = true }
            Task {
                try? await Task.sleep(for: .seconds(1.5))
                withAnimation(.easeInOut(duration: 0.15)) { copied = false }
            }
        } label: {
            HStack {
                Text(label)
                    .foregroundStyle(.primary)
                Spacer()
                Text(copied ? "Copied!" : value)
                    .foregroundStyle(copied ? .green : .secondary)
                    .font(.footnote)
                    .monospaced()
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DeviceInfoView()
    }
}
#endif
