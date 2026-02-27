extension Collection {

    /// Returns `true` when the collection contains at least one element.
    ///
    /// Prefer this over `!collection.isEmpty` for readability.
    public var isNotEmpty: Bool {
        !isEmpty
    }
}

extension Collection where Index == Int {

    /// Returns the element at `index`, or `nil` if the index is out of bounds.
    ///
    /// ```swift
    /// let items = ["a", "b", "c"]
    /// items[safe: 1]  // "b"
    /// items[safe: 9]  // nil
    /// ```
    public subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
