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

    /// Returns a string truncated to at most `maxCharacters` characters.
    ///
    /// ```swift
    /// "Hello, world!".clipped(maxCharacters: 5)  // "Hello"
    /// "Hi".clipped(maxCharacters: 10)            // "Hi"
    /// ```
    public func clipped(maxCharacters: Int) -> String {
        String(prefix(maxCharacters))
    }

    /// Returns a copy of the string with every space replaced by an underscore.
    ///
    /// Useful for normalising analytics event keys.
    ///
    /// ```swift
    /// "hello world".replacingSpacesWithUnderscores()  // "hello_world"
    /// ```
    public func replacingSpacesWithUnderscores() -> String {
        replacingOccurrences(of: " ", with: "_")
    }

    /// Attempts to convert an arbitrary value to its `String` representation.
    ///
    /// Handles `String`, `Int`, `Double`, `Float`, `Bool`, `Date`, `[Any]`, and
    /// any `CustomStringConvertible`. Arrays are recursively converted, sorted,
    /// and joined with a comma. Returns `nil` for unrecognised types.
    ///
    /// Useful for serialising `[String: Any]` analytics dictionaries into
    /// flat string payloads.
    ///
    /// ```swift
    /// String.converting(42)          // "42"
    /// String.converting(true)        // "true"
    /// String.converting([1, 2, 3])   // "1,2,3"
    /// String.converting(Date())      // locale-formatted date+time string
    /// ```
    public static func converting(_ value: Any) -> String? {
        switch value {
        case let string as String:
            return string
        case let int as Int:
            return String(int)
        case let double as Double:
            return String(double)
        case let float as Float:
            return String(float)
        case let bool as Bool:
            return String(bool)
        case let date as Date:
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        case let array as [Any]:
            return array
                .compactMap { converting($0) }
                .sorted()
                .joined(separator: ",")
        case let describable as CustomStringConvertible:
            return describable.description
        default:
            return nil
        }
    }
}
