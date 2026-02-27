import Foundation

extension Date {

    // MARK: - Day boundaries

    /// The first instant of the day containing this date, in the current calendar.
    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// The last instant of the day containing this date (23:59:59) in the current calendar.
    public var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }

    // MARK: - Relative checks

    /// Returns `true` if this date falls on today in the current calendar.
    public var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Returns `true` if this date falls on yesterday in the current calendar.
    public var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    // MARK: - Relative formatting

    /// A locale-aware relative string using the system's own localization.
    ///
    /// Produces strings like "Today", "Yesterday", or a locale-formatted date for older dates.
    /// The exact wording is provided by the OS and respects the device language — no hardcoded
    /// English strings.
    ///
    /// ```swift
    /// Date().formattedRelative()              // "Today" / "Dzisiaj" / "Heute" …
    /// Date(timeIntervalSinceNow: -86400).formattedRelative()  // "Yesterday" / "Wczoraj" …
    /// ```
    public func formattedRelative(locale: Locale = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        formatter.locale = locale
        return formatter.string(from: self)
    }

    // MARK: - Testing helpers

    /// Returns a random date within the past `daysBack` days.
    ///
    /// Useful for generating mock/preview data.
    public static func randomPast(daysBack: Int = 365) -> Date {
        let secondsBack = TimeInterval(daysBack * 24 * 60 * 60)
        let offset = TimeInterval.random(in: 0...secondsBack)
        return Date(timeIntervalSinceNow: -offset)
    }
}
