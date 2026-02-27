#if canImport(UIKit)
import UIKit
import Darwin

// MARK: - DeviceInfo

/// A snapshot of the current device and app environment.
///
/// Use `DeviceInfo.current` to obtain a fresh snapshot whenever needed.
/// The struct is value-typed and `Sendable`, so it is safe to pass across
/// concurrency boundaries.
///
/// ```swift
/// let info = DeviceInfo.current
/// print(info.model)            // "iPhone 16 Pro"
/// print(info.appVersion)       // "1.2.0"
///
/// analyticsClient.send(info.analyticsProperties)
/// ```
public struct DeviceInfo: Sendable {

    // MARK: - Identity

    /// The human-readable marketing name of the device (e.g. `"iPhone 16 Pro"`).
    public let model: String

    /// The raw hardware model identifier (e.g. `"iPhone17,2"`).
    public let modelIdentifier: String

    /// The operating system name (e.g. `"iOS"`).
    public let systemName: String

    /// The operating system version string (e.g. `"18.3.1"`).
    public let systemVersion: String

    // MARK: - App

    /// The marketing version string from `CFBundleShortVersionString` (e.g. `"1.2.0"`).
    public let appVersion: String

    /// The build number from `CFBundleVersion` (e.g. `"42"`).
    public let buildNumber: String

    /// The app's bundle identifier (e.g. `"com.example.MyApp"`).
    public let bundleIdentifier: String

    // MARK: - Runtime

    /// `true` when the app is running in the iOS Simulator.
    public let isSimulator: Bool

    /// `true` when the app was compiled with the `DEBUG` flag.
    public let isDebugBuild: Bool

    /// `true` when the app was distributed via TestFlight.
    ///
    /// Detected using the sandbox receipt URL heuristic. For a cryptographically
    /// verified alternative, use `AppTransaction.shared` from StoreKit 2 in your app.
    public let isTestFlight: Bool

    /// The preferred language identifier as reported by the OS (e.g. `"en-GB"`).
    public let preferredLanguage: String

    /// The current time zone identifier (e.g. `"Europe/London"`).
    public let timezone: String

    // MARK: - Display

    /// The logical size of the main screen in points.
    public let screenSize: CGSize

    /// The native pixel scale of the main screen (e.g. `3.0` for Super Retina).
    public let screenScale: CGFloat

    /// `true` when the device is an iPad.
    public let isIPad: Bool

    // MARK: - Factory

    /// Creates a fresh snapshot of the current device and app environment.
    ///
    /// Call this once (e.g. at app launch) and store the result, or call it
    /// each time you need up-to-date values.
    @MainActor
    public static var current: DeviceInfo {
        DeviceInfo()
    }

    // MARK: - Analytics

    /// A flat `[String: String]` dictionary suitable for attaching to analytics events.
    ///
    /// All values are strings so they can be forwarded to any analytics backend
    /// without further conversion.
    public var analyticsProperties: [String: String] {
        [
            "device_model":         model,
            "device_model_id":      modelIdentifier,
            "os_name":              systemName,
            "os_version":           systemVersion,
            "app_version":          appVersion,
            "build_number":         buildNumber,
            "bundle_id":            bundleIdentifier,
            "is_simulator":         String(isSimulator),
            "is_debug":             String(isDebugBuild),
            "is_testflight":        String(isTestFlight),
            "language":             preferredLanguage,
            "timezone":             timezone,
            "screen_width":         String(format: "%.0f", screenSize.width),
            "screen_height":        String(format: "%.0f", screenSize.height),
            "screen_scale":         String(format: "%.1f", screenScale),
            "is_ipad":              String(isIPad),
        ]
    }

    // MARK: - Init

    @MainActor
    private init() {
        let device = UIDevice.current
        let screen = UIScreen.main
        let bundle = Bundle.main

        let rawIdentifier = Self.modelIdentifier()

        modelIdentifier = rawIdentifier
        model = DeviceModelResolver.resolve(rawIdentifier)
        systemName = device.systemName
        systemVersion = device.systemVersion
        isIPad = device.userInterfaceIdiom == .pad

        appVersion = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        buildNumber = bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        bundleIdentifier = bundle.bundleIdentifier ?? ""

        isSimulator = Self.isRunningInSimulator()
        isDebugBuild = Self.debugBuild()
        isTestFlight = Self.detectTestFlight(bundle: bundle)

        preferredLanguage = Locale.preferredLanguages.first ?? Locale.current.identifier
        timezone = TimeZone.current.identifier

        screenSize = screen.bounds.size
        screenScale = screen.scale
    }

    // MARK: - Private helpers

    private static func modelIdentifier() -> String {
        if Self.isRunningInSimulator() {
            return ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "arm64"
        }
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    private static func isRunningInSimulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    private static func debugBuild() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    private static func detectTestFlight(bundle: Bundle) -> Bool {
        // appStoreReceiptURL is deprecated in iOS 18 but remains the only
        // synchronous heuristic available. For a verified alternative, use
        // AppTransaction.shared from StoreKit 2 in your app layer.
        #if targetEnvironment(simulator)
        return false
        #else
        return bundle.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        #endif
    }
}
#endif
