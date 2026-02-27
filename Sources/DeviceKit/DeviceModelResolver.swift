import Foundation

/// Resolves a hardware model identifier (e.g. `"iPhone17,2"`) into a
/// human-readable marketing name (e.g. `"iPhone 16 Pro"`).
enum DeviceModelResolver {

    /// Returns the marketing name for a given model identifier, or the
    /// identifier itself if it isn't in the lookup table.
    static func resolve(_ identifier: String) -> String {
        modelMap[identifier] ?? identifier
    }

    // MARK: - Lookup table

    // swiftlint:disable:next closure_body_length
    private static let modelMap: [String: String] = [

        // MARK: iPhone 16
        "iPhone17,1": "iPhone 16 Pro",
        "iPhone17,2": "iPhone 16 Pro Max",
        "iPhone17,3": "iPhone 16",
        "iPhone17,4": "iPhone 16 Plus",

        // MARK: iPhone 15
        "iPhone16,1": "iPhone 15 Pro",
        "iPhone16,2": "iPhone 15 Pro Max",
        "iPhone15,4": "iPhone 15",
        "iPhone15,5": "iPhone 15 Plus",

        // MARK: iPhone 14
        "iPhone15,2": "iPhone 14 Pro",
        "iPhone15,3": "iPhone 14 Pro Max",
        "iPhone14,7": "iPhone 14",
        "iPhone14,8": "iPhone 14 Plus",

        // MARK: iPhone 13
        "iPhone14,2": "iPhone 13 Pro",
        "iPhone14,3": "iPhone 13 Pro Max",
        "iPhone14,4": "iPhone 13 mini",
        "iPhone14,5": "iPhone 13",

        // MARK: iPhone 12
        "iPhone13,1": "iPhone 12 mini",
        "iPhone13,2": "iPhone 12",
        "iPhone13,3": "iPhone 12 Pro",
        "iPhone13,4": "iPhone 12 Pro Max",

        // MARK: iPhone 11
        "iPhone12,1": "iPhone 11",
        "iPhone12,3": "iPhone 11 Pro",
        "iPhone12,5": "iPhone 11 Pro Max",

        // MARK: iPhone XS / XR
        "iPhone11,2": "iPhone XS",
        "iPhone11,4": "iPhone XS Max",
        "iPhone11,6": "iPhone XS Max (China)",
        "iPhone11,8": "iPhone XR",

        // MARK: iPhone X / 8
        "iPhone10,1": "iPhone 8",
        "iPhone10,2": "iPhone 8 Plus",
        "iPhone10,3": "iPhone X",
        "iPhone10,4": "iPhone 8",
        "iPhone10,5": "iPhone 8 Plus",
        "iPhone10,6": "iPhone X",

        // MARK: iPhone SE
        "iPhone14,6": "iPhone SE (3rd generation)",
        "iPhone12,8": "iPhone SE (2nd generation)",
        "iPhone8,4":  "iPhone SE (1st generation)",

        // MARK: iPad Pro (M-series)
        "iPad16,3": "iPad Pro 11-inch (M4)",
        "iPad16,4": "iPad Pro 11-inch (M4)",
        "iPad16,5": "iPad Pro 13-inch (M4)",
        "iPad16,6": "iPad Pro 13-inch (M4)",
        "iPad14,3": "iPad Pro 11-inch (M2)",
        "iPad14,4": "iPad Pro 11-inch (M2)",
        "iPad14,5": "iPad Pro 12.9-inch (M2)",
        "iPad14,6": "iPad Pro 12.9-inch (M2)",
        "iPad13,4": "iPad Pro 11-inch (M1)",
        "iPad13,5": "iPad Pro 11-inch (M1)",
        "iPad13,6": "iPad Pro 11-inch (M1)",
        "iPad13,7": "iPad Pro 11-inch (M1)",
        "iPad13,8": "iPad Pro 12.9-inch (M1)",
        "iPad13,9": "iPad Pro 12.9-inch (M1)",
        "iPad13,10": "iPad Pro 12.9-inch (M1)",
        "iPad13,11": "iPad Pro 12.9-inch (M1)",

        // MARK: iPad Air (M-series)
        "iPad16,1": "iPad Air 11-inch (M2)",
        "iPad16,2": "iPad Air 13-inch (M2)",
        "iPad14,8": "iPad Air 13-inch (M2)",
        "iPad14,9": "iPad Air 13-inch (M2)",
        "iPad13,16": "iPad Air (M1)",
        "iPad13,17": "iPad Air (M1)",

        // MARK: iPad mini
        "iPad16,7": "iPad mini (A17 Pro)",
        "iPad16,8": "iPad mini (A17 Pro)",
        "iPad14,1": "iPad mini (6th generation)",
        "iPad14,2": "iPad mini (6th generation)",

        // MARK: iPad (standard)
        "iPad13,18": "iPad (10th generation)",
        "iPad13,19": "iPad (10th generation)",
        "iPad12,1": "iPad (9th generation)",
        "iPad12,2": "iPad (9th generation)",

        // MARK: Simulator
        "i386":   "Simulator",
        "x86_64": "Simulator",
        "arm64":  "Simulator",
    ]
}
