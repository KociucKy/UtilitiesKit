import Foundation

extension TimeInterval {

    /// The number of whole hours and remaining whole minutes represented by this interval.
    ///
    /// ```swift
    /// (7500.0).hoursAndMinutes  // (hours: 2, minutes: 5)
    /// (300.0).hoursAndMinutes   // (hours: 0, minutes: 5)
    /// ```
    public var hoursAndMinutes: (hours: Int, minutes: Int) {
        let totalMinutes = Int(self) / 60
        return (hours: totalMinutes / 60, minutes: totalMinutes % 60)
    }

    /// A localized, human-readable duration string using the system's own unit abbreviations.
    ///
    /// Uses `DateComponentsFormatter` so unit names ("h", "min", "St.", "ч" etc.) are provided
    /// by the OS and respect the device language — no hardcoded English strings.
    /// Zero-duration intervals produce a localized "0 min" equivalent.
    ///
    /// ```swift
    /// (0.0).formattedDuration       // "0 min" (locale-dependent)
    /// (300.0).formattedDuration     // "5 min"
    /// (7200.0).formattedDuration    // "2 hr."
    /// (7500.0).formattedDuration    // "2 hr. 5 min"
    /// ```
    public var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .dropAll

        if let result = formatter.string(from: self), !result.isEmpty {
            return result
        }

        // Fallback for exactly zero: formatter returns nil or "" for 0s with .dropAll
        let zeroFormatter = DateComponentsFormatter()
        zeroFormatter.unitsStyle = .abbreviated
        zeroFormatter.allowedUnits = [.minute]
        zeroFormatter.zeroFormattingBehavior = .pad
        return zeroFormatter.string(from: 0) ?? "0 min"
    }
}
