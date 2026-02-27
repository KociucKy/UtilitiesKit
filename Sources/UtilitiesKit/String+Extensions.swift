import Foundation

extension String {

    /// Returns `true` if the string is empty or contains only whitespace/newline characters.
    public var isBlank: Bool {
        allSatisfy(\.isWhitespace)
    }

    /// Returns `nil` if the string is blank, otherwise returns `self`.
    public var nilIfBlank: String? {
        isBlank ? nil : self
    }

    /// Returns the string with leading and trailing whitespace and newlines removed.
    public var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Returns up to `maxLength` uppercase initials derived from whitespace-separated words.
    ///
    /// ```swift
    /// "John Doe".initials()      // "JD"
    /// "Alice".initials()         // "A"
    /// "".initials()              // ""
    /// ```
    public func initials(maxLength: Int = 2) -> String {
        let words = split(separator: " ").prefix(maxLength)
        return words.compactMap(\.first).map { String($0).uppercased() }.joined()
    }
}
