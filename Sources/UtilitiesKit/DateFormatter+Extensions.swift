import Foundation

extension DateFormatter {

    // MARK: - Thread-safe cache

    private nonisolated(unsafe) static var cache: [String: DateFormatter] = [:]
    private static let lock = NSLock()

    /// Returns a cached `DateFormatter` for the given format and locale, creating one if needed.
    ///
    /// `DateFormatter` is expensive to initialise. Use this factory instead of creating
    /// a new instance on every call site or inside computed properties.
    ///
    /// ```swift
    /// let formatter = DateFormatter.cached(format: "dd/MM/yyyy")
    /// let formatted = formatter.string(from: Date())
    /// ```
    ///
    /// - Parameters:
    ///   - format: A Unicode date format string (e.g. `"dd MMM yyyy"`).
    ///   - locale: The locale to use. Defaults to `Locale.current`.
    /// - Returns: A shared, cached `DateFormatter` instance.
    public static func cached(format: String, locale: Locale = .current) -> DateFormatter {
        let key = "\(format)_\(locale.identifier)"

        lock.lock()
        defer { lock.unlock() }

        if let existing = cache[key] {
            return existing
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        cache[key] = formatter
        return formatter
    }
}
